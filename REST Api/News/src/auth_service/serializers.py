from django.contrib.auth import authenticate, get_user_model
from django.contrib.auth.models import update_last_login
from rest_framework import serializers, exceptions, status
from rest_framework_simplejwt.serializers import (
    TokenObtainPairSerializer, login_rule, user_eligible_for_login
)
from rest_framework_simplejwt.settings import api_settings


class CustomTokenObtainSerializer(TokenObtainPairSerializer):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields.pop(self.username_field, None)
        self.fields['email'] = serializers.EmailField(required=True)

    def validate(self, attrs):
        authenticate_kwargs = {
            'password': attrs['password'],
            'email': attrs.get('email')
        }
        try:
            authenticate_kwargs['request'] = self.context['request']
        except KeyError:
            pass

        self.user = authenticate(**authenticate_kwargs)

        if not self.user:
            user = get_user_model().objects.filter(
                email=authenticate_kwargs.get('email'),
                is_active=False
            )
            if user.exists():
                raise exceptions.APIException(
                    "User is inactive. Plz activate your account then try again",
                    code=status.HTTP_403_FORBIDDEN
                )

        if not getattr(login_rule, user_eligible_for_login)(self.user):
            raise exceptions.AuthenticationFailed(
                self.error_messages['no_active_account'],
                'no_active_account',
            )
        data = {}
        refresh = self.get_token(self.user)

        data['refresh'] = str(refresh)
        data['access'] = str(refresh.access_token)

        if api_settings.UPDATE_LAST_LOGIN:
            update_last_login(None, self.user)

        return data