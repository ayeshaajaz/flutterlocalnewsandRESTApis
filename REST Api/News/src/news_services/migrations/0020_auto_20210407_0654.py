# Generated by Django 2.2.16 on 2021-04-07 06:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('news_services', '0019_auto_20210407_0650'),
    ]

    operations = [
        migrations.AlterField(
            model_name='directory',
            name='about',
            field=models.TextField(),
        ),
    ]
