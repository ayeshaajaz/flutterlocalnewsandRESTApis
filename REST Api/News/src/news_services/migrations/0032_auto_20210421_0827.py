# Generated by Django 2.2.16 on 2021-04-21 08:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('news_services', '0031_auto_20210421_0806'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='directoryfavorite',
            name='directory',
        ),
        migrations.AddField(
            model_name='directoryfavorite',
            name='directory',
            field=models.ManyToManyField(null=True, related_name='directory', to='news_services.Directory'),
        ),
    ]
