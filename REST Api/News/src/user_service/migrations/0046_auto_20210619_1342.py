# Generated by Django 2.2.16 on 2021-06-19 13:42

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('user_service', '0045_user_next_billing_date'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='subscription',
            name='user',
        ),
        migrations.RemoveField(
            model_name='subscription',
            name='user_membership',
        ),
        migrations.RemoveField(
            model_name='subscriptionfeatures',
            name='subscription',
        ),
        migrations.RemoveField(
            model_name='subscriptionhistory',
            name='membership',
        ),
        migrations.RemoveField(
            model_name='subscriptionhistory',
            name='user',
        ),
        migrations.DeleteModel(
            name='TestResponse',
        ),
        migrations.RemoveField(
            model_name='usermembership',
            name='membership',
        ),
        migrations.RemoveField(
            model_name='usermembership',
            name='user',
        ),
        migrations.DeleteModel(
            name='Membership',
        ),
        migrations.DeleteModel(
            name='Subscription',
        ),
        migrations.DeleteModel(
            name='SubscriptionFeatures',
        ),
        migrations.DeleteModel(
            name='SubscriptionHistory',
        ),
        migrations.DeleteModel(
            name='UserMembership',
        ),
    ]
