# hosting a website in AWS S3

Create a new bucket. This bucket hosts the actual content.
```
aws s3 mb s3://www.example.com
```

Set up website configuration for it. This indicates the index and error documents.
```
aws s3api put-bucket-website --bucket www.example.com --website-configuration file://./www.example.com.website.json
```

Set policy for this bucket for reading by all public.
```
aws s3api put-bucket-policy --bucket www.example.com --policy file://./www.example.com.policy.json
```

Sync the folder to the bucket.
```
aws s3 sync ./site_content/ s3://www.example.com --exclude ".git/*"
```

Optional, create a new bucket for redirecting to the content. In this case, example.com -> www.example.com.
```
aws s3 mb s3://example.com
```

Set up website configuration for redirection.
```
aws s3api put-bucket-website --bucket example.com --website-configuration file://./example.com.website.json
```

Optional, hosting a custom domain requires a hosted zone.
```
aws route53 create-hosted-zone --name example.com --caller-reference "create example.com"
```

This json document contains all UPSERT operations to update the hosted zone.
```
aws route53 change-resource-record-sets --hosted-zone-id Z9T46LYERHDYH --change-batch file://./example.com/example.com.dns.json
```
