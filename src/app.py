import boto3
import os

session = boto3.Session( 
         aws_access_key_id=os.getenv('AWS_ACCESS_KEY'), 
         aws_secret_access_key=os.getenv('AWS_SECRET_KEY'))

s3 = session.resource('s3')

my_bucket = s3.Bucket('test-object-store')

for my_bucket_object in my_bucket.objects.all():
    print(my_bucket_object.key)