# Generated by Django 2.2.16 on 2021-04-19 09:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('news_services', '0022_directory_is_public'),
    ]

    operations = [
        migrations.AlterField(
            model_name='directory',
            name='phone_no',
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
    ]