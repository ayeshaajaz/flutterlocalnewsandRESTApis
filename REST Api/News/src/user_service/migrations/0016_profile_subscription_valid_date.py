# Generated by Django 2.2.16 on 2021-05-09 08:45

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user_service', '0015_auto_20210509_1333'),
    ]

    operations = [
        migrations.AddField(
            model_name='profile',
            name='subscription_valid_date',
            field=models.DateField(blank=True, null=True, verbose_name='%m-%y-%d'),
        ),
    ]
