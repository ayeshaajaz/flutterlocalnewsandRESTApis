from datetime import datetime

from django.conf import settings
from django.contrib.auth.models import AbstractUser
from django.db import models
from django.db.models.signals import post_save
from django.utils.translation import gettext_lazy as _
from model_utils.models import TimeStampedModel
from utils.file_utils import upload_user_media

class User(AbstractUser):
    """
    Write attributes which you often need for user like profile picture, age or gender.
    """
    GENDER_CHOICE = (
        ('male', 'Male'),
        ('female', 'Female'),
        ('none', 'Other')
    )
    gender = models.CharField(default='male', choices=GENDER_CHOICE, max_length=50)
    email = models.EmailField(_('email address'), blank=False, null=False, unique=True)
    photo = models.FileField(upload_to=upload_user_media, default='/static/image/avatar.png')


class Profile(TimeStampedModel):
    """
    Write attributes which you do not need often for user so that user model does not become too bulky
    """
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='user_profile')
    about = models.TextField(null=True, blank=True)
