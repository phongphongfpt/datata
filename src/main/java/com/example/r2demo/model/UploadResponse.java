package com.example.r2demo.model;

public class UploadResponse {

    private String key;
    private String message;
    private String url;

    public UploadResponse() {
    }

    public UploadResponse(String key, String message, String url) {
        this.key = key;
        this.message = message;
        this.url = url;
    }

    // Getters and Setters
    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
