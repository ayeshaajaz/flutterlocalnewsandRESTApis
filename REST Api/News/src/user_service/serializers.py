from djoser.conf import settings as djsettings
from rest_framework import serializers
from .models import User, Profile
from djoser.compat import get_user_email, get_user_email_field_name
from utils.file_utils import get_file_path
from djoser.serializers import UserCreatePasswordRetypeSerializer


class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = '__all__'


class UserCreatePasswordRetypeCustomSerializer(UserCreatePasswordRetypeSerializer):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["first_name"] = serializers.CharField(
            required=True
        )
        self.fields["last_name"] = serializers.CharField(
            required=True
        )
        self.fields['gender'] = serializers.ChoiceField(
            default='none', choices=['male', 'female', 'none'],
            write_only=True
        )
        self.fields.pop('username', None)

    def create(self, validated_data):
        validated_data.update({
            'username': validated_data.get('email')
        })
        user = super().create(validated_data)
        user.is_active = True
        user.save()
        Profile.objects.get_or_create(user=user)
        return user


class UserCustomSerializer(serializers.ModelSerializer):
    about = serializers.CharField(max_length=500, default='', source='user_profile.about')

    class Meta:
        model = User
        fields = ('id', 'email', 'first_name', 'last_name', 'photo', 'gender', 'about')  # add this
        read_only_fields = ('username',)
        write_only_fields = ('password',)
        extra_kwargs = {
            'email': {
                'required': False
            }
        }

    def is_valid(self, raise_exception=False):
        if self.context.get('action') != 'me':
            if not self.initial_data.get('email'):
                raise serializers.ValidationError(
                    "Email is required"
                )
        return super(UserCustomSerializer, self).is_valid(raise_exception)

    def validate_email(self, email):
        if self.context.get('action') == 'me':
            if User.objects.filter(email=email).exclude(id=self.instance.id).exists():
                raise serializers.ValidationError(
                    "User with this email already exists"
                )
        else:
            if User.objects.filter(email=email).exists():
                raise serializers.ValidationError(
                    "User with this email already exists"
                )
        return email

    def update(self, instance, validated_data):
        profile_data = validated_data.pop('user_profile', {})
        email_field = get_user_email_field_name(User)
        if djsettings.SEND_ACTIVATION_EMAIL and email_field in validated_data:
            instance_email = get_user_email(instance)
            if instance_email != validated_data[email_field]:
                instance.is_active = False
                instance.save(update_fields=["is_active"])
        profile, _ = Profile.objects.get_or_create(user=instance)
        for field, value in profile_data.items():
            if hasattr(profile, field):
                setattr(profile, field, value)
        profile.save()
        return super().update(instance, validated_data)

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data.update({'photo': get_file_path(instance.photo)})
        user_profile, _ = Profile.objects.get_or_create(user=instance)
        profile = ProfileSerializer(user_profile).data
        data.update(profile)
        data.pop('user', None)
        return data
