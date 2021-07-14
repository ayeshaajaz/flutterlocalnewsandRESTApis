import math
from django.db.models import Q

from rest_framework import serializers
from .models import Category, Article
from user_service.serializers import UserCustomSerializer


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'


class ArticleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Article
        fields = '__all__'
        read_only_fields = ['user']

    def to_representation(self, instance):
        data = super(ArticleSerializer, self).to_representation(instance)
        data.update(self.get_detailed_data(instance))
        return data

    def get_detailed_data(self, instance):
        return {
            'category': CategorySerializer(instance.category).data,
            'user': UserCustomSerializer(instance.user).data
        }
