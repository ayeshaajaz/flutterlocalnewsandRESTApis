# Generated by Django 2.2.16 on 2021-06-03 06:33

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('user_service', '0042_auto_20210603_0617'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='subscription',
            name='user_id',
        ),
        migrations.AddField(
            model_name='subscription',
            name='user',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]
