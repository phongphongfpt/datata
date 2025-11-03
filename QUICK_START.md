# Quick Start Guide

This guide will help you get the Cloudflare R2 Spring Boot application up and running in minutes.

## Prerequisites

Before you begin, ensure you have:
- Java 17 or higher installed
- Maven 3.6+ installed
- A Cloudflare account with R2 enabled
- An R2 bucket created
- R2 API credentials (Access Key ID and Secret Access Key)

## Step 1: Configure R2 Credentials

Edit the `src/main/resources/application.yaml` file with your Cloudflare R2 credentials:

```yaml
cloudflare:
  r2:
    account-id: YOUR_ACCOUNT_ID
    access-key-id: YOUR_ACCESS_KEY_ID
    secret-access-key: YOUR_SECRET_ACCESS_KEY
    bucket-name: YOUR_BUCKET_NAME
    endpoint: https://YOUR_ACCOUNT_ID.r2.cloudflarestorage.com
    region: auto
```

Replace the following placeholders:
- `YOUR_ACCOUNT_ID`: Your Cloudflare Account ID (found in the R2 dashboard)
- `YOUR_ACCESS_KEY_ID`: Your R2 Access Key ID
- `YOUR_SECRET_ACCESS_KEY`: Your R2 Secret Access Key
- `YOUR_BUCKET_NAME`: The name of your R2 bucket

## Step 2: Build the Application

```bash
mvn clean package
```

This will compile the code and create an executable JAR file.

## Step 3: Run the Application

**Option A: Using Maven**
```bash
mvn spring-boot:run
```

**Option B: Using the JAR file**
```bash
java -jar target/cloudflare-r2-demo-1.0.0.jar
```

You should see output similar to:
```
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::                (v3.2.0)

... Starting R2DemoApplication ...
... Started R2DemoApplication in X.XXX seconds
```

The application is now running on `http://localhost:8080`

## Step 4: Test the API

### Test 1: List Files (Empty at first)
```bash
curl http://localhost:8080/api/r2/list
```

Expected output: `[]` (empty array)

### Test 2: Upload a Test File

First, create a test file:
```bash
echo "Hello, Cloudflare R2!" > test.txt
```

Then upload it:
```bash
curl -X POST http://localhost:8080/api/r2/upload \
  -F "file=@test.txt" \
  -F "key=quickstart/test.txt"
```

Expected output:
```json
{
  "key": "quickstart/test.txt",
  "message": "File uploaded successfully",
  "url": "/api/r2/download/quickstart/test.txt"
}
```

### Test 3: List Files Again
```bash
curl http://localhost:8080/api/r2/list
```

You should now see your uploaded file:
```json
[
  {
    "key": "quickstart/test.txt",
    "size": 23,
    "lastModified": "2024-XX-XXTXX:XX:XXZ",
    "eTag": "\"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\""
  }
]
```

### Test 4: Download the File
```bash
curl -O http://localhost:8080/api/r2/download/quickstart/test.txt
```

This will download the file as `test.txt` in your current directory.

### Test 5: Check if File Exists
```bash
curl http://localhost:8080/api/r2/exists/quickstart/test.txt
```

Expected output: `true`

### Test 6: Delete the File
```bash
curl -X DELETE http://localhost:8080/api/r2/delete/quickstart/test.txt
```

Expected output: `File deleted successfully`

## Troubleshooting

### Application fails to start

**Problem:** Error connecting to R2
- **Solution:** Verify your R2 credentials are correct in `application.yaml`
- **Solution:** Ensure your R2 bucket exists and the name is correct

**Problem:** Port 8080 already in use
- **Solution:** Change the port in `application.yaml`:
  ```yaml
  server:
    port: 8081
  ```

### Upload fails

**Problem:** File too large
- **Solution:** Increase the max file size in `application.yaml`:
  ```yaml
  spring:
    servlet:
      multipart:
        max-file-size: 50MB
        max-request-size: 50MB
  ```

**Problem:** Authentication error
- **Solution:** Verify your R2 Access Key ID and Secret Access Key are correct
- **Solution:** Ensure your R2 API token has read and write permissions

### Download fails

**Problem:** File not found (404)
- **Solution:** Verify the file key is correct (case-sensitive)
- **Solution:** Use the list endpoint to see available files

## Next Steps

Now that you have the basic application running:

1. **Explore the API**: Try uploading different file types (images, PDFs, videos)
2. **Test nested paths**: Upload files with paths like `documents/2024/report.pdf`
3. **Read the full documentation**: See [CLOUDFLARE_R2_README.md](./CLOUDFLARE_R2_README.md) for detailed API documentation
4. **Try the examples**: Check [API_EXAMPLES.md](./API_EXAMPLES.md) for more usage examples including Python and Node.js

## Using with Postman

1. Import the following endpoints into Postman:
   - POST `http://localhost:8080/api/r2/upload`
   - GET `http://localhost:8080/api/r2/list`
   - GET `http://localhost:8080/api/r2/download/{key}`
   - DELETE `http://localhost:8080/api/r2/delete/{key}`
   - GET `http://localhost:8080/api/r2/exists/{key}`

2. For the upload endpoint:
   - Select `Body` → `form-data`
   - Add key `file` with type `File`, select your file
   - Add key `key` with type `Text`, enter the desired path

## Security Considerations

- **Never commit credentials**: Use environment variables or a secrets manager in production
- **Use HTTPS**: Always use HTTPS in production to protect credentials in transit
- **Validate inputs**: The application includes input validation, but always validate on the frontend too
- **Rate limiting**: Consider adding rate limiting for production use
- **Access control**: Implement authentication and authorization for production deployments

## Need Help?

- **Full Documentation**: See [CLOUDFLARE_R2_README.md](./CLOUDFLARE_R2_README.md)
- **API Examples**: See [API_EXAMPLES.md](./API_EXAMPLES.md)
- **Cloudflare R2 Docs**: https://developers.cloudflare.com/r2/
- **AWS SDK Docs**: https://docs.aws.amazon.com/sdk-for-java/

Enjoy using Cloudflare R2 with Spring Boot! 🚀
