package com.example.r2demo;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

@SpringBootTest
@TestPropertySource(properties = {
    "cloudflare.r2.account-id=test-account",
    "cloudflare.r2.access-key-id=test-key",
    "cloudflare.r2.secret-access-key=test-secret",
    "cloudflare.r2.bucket-name=test-bucket",
    "cloudflare.r2.endpoint=https://test-account.r2.cloudflarestorage.com",
    "cloudflare.r2.region=auto"
})
class R2DemoApplicationTests {

    @Test
    void contextLoads() {
        // This test verifies that the Spring context loads successfully
        // with the configuration properties set
    }
}
