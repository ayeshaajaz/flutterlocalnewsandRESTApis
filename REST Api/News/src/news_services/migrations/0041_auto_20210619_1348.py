# Generated by Django 2.2.16 on 2021-06-19 13:48

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('news_services', '0040_auto_20210607_1259'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='directory',
            name='category',
        ),
        migrations.RemoveField(
            model_name='directory',
            name='user',
        ),
        migrations.RemoveField(
            model_name='directoryfavorite',
            name='directory',
        ),
        migrations.RemoveField(
            model_name='directoryfavorite',
            name='user',
        ),
        migrations.RemoveField(
            model_name='directoryhistory',
            name='directory',
        ),
        migrations.RemoveField(
            model_name='directoryhistory',
            name='user',
        ),
        migrations.RemoveField(
            model_name='directorytiming',
            name='directory',
        ),
        migrations.DeleteModel(
            name='Category',
        ),
        migrations.DeleteModel(
            name='Directory',
        ),
        migrations.DeleteModel(
            name='DirectoryFavorite',
        ),
        migrations.DeleteModel(
            name='DirectoryHistory',
        ),
        migrations.DeleteModel(
            name='DirectoryTiming',
        ),
    ]
