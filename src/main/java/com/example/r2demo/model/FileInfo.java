package com.example.r2demo.model;

import java.time.Instant;

public class FileInfo {

    private String key;
    private Long size;
    private Instant lastModified;
    private String eTag;

    public FileInfo() {
    }

    public FileInfo(String key, Long size, Instant lastModified, String eTag) {
        this.key = key;
        this.size = size;
        this.lastModified = lastModified;
        this.eTag = eTag;
    }

    // Getters and Setters
    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public Long getSize() {
        return size;
    }

    public void setSize(Long size) {
        this.size = size;
    }

    public Instant getLastModified() {
        return lastModified;
    }

    public void setLastModified(Instant lastModified) {
        this.lastModified = lastModified;
    }

    public String getETag() {
        return eTag;
    }

    public void setETag(String eTag) {
        this.eTag = eTag;
    }
}
