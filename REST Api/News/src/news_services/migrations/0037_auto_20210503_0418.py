# Generated by Django 2.2.16 on 2021-05-03 04:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('news_services', '0036_auto_20210427_0448'),
    ]

    operations = [
        migrations.DeleteModel(
            name='EmploymentApiHistory',
        ),
        migrations.AddField(
            model_name='directory',
            name='employee_department_name',
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
        migrations.AddField(
            model_name='directory',
            name='employee_external_id',
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
    ]
