# Generated by Django 2.2.16 on 2021-04-19 09:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('news_services', '0023_auto_20210419_0939'),
    ]

    operations = [
        migrations.AlterField(
            model_name='directory',
            name='about',
            field=models.TextField(blank=True),
        ),
    ]