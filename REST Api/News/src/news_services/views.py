from django.shortcuts import render
from datetime import datetime
from django.http import HttpResponse
from rest_framework import generics, status, pagination
from rest_framework import response
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from utils.permissions import IsAppAdmin, IsNonAdminUser
from rest_framework import filters
from django.db.models import Q
from .models import Category, Article
from .serializers import CategorySerializer, ArticleSerializer
from django.db import connection
from rest_framework.parsers import JSONParser, MultiPartParser, FormParser


# Create your views here.
class CategoryView(generics.GenericAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    permission_classes = [IsAppAdmin | IsNonAdminUser]



    def get(self, request, *args, **kwargs):
        category = Category.objects.all()
        paginated_response = self.paginate_queryset(category)
        serialized = self.get_serializer(paginated_response, many=True)
        return self.get_paginated_response(serialized.data)

    def post(self, request, *arg, **kwargs):
        user = request.user
        if not user.is_superuser:
            return response.Response("You're not Allowed to use this method", status=status.HTTP_405_METHOD_NOT_ALLOWED)
            
        f_name = request.GET.get('name')
        serialized = self.get_serializer(data=request.data)
        if Category.objects.filter(name=f_name).exists():
            return response.Response("Already exist this category")
        else:
            if serialized.is_valid():
                serialized.save()
                return response.Response(serialized.data, status=status.HTTP_201_CREATED)
            return response.Response("Data is not valid", serialized.errors)


class CategoryViewDetails(generics.GenericAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    permission_classes = []

    def get_permissions(self):
        if self.request.method != 'GET':
            self.permission_classes = [IsAppAdmin]
        return super().get_permissions()

    def get(self, request, *args, **kwargs):
        if kwargs.get('pk'):
            category = Category.objects.get(pk=kwargs.get('pk'))
            serialized = self.get_serializer(category)
            return response.Response(serialized.data, status=status.HTTP_200_OK)

    def put(self, request, *args, **kwargs):
        if kwargs.get("pk"):
            category = Category.objects.get(pk=kwargs.get('pk'))
            serialized = self.get_serializer(category, data=request.data)
            if serialized.is_valid():
                serialized.save()
                return response.Response(serialized.data, status=status.HTTP_204_NO_CONTENT)
            return response.Response(serialized.errors)
        return response.Response(status=status.HTTP_405_METHOD_NOT_ALLOWED)

    def delete(self, request, *args, **kwargs):
        if kwargs.get('pk'):
            category = Category.objects.get(pk=kwargs.get('pk'))
            category.delete()
            return response.Response(status=status.HTTP_204_NO_CONTENT)
        return response.Response(status=status.HTTP_405_METHOD_NOT_ALLOWED)


class ArticleView(generics.GenericAPIView):
    queryset = Article.objects.all()
    serializer_class = ArticleSerializer
    parser_classes = (FormParser, MultiPartParser)
    permission_classes = []

    def get_permissions(self):
        if self.request.method != 'GET':
            self.permission_classes = [IsAppAdmin | IsNonAdminUser]
        return super().get_permissions()

    @swagger_auto_schema(manual_parameters=[
        openapi.Parameter('search', openapi.IN_QUERY,
                          description='Search by category name',
                          type=openapi.TYPE_STRING, required=False, default=None)

    ])
    def get(self, request, *args, **kwargs):
        filters = {}
        search = request.GET.get('search', '')
        try:
            check_category = Category.objects.get(name__iexact=search)
            check_category = check_category.id

        except Category.DoesNotExist:
            check_category = None
        if check_category:
            filters.update({'category__id': check_category})

        if filters:
            article = Article.objects.filter(Q(**filters) & Q(approved=True))
        else:
            article = Article.objects.filter(approved=True).order_by('created')

        paginated_response = self.paginate_queryset(article)
        serialized = self.get_serializer(paginated_response, many=True)
        return self.get_paginated_response(serialized.data)

    def post(self, request, *args, **kwargs):

        user = request.user
        serialized = self.get_serializer(data=request.data)
        if serialized.is_valid():
            serialized.validated_data['user_id'] = user.id
            serialized.save()
            return response.Response(status=status.HTTP_201_CREATED)
        return response.Response(serialized.errors)


class AdminView(generics.GenericAPIView):
    queryset = Article.objects.all()
    serializer_class = ArticleSerializer
    permission_classes = [IsAppAdmin | IsNonAdminUser]

    @swagger_auto_schema(manual_parameters=[
        openapi.Parameter('Article', openapi.IN_QUERY,
                          description='approved or pending',
                          type=openapi.TYPE_STRING, required=False, default=None)

    ])
    def get(self, request, *args, **kwargs):
        article = request.GET.get('Article')
        user = request.user
        if not user.is_superuser:
            return response.Response("You're not Allowed to use this method", status=status.HTTP_405_METHOD_NOT_ALLOWED)

        if article == 'approved':
            article = Article.objects.filter(approved=True).order_by('created')
        elif article == 'pending':
            article = Article.objects.filter(approved=False).order_by('created')
        else:
            article = Article.objects.all().order_by('created')

        paginated_response = self.paginate_queryset(article)
        serialized = self.get_serializer(paginated_response, many=True)
        return self.get_paginated_response(serialized.data)


class AdminViewDetails(generics.GenericAPIView):
    queryset = Article.objects.all()
    serializer_class = ArticleSerializer
    permission_classes = [IsAppAdmin | IsNonAdminUser]

    def get(self, request, *args, **kwargs):
        user = request.user
        if not user.is_superuser:
            return response.Response("You're not Allowed to use this method", status=status.HTTP_405_METHOD_NOT_ALLOWED)

        if kwargs.get('pk'):
            try:
                article = Article.objects.get(pk=kwargs.get('pk'))
                serialized = self.get_serializer(article)
                return response.Response(serialized.data, status=status.HTTP_200_OK)
            except:
                return response.Response("No Article Found", status=status.HTTP_404_NOT_FOUND)
        return response.Response(status=status.HTTP_204_NO_CONTENT)

    def patch(self, request, *args, **kwargs):
        user = request.user
        if not user.is_superuser:
            return response.Response("You're not Allowed to use this method", status=status.HTTP_405_METHOD_NOT_ALLOWED)

        if kwargs.get('pk'):
            try:
                article = Article.objects.get(pk=kwargs.get('pk'))
                d = request.data['approved']
                print(d)
                serialized = self.get_serializer(article, data=request.data, partial=True)
                if serialized.is_valid():
                    serialized.save()
                    return response.Response(serialized.data, status=status.HTTP_200_OK)
                return response.Response(serialized.errors)
            except:
                return response.Response("You can't Edit this article")
        return response.Response(status=status.HTTP_405_METHOD_NOT_ALLOWED)

    def delete(self, request, *args, **kwargs):
        user = request.user
        if not user.is_superuser:
            return response.Response("You're not Allowed to use this method", status=status.HTTP_405_METHOD_NOT_ALLOWED)

        if kwargs.get('pk'):
            try:
                user_article = Article.objects.get(pk=kwargs.get('pk'))
                user_article.delete()
                return response.Response(status=status.HTTP_204_NO_CONTENT)
            except:
                return response.Response("You can't delete this article")
        return response.Response(status=status.HTTP_405_METHOD_NOT_ALLOWED)


class UserArticle(generics.GenericAPIView):
    queryset = Article.objects.all()
    serializer_class = ArticleSerializer
    permission_classes = []

    def get_permissions(self):
        if self.request.method == 'GET':
            self.permission_classes = [IsAppAdmin | IsNonAdminUser]
        return super().get_permissions()

    def get(self, request, *args, **kwargs):
        user = request.user
        try:
            queryset = self.queryset.filter(Q(user_id=user.id) & Q(approved=True))
            paginated_response = self.paginate_queryset(queryset)
            serialized = self.get_serializer(paginated_response, many=True)

            return self.get_paginated_response(serialized.data)

        except Article.DoesNotExist:
            return response.Response("No Article Found", status=status.HTTP_404_NOT_FOUND)


class UserArticleDetails(generics.GenericAPIView):
    queryset = Article.objects.all()
    serializer_class = ArticleSerializer
    permission_classes = [IsAppAdmin | IsNonAdminUser]

    def get(self, request, *args, **kwargs):
        user = request.user
        if kwargs.get('pk'):
            try:
                article = Article.objects.get(Q(pk=kwargs.get('pk')) & Q(user_id=user.id) & Q(approved=True))
                serialized = self.get_serializer(article)
                return response.Response(serialized.data, status=status.HTTP_200_OK)
            except:
                return response.Response("This article doesn't belongs to you", status=status.HTTP_404_NOT_FOUND)
        return response.Response(status=status.HTTP_204_NO_CONTENT)

    def put(self, request, *args, **kwargs):
        user = request.user
        if kwargs.get('pk'):
            try:
                article = Article.objects.get(Q(pk=kwargs.get('pk')) & Q(user_id=user.id))
                serialized = self.get_serializer(article, data=request.data)
                if serialized.is_valid():
                    serialized.validated_data['approved'] = False
                    serialized.save()
                    return response.Response(serialized.data, status=status.HTTP_204_NO_CONTENT)
                return response.Response(serialized.errors)
            except:
                return response.Response("You can't Edit this article")
        return response.Response(status=status.HTTP_405_METHOD_NOT_ALLOWED)

    '''def patch(self, request, *args, **kwargs):
        user = request.user
        print(user.id)
        if kwargs.get('pk'):
            try:
                article = Article.objects.get(Q(pk=kwargs.get('pk')) & Q(user_id=user.id))
                serialized = self.get_serializer(article, data=request.data, partial=True)
                if serialized.is_valid():
                    serialized.save()
                    return response.Response(serialized.data, status=status.HTTP_200_OK)
                return response.Response(serialized.errors)
            except:
                return response.Response("You can't Edit this article")
        return response.Response(status=status.HTTP_405_METHOD_NOT_ALLOWED)'''

    def delete(self, request, *args, **kwargs):
        user = request.user
        if kwargs.get('pk'):
            try:
                user_article = Article.objects.get(Q(pk=kwargs.get('pk')) & Q(user_id=user.id))
                user_article.delete()
                return response.Response(status=status.HTTP_204_NO_CONTENT)
            except:
                return response.Response("You can't delete this article")
        return response.Response(status=status.HTTP_405_METHOD_NOT_ALLOWED)
