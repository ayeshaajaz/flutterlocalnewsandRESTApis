# Generated by Django 2.2.16 on 2021-04-06 11:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('news_services', '0015_auto_20210406_1042'),
    ]

    operations = [
        migrations.AlterField(
            model_name='directory',
            name='year_founded',
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
    ]