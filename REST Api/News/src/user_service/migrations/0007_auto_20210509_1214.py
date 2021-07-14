# Generated by Django 2.2.16 on 2021-05-09 07:14

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('user_service', '0006_auto_20210509_1210'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='subscriptiontable',
            name='annually_cost',
        ),
        migrations.RemoveField(
            model_name='subscriptiontable',
            name='monthly_cost',
        ),
        migrations.RemoveField(
            model_name='subscriptiontable',
            name='name',
        ),
        migrations.AlterField(
            model_name='subscriptionfeatures',
            name='subscription',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='user_service.SubscriptionTable'),
        ),
        migrations.AlterField(
            model_name='subscriptionhistory',
            name='subscription',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='user_service.SubscriptionTable'),
        ),
    ]
