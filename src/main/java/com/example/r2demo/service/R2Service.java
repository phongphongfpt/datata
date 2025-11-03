package com.example.r2demo.service;

import com.example.r2demo.config.R2Properties;
import com.example.r2demo.model.FileInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.ResponseInputStream;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class R2Service {

    private static final Logger logger = LoggerFactory.getLogger(R2Service.class);

    private final S3Client s3Client;
    private final R2Properties r2Properties;

    public R2Service(S3Client s3Client, R2Properties r2Properties) {
        this.s3Client = s3Client;
        this.r2Properties = r2Properties;
    }

    /**
     * Upload a file to Cloudflare R2
     */
    public String uploadFile(MultipartFile file, String key) throws IOException {
        logger.info("Uploading file: {} to R2 bucket: {}", key, r2Properties.getBucketName());

        PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                .bucket(r2Properties.getBucketName())
                .key(key)
                .contentType(file.getContentType())
                .build();

        s3Client.putObject(putObjectRequest, RequestBody.fromBytes(file.getBytes()));

        logger.info("File uploaded successfully: {}", key);
        return key;
    }

    /**
     * Download a file from Cloudflare R2
     */
    public ResponseInputStream<GetObjectResponse> downloadFile(String key) {
        logger.info("Downloading file: {} from R2 bucket: {}", key, r2Properties.getBucketName());

        GetObjectRequest getObjectRequest = GetObjectRequest.builder()
                .bucket(r2Properties.getBucketName())
                .key(key)
                .build();

        return s3Client.getObject(getObjectRequest);
    }

    /**
     * List all files in the Cloudflare R2 bucket
     */
    public List<FileInfo> listFiles() {
        logger.info("Listing files in R2 bucket: {}", r2Properties.getBucketName());

        ListObjectsV2Request listObjectsRequest = ListObjectsV2Request.builder()
                .bucket(r2Properties.getBucketName())
                .build();

        ListObjectsV2Response listObjectsResponse = s3Client.listObjectsV2(listObjectsRequest);

        return listObjectsResponse.contents().stream()
                .map(s3Object -> new FileInfo(
                        s3Object.key(),
                        s3Object.size(),
                        s3Object.lastModified(),
                        s3Object.eTag()
                ))
                .collect(Collectors.toList());
    }

    /**
     * Delete a file from Cloudflare R2
     */
    public void deleteFile(String key) {
        logger.info("Deleting file: {} from R2 bucket: {}", key, r2Properties.getBucketName());

        DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
                .bucket(r2Properties.getBucketName())
                .key(key)
                .build();

        s3Client.deleteObject(deleteObjectRequest);
        logger.info("File deleted successfully: {}", key);
    }

    /**
     * Check if a file exists in Cloudflare R2
     */
    public boolean fileExists(String key) {
        try {
            HeadObjectRequest headObjectRequest = HeadObjectRequest.builder()
                    .bucket(r2Properties.getBucketName())
                    .key(key)
                    .build();

            s3Client.headObject(headObjectRequest);
            return true;
        } catch (NoSuchKeyException e) {
            return false;
        }
    }
}
