# Generated by Django 2.2.16 on 2021-05-25 04:57

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user_service', '0024_subscription_token'),
    ]

    operations = [
        migrations.AddField(
            model_name='subscription',
            name='created_date',
            field=models.DateTimeField(blank=True, max_length=50, null=True),
        ),
        migrations.AddField(
            model_name='subscription',
            name='next_billing_date',
            field=models.DateTimeField(blank=True, max_length=50, null=True),
        ),
    ]