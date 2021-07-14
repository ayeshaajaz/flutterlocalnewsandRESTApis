from datetime import datetime, date

from django.shortcuts import redirect
from django.db.models import Q
from djoser import views as djoser_views
from rest_framework.parsers import JSONParser, MultiPartParser, FormParser
from rest_framework import generics, status, pagination
from rest_framework import response
from django.conf import settings
from django.views.decorators.csrf import csrf_exempt
from .models import User
from utils.permissions import IsAppAdmin, IsNonAdminUser
import json
from django.http import HttpResponse
from rest_framework.decorators import api_view


class DjUserViews(djoser_views.UserViewSet):
    parser_classes = (JSONParser, FormParser, MultiPartParser)

    def get_serializer_context(self):
        context = super(DjUserViews, self).get_serializer_context()
        context.update({'action': self.action})
        return context
