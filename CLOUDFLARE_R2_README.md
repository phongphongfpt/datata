# Cloudflare R2 with Spring Boot REST API

This project demonstrates how to integrate Cloudflare R2 storage with a Spring Boot RESTful API. Cloudflare R2 is S3-compatible object storage, allowing you to use the AWS SDK for Java to interact with it.

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Configuration](#configuration)
- [Building the Project](#building-the-project)
- [Running the Application](#running-the-application)
- [API Endpoints](#api-endpoints)
- [Testing the API](#testing-the-api)
- [Architecture](#architecture)

## Overview

This sample application provides a REST API for file storage operations using Cloudflare R2:
- Upload files to R2 bucket
- Download files from R2 bucket
- List all files in R2 bucket
- Delete files from R2 bucket
- Check if a file exists

## Prerequisites

1. **Java 17** or higher
2. **Maven 3.6+**
3. **Cloudflare Account** with R2 enabled
4. **R2 Bucket** created in your Cloudflare dashboard
5. **R2 API Token** with read/write permissions

### Setting up Cloudflare R2

1. Log in to your Cloudflare dashboard
2. Navigate to **R2** from the sidebar
3. Create a new bucket (e.g., `my-app-bucket`)
4. Go to **R2 API Tokens** and create a new API token with:
   - Read and Write permissions
   - Note down your:
     - Access Key ID
     - Secret Access Key
     - Account ID

## Configuration

### 1. Update `application.yaml`

Edit `src/main/resources/application.yaml` with your R2 credentials:

```yaml
cloudflare:
  r2:
    account-id: YOUR_ACCOUNT_ID           # Your Cloudflare Account ID
    access-key-id: YOUR_ACCESS_KEY_ID     # R2 Access Key ID
    secret-access-key: YOUR_SECRET_KEY    # R2 Secret Access Key
    bucket-name: YOUR_BUCKET_NAME         # Your R2 bucket name
    endpoint: https://YOUR_ACCOUNT_ID.r2.cloudflarestorage.com
    region: auto
```

### 2. Using Environment Variables (Recommended for Production)

Instead of hardcoding credentials, use environment variables:

```yaml
cloudflare:
  r2:
    account-id: ${R2_ACCOUNT_ID}
    access-key-id: ${R2_ACCESS_KEY_ID}
    secret-access-key: ${R2_SECRET_ACCESS_KEY}
    bucket-name: ${R2_BUCKET_NAME}
    endpoint: https://${R2_ACCOUNT_ID}.r2.cloudflarestorage.com
    region: auto
```

Then set environment variables:
```bash
export R2_ACCOUNT_ID=your_account_id
export R2_ACCESS_KEY_ID=your_access_key_id
export R2_SECRET_ACCESS_KEY=your_secret_access_key
export R2_BUCKET_NAME=your_bucket_name
```

## Building the Project

Build the project using Maven:

```bash
mvn clean package
```

This will compile the code and create a JAR file in the `target` directory.

## Running the Application

### Using Maven:
```bash
mvn spring-boot:run
```

### Using the JAR file:
```bash
java -jar target/cloudflare-r2-demo-1.0.0.jar
```

The application will start on `http://localhost:8080`

## API Endpoints

### 1. Upload File
Upload a file to the R2 bucket.

**Endpoint:** `POST /api/r2/upload`

**Content-Type:** `multipart/form-data`

**Parameters:**
- `file` (required): The file to upload
- `key` (optional): Custom key/path for the file (defaults to original filename)

**Example using cURL:**
```bash
curl -X POST http://localhost:8080/api/r2/upload \
  -F "file=@/path/to/your/file.pdf" \
  -F "key=documents/myfile.pdf"
```

**Response:**
```json
{
  "key": "documents/myfile.pdf",
  "message": "File uploaded successfully",
  "url": "/api/r2/download/documents/myfile.pdf"
}
```

### 2. Download File
Download a file from the R2 bucket.

**Endpoint:** `GET /api/r2/download/{key}`

**Example:**
```bash
curl -O http://localhost:8080/api/r2/download/documents/myfile.pdf
```

### 3. List Files
List all files in the R2 bucket.

**Endpoint:** `GET /api/r2/list`

**Example:**
```bash
curl http://localhost:8080/api/r2/list
```

**Response:**
```json
[
  {
    "key": "documents/myfile.pdf",
    "size": 1024000,
    "lastModified": "2024-01-15T10:30:00Z",
    "eTag": "\"d41d8cd98f00b204e9800998ecf8427e\""
  },
  {
    "key": "images/photo.jpg",
    "size": 2048000,
    "lastModified": "2024-01-16T14:20:00Z",
    "eTag": "\"e2fc714c4727ee9395f324cd2e7f331f\""
  }
]
```

### 4. Delete File
Delete a file from the R2 bucket.

**Endpoint:** `DELETE /api/r2/delete/{key}`

**Example:**
```bash
curl -X DELETE http://localhost:8080/api/r2/delete/documents/myfile.pdf
```

**Response:**
```
File deleted successfully: documents/myfile.pdf
```

### 5. Check File Existence
Check if a file exists in the R2 bucket.

**Endpoint:** `GET /api/r2/exists/{key}`

**Example:**
```bash
curl http://localhost:8080/api/r2/exists/documents/myfile.pdf
```

**Response:**
```json
true
```

## Testing the API

### Using cURL

**1. Upload a file:**
```bash
curl -X POST http://localhost:8080/api/r2/upload \
  -F "file=@test.txt" \
  -F "key=test-files/test.txt"
```

**2. List all files:**
```bash
curl http://localhost:8080/api/r2/list
```

**3. Download the file:**
```bash
curl -O http://localhost:8080/api/r2/download/test-files/test.txt
```

**4. Check if file exists:**
```bash
curl http://localhost:8080/api/r2/exists/test-files/test.txt
```

**5. Delete the file:**
```bash
curl -X DELETE http://localhost:8080/api/r2/delete/test-files/test.txt
```

### Using Postman

1. **Upload File:**
   - Method: POST
   - URL: `http://localhost:8080/api/r2/upload`
   - Body: form-data
     - Key: `file` (Type: File)
     - Key: `key` (Type: Text, Optional)

2. **List Files:**
   - Method: GET
   - URL: `http://localhost:8080/api/r2/list`

3. **Download File:**
   - Method: GET
   - URL: `http://localhost:8080/api/r2/download/{key}`

4. **Delete File:**
   - Method: DELETE
   - URL: `http://localhost:8080/api/r2/delete/{key}`

## Architecture

### Project Structure
```
src/
├── main/
│   ├── java/com/example/r2demo/
│   │   ├── R2DemoApplication.java         # Main Spring Boot application
│   │   ├── config/
│   │   │   ├── R2Configuration.java       # S3Client bean configuration
│   │   │   └── R2Properties.java          # Configuration properties
│   │   ├── controller/
│   │   │   └── R2Controller.java          # REST endpoints
│   │   ├── service/
│   │   │   └── R2Service.java             # Business logic for R2 operations
│   │   └── model/
│   │       ├── FileInfo.java              # File metadata model
│   │       └── UploadResponse.java        # Upload response model
│   └── resources/
│       └── application.yaml               # Application configuration
└── test/
    └── java/com/example/r2demo/
```

### Key Components

#### 1. R2Properties
Configuration properties class that maps `application.yaml` values to Java objects.

#### 2. R2Configuration
Spring configuration class that creates and configures the AWS S3Client bean for Cloudflare R2.

#### 3. R2Service
Service layer containing business logic for:
- Uploading files
- Downloading files
- Listing files
- Deleting files
- Checking file existence

#### 4. R2Controller
REST controller exposing HTTP endpoints for file operations.

### Dependencies

The project uses the following main dependencies:

- **Spring Boot Starter Web**: For building REST APIs
- **AWS SDK for Java S3**: For S3-compatible operations with R2
- **Spring Boot Configuration Processor**: For type-safe configuration properties

See `pom.xml` for the complete list of dependencies.

## Important Notes

1. **S3 Compatibility**: Cloudflare R2 is fully S3-compatible, so we use the AWS SDK for Java (v2) to interact with it.

2. **Endpoint Configuration**: The key difference from AWS S3 is the endpoint URL format:
   ```
   https://<account-id>.r2.cloudflarestorage.com
   ```

3. **Region**: R2 doesn't use regions like AWS S3. Set it to `auto` or use any placeholder value.

4. **File Size Limits**: The default maximum file upload size is 10MB. You can adjust this in `application.yaml`:
   ```yaml
   spring:
     servlet:
       multipart:
         max-file-size: 50MB
         max-request-size: 50MB
   ```

5. **Security**: Never commit your API credentials to version control. Use environment variables or a secrets management system.

6. **CORS**: If you're accessing the API from a web frontend, you may need to configure CORS in your Spring Boot application.

## References

- [Cloudflare R2 Documentation](https://developers.cloudflare.com/r2/)
- [AWS SDK for Java S3 Client](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/examples-s3.html)
- [Spring Boot Documentation](https://spring.io/projects/spring-boot)

## Troubleshooting

### Common Issues

1. **Authentication Errors**: Verify your Access Key ID and Secret Access Key are correct.

2. **Bucket Not Found**: Ensure the bucket name matches exactly what you created in Cloudflare.

3. **Endpoint Issues**: Make sure your endpoint URL follows the correct format with your Account ID.

4. **File Upload Fails**: Check the file size doesn't exceed the configured maximum.

## License

This sample code is provided as-is for demonstration purposes.
