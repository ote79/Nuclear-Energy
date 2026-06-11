package org.nuclearEnergy.backend;

import org.nuclearEnergy.backend.common.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;

@SpringBootTest
public class RedisTest {
    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @GetMapping("/redis/set")
    public Result<String> redisSet() {
        stringRedisTemplate.opsForValue().set("test:hello", "world");
        return Result.success("写入成功");
    }

    @GetMapping("/redis/get")
    public Result<String> redisGet() {
        String value = stringRedisTemplate.opsForValue().get("test:hello");
        return Result.success(value);
    }
}
