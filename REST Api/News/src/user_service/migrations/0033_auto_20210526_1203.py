# Generated by Django 2.2.16 on 2021-05-26 07:03

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('user_service', '0032_auto_20210526_1033'),
    ]

    operations = [
        migrations.RenameField(
            model_name='subscriptionhistory',
            old_name='membership_id',
            new_name='membership',
        ),
    ]
