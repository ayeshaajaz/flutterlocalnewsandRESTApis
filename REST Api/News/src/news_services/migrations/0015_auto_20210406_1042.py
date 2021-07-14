# Generated by Django 2.2.16 on 2021-04-06 10:42

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('news_services', '0014_auto_20210406_0910'),
    ]

    operations = [
        migrations.AlterField(
            model_name='directory',
            name='employee_designation_code',
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
        migrations.AlterField(
            model_name='directory',
            name='year_founded',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='directorytiming',
            name='day',
            field=models.IntegerField(choices=[(1, 'Monday'), (2, 'Tuesday'), (3, 'Wednesday'), (4, 'Thursday'), (5, 'Friday'), (6, 'Saturday'), (7, 'Sunday')]),
        ),
    ]
