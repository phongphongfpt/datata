# datata

## Cloudflare R2 Spring Boot Integration

This repository contains a sample Spring Boot RESTful API implementation that demonstrates how to integrate with Cloudflare R2 storage service.

### Overview

Cloudflare R2 is an S3-compatible object storage service. This project provides a complete working example of:
- Spring Boot REST API with file operations
- AWS SDK S3 client integration for Cloudflare R2
- Upload, download, list, and delete file endpoints
- Proper configuration and documentation

### Quick Start

See [CLOUDFLARE_R2_README.md](./CLOUDFLARE_R2_README.md) for detailed setup instructions and API usage.

### Features

- **Upload Files**: POST endpoint to upload files to R2
- **Download Files**: GET endpoint to download files from R2
- **List Files**: GET endpoint to list all files in R2 bucket
- **Delete Files**: DELETE endpoint to remove files from R2
- **File Existence Check**: GET endpoint to verify if a file exists

### Project Structure

```
src/
├── main/
│   ├── java/com/example/r2demo/
│   │   ├── config/          # R2 configuration
│   │   ├── controller/      # REST endpoints
│   │   ├── service/         # Business logic
│   │   └── model/           # Data models
│   └── resources/
│       └── application.yaml # Configuration
└── test/
    └── java/com/example/r2demo/
```

### Building and Running

1. Configure your R2 credentials in `src/main/resources/application.yaml`
2. Build: `mvn clean package`
3. Run: `mvn spring-boot:run` or `java -jar target/cloudflare-r2-demo-1.0.0.jar`
4. Access API at `http://localhost:8080/api/r2`

### Documentation

- **[CLOUDFLARE_R2_README.md](./CLOUDFLARE_R2_README.md)**: Complete documentation with:
  - Prerequisites and setup
  - Configuration details
  - API endpoint examples with cURL commands
  - Architecture overview
  - Troubleshooting guide

### Technologies

- Java 17
- Spring Boot 3.2.0
- AWS SDK for Java 2.21.0 (S3 client)
- Maven
- Cloudflare R2

### References

- [Cloudflare R2 Documentation](https://developers.cloudflare.com/r2/)
- [AWS SDK for Java S3 Client](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/examples-s3.html)
- [Spring Boot Documentation](https://spring.io/projects/spring-boot)