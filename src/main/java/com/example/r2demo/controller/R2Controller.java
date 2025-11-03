package com.example.r2demo.controller;

import com.example.r2demo.model.FileInfo;
import com.example.r2demo.model.UploadResponse;
import com.example.r2demo.service.R2Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.ResponseInputStream;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;

import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/r2")
public class R2Controller {

    private static final Logger logger = LoggerFactory.getLogger(R2Controller.class);

    private final R2Service r2Service;

    public R2Controller(R2Service r2Service) {
        this.r2Service = r2Service;
    }

    /**
     * Upload a file to Cloudflare R2
     * 
     * @param file The file to upload
     * @param key Optional custom key/path for the file
     * @return Upload response with file details
     */
    @PostMapping(value = "/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<UploadResponse> uploadFile(
            @RequestParam("file") MultipartFile file,
            @RequestParam(value = "key", required = false) String key) {
        
        try {
            if (file.isEmpty()) {
                return ResponseEntity.badRequest().body(
                    new UploadResponse(null, "File is empty", null)
                );
            }

            // Use custom key or generate from original filename
            String fileKey = (key != null && !key.isEmpty()) ? key : file.getOriginalFilename();
            
            logger.info("Received upload request for file: {}", fileKey);
            
            String uploadedKey = r2Service.uploadFile(file, fileKey);
            
            UploadResponse response = new UploadResponse(
                uploadedKey,
                "File uploaded successfully",
                "/api/r2/download/" + uploadedKey
            );
            
            return ResponseEntity.ok(response);
            
        } catch (IOException e) {
            logger.error("Error uploading file", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                new UploadResponse(null, "Error uploading file: " + e.getMessage(), null)
            );
        }
    }

    /**
     * Download a file from Cloudflare R2
     * 
     * @param key The file key/path
     * @return The file as a download
     */
    @GetMapping("/download/**")
    public ResponseEntity<InputStreamResource> downloadFile(HttpServletRequest request) {
        String key = request.getRequestURI().split("/api/r2/download/", 2)[1];
        try {
            logger.info("Received download request for file: {}", key);
            
            // Validate key - prevent null or empty keys
            if (key == null || key.trim().isEmpty()) {
                return ResponseEntity.badRequest().build();
            }
            
            if (!r2Service.fileExists(key)) {
                return ResponseEntity.notFound().build();
            }
            
            ResponseInputStream<GetObjectResponse> s3Object = r2Service.downloadFile(key);
            GetObjectResponse response = s3Object.response();
            
            HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + key + "\"");
            headers.setContentType(MediaType.parseMediaType(response.contentType()));
            headers.setContentLength(response.contentLength());
            
            return ResponseEntity.ok()
                    .headers(headers)
                    .body(new InputStreamResource(s3Object));
                    
        } catch (Exception e) {
            logger.error("Error downloading file: {}", key, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    /**
     * List all files in the Cloudflare R2 bucket
     * 
     * @return List of file information
     */
    @GetMapping("/list")
    public ResponseEntity<List<FileInfo>> listFiles() {
        try {
            logger.info("Received list files request");
            List<FileInfo> files = r2Service.listFiles();
            return ResponseEntity.ok(files);
        } catch (Exception e) {
            logger.error("Error listing files", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    /**
     * Delete a file from Cloudflare R2
     * 
     * @param key The file key/path to delete
     * @return Success message
     */
    @DeleteMapping("/delete/**")
    public ResponseEntity<String> deleteFile(HttpServletRequest request) {
        String key = request.getRequestURI().split("/api/r2/delete/", 2)[1];
        try {
            logger.info("Received delete request for file: {}", key);
            
            // Validate key - prevent null or empty keys
            if (key == null || key.trim().isEmpty()) {
                return ResponseEntity.badRequest().body("Invalid file key");
            }
            
            if (!r2Service.fileExists(key)) {
                return ResponseEntity.notFound().build();
            }
            
            r2Service.deleteFile(key);
            return ResponseEntity.ok("File deleted successfully");
            
        } catch (Exception e) {
            logger.error("Error deleting file: {}", key, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error deleting file");
        }
    }

    /**
     * Check if a file exists in Cloudflare R2
     * 
     * @param key The file key/path to check
     * @return Boolean indicating if file exists
     */
    @GetMapping("/exists/**")
    public ResponseEntity<Boolean> fileExists(HttpServletRequest request) {
        String key = request.getRequestURI().split("/api/r2/exists/", 2)[1];
        try {
            logger.info("Received exists check for file: {}", key);
            
            // Validate key - prevent null or empty keys
            if (key == null || key.trim().isEmpty()) {
                return ResponseEntity.badRequest().build();
            }
            
            boolean exists = r2Service.fileExists(key);
            return ResponseEntity.ok(exists);
        } catch (Exception e) {
            logger.error("Error checking file existence: {}", key, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}
