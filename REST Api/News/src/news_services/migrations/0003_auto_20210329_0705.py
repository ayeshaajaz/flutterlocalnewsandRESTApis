# Generated by Django 2.2.16 on 2021-03-29 07:05

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('news_services', '0002_auto_20210324_0928'),
    ]

    operations = [
        migrations.DeleteModel(
            name='SubscriptionFeatures',
        ),
        migrations.RemoveField(
            model_name='subscriptionhistory',
            name='subscription_id',
        ),
        migrations.RemoveField(
            model_name='subscriptionhistory',
            name='user_id',
        ),
        migrations.RemoveField(
            model_name='userprofile',
            name='subscription_id',
        ),
        migrations.RemoveField(
            model_name='userprofile',
            name='user_id',
        ),
        migrations.DeleteModel(
            name='Subscription',
        ),
        migrations.DeleteModel(
            name='SubscriptionHistory',
        ),
        migrations.DeleteModel(
            name='UserProfile',
        ),
    ]
