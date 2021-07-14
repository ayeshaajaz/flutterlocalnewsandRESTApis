from django.db import models
from user_service.models import User
from model_utils.models import TimeStampedModel
from utils.file_utils import upload_user_media


# Create your models here.

class Category(TimeStampedModel):
    name = models.CharField(max_length=255, null=False, blank=True)

    def __str__(self):
        return self.name


class Article(TimeStampedModel):
    category = models.ForeignKey(to=Category, on_delete=models.CASCADE, null=True)
    user = models.ForeignKey(to=User, on_delete=models.CASCADE, null=True)
    author = models.CharField(max_length=255, null=True, blank=True)
    title = models.CharField(max_length=255, null=False, blank=False)
    description = models.TextField(null=False, blank=False)
    photo = models.FileField(upload_to=upload_user_media, default='/static/image/news.png')
    website_url = models.URLField(max_length=250, null=True, blank=True)
    approved = models.BooleanField(default=False, blank=False, null=False)
