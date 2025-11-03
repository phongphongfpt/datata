# Cloudflare R2 API Examples

This document provides practical examples for testing the Cloudflare R2 Spring Boot API.

## Prerequisites

1. Start the application: `mvn spring-boot:run`
2. Ensure your R2 credentials are configured in `application.yaml`

## Example 1: Upload a Text File

Create a test file:
```bash
echo "Hello, Cloudflare R2!" > test.txt
```

Upload using cURL:
```bash
curl -X POST http://localhost:8080/api/r2/upload \
  -F "file=@test.txt" \
  -F "key=examples/test.txt"
```

Expected Response:
```json
{
  "key": "examples/test.txt",
  "message": "File uploaded successfully",
  "url": "/api/r2/download/examples/test.txt"
}
```

## Example 2: Upload an Image

Upload a PNG image:
```bash
curl -X POST http://localhost:8080/api/r2/upload \
  -F "file=@image.png" \
  -F "key=images/sample.png"
```

## Example 3: List All Files

```bash
curl http://localhost:8080/api/r2/list
```

Expected Response:
```json
[
  {
    "key": "examples/test.txt",
    "size": 23,
    "lastModified": "2024-01-15T10:30:00Z",
    "eTag": "\"d41d8cd98f00b204e9800998ecf8427e\""
  },
  {
    "key": "images/sample.png",
    "size": 52341,
    "lastModified": "2024-01-15T10:35:00Z",
    "eTag": "\"e2fc714c4727ee9395f324cd2e7f331f\""
  }
]
```

## Example 4: Download a File

```bash
curl -O http://localhost:8080/api/r2/download/examples/test.txt
```

This will save the file as `test.txt` in your current directory.

## Example 5: Check File Existence

```bash
curl http://localhost:8080/api/r2/exists/examples/test.txt
```

Expected Response:
```json
true
```

Check for non-existent file:
```bash
curl http://localhost:8080/api/r2/exists/nonexistent.txt
```

Expected Response:
```json
false
```

## Example 6: Delete a File

```bash
curl -X DELETE http://localhost:8080/api/r2/delete/examples/test.txt
```

Expected Response:
```
File deleted successfully
```

## Example 7: Upload Multiple Files

Create multiple test files:
```bash
echo "File 1" > file1.txt
echo "File 2" > file2.txt
echo "File 3" > file3.txt
```

Upload them:
```bash
curl -X POST http://localhost:8080/api/r2/upload \
  -F "file=@file1.txt" \
  -F "key=batch/file1.txt"

curl -X POST http://localhost:8080/api/r2/upload \
  -F "file=@file2.txt" \
  -F "key=batch/file2.txt"

curl -X POST http://localhost:8080/api/r2/upload \
  -F "file=@file3.txt" \
  -F "key=batch/file3.txt"
```

## Example 8: Upload Without Custom Key

When you don't specify a key, the original filename is used:
```bash
curl -X POST http://localhost:8080/api/r2/upload \
  -F "file=@myfile.pdf"
```

The file will be stored with key `myfile.pdf`.

## Example 9: Using Postman

### Upload a File
1. Method: `POST`
2. URL: `http://localhost:8080/api/r2/upload`
3. Body Tab:
   - Select `form-data`
   - Add key `file` with type `File`, select your file
   - Add key `key` with type `Text`, enter the desired path (optional)
4. Click `Send`

### List Files
1. Method: `GET`
2. URL: `http://localhost:8080/api/r2/list`
3. Click `Send`

### Download a File
1. Method: `GET`
2. URL: `http://localhost:8080/api/r2/download/{key}`
3. Replace `{key}` with the actual file key
4. Click `Send`
5. Use `Save Response` to save the downloaded file

### Delete a File
1. Method: `DELETE`
2. URL: `http://localhost:8080/api/r2/delete/{key}`
3. Replace `{key}` with the actual file key
4. Click `Send`

## Example 10: Error Handling

### Upload Empty File
```bash
curl -X POST http://localhost:8080/api/r2/upload \
  -F "file=@/dev/null"
```

Expected Response:
```json
{
  "key": null,
  "message": "File is empty",
  "url": null
}
```

### Download Non-existent File
```bash
curl http://localhost:8080/api/r2/download/nonexistent.txt
```

Expected Response: `404 Not Found`

### Delete Non-existent File
```bash
curl -X DELETE http://localhost:8080/api/r2/delete/nonexistent.txt
```

Expected Response: `404 Not Found`

## Advanced Examples

### Upload with Organized Directory Structure
```bash
# Documents
curl -X POST http://localhost:8080/api/r2/upload \
  -F "file=@report.pdf" \
  -F "key=documents/2024/report.pdf"

# Images
curl -X POST http://localhost:8080/api/r2/upload \
  -F "file=@photo.jpg" \
  -F "key=images/gallery/photo.jpg"

# Videos
curl -X POST http://localhost:8080/api/r2/upload \
  -F "file=@video.mp4" \
  -F "key=videos/2024/video.mp4"
```

### Batch Operations Script
Save this as `batch-upload.sh`:
```bash
#!/bin/bash

# Upload all files in a directory
for file in /path/to/files/*; do
    filename=$(basename "$file")
    curl -X POST http://localhost:8080/api/r2/upload \
      -F "file=@$file" \
      -F "key=uploaded/$filename"
    echo "Uploaded: $filename"
done
```

Make it executable and run:
```bash
chmod +x batch-upload.sh
./batch-upload.sh
```

## Testing with Python

```python
import requests

# Upload file
url = "http://localhost:8080/api/r2/upload"
files = {'file': open('test.txt', 'rb')}
data = {'key': 'python/test.txt'}
response = requests.post(url, files=files, data=data)
print(response.json())

# List files
response = requests.get("http://localhost:8080/api/r2/list")
print(response.json())

# Download file
response = requests.get("http://localhost:8080/api/r2/download/python/test.txt")
with open('downloaded.txt', 'wb') as f:
    f.write(response.content)

# Delete file
response = requests.delete("http://localhost:8080/api/r2/delete/python/test.txt")
print(response.text)
```

## Testing with JavaScript (Node.js)

```javascript
const FormData = require('form-data');
const fs = require('fs');
const axios = require('axios');

// Upload file
const form = new FormData();
form.append('file', fs.createReadStream('test.txt'));
form.append('key', 'nodejs/test.txt');

axios.post('http://localhost:8080/api/r2/upload', form, {
  headers: form.getHeaders()
})
.then(response => console.log(response.data))
.catch(error => console.error(error));

// List files
axios.get('http://localhost:8080/api/r2/list')
.then(response => console.log(response.data))
.catch(error => console.error(error));

// Download file
axios.get('http://localhost:8080/api/r2/download/nodejs/test.txt', {
  responseType: 'stream'
})
.then(response => {
  response.data.pipe(fs.createWriteStream('downloaded.txt'));
})
.catch(error => console.error(error));

// Delete file
axios.delete('http://localhost:8080/api/r2/delete/nodejs/test.txt')
.then(response => console.log(response.data))
.catch(error => console.error(error));
```

## Notes

- Replace `localhost:8080` with your actual server address if running remotely
- All file paths (keys) are case-sensitive
- File keys can include directories using forward slashes (e.g., `path/to/file.txt`)
- The API supports various file types (images, videos, documents, etc.)
- Maximum upload size is configurable in `application.yaml` (default: 10MB)
