package com.ruoyi.framework.config;

import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Jackson配置类
 * 解决前端接收Long类型精度丢失问题
 */
@Configuration
public class JacksonConfig {

    @Bean
    public Jackson2ObjectMapperBuilderCustomizer jackson2ObjectMapperBuilderCustomizer() {
        return jacksonObjectMapperBuilder -> {
            // Long类型转String类型
            jacksonObjectMapperBuilder.serializerByType(Long.class, ToStringSerializer.instance);
            jacksonObjectMapperBuilder.serializerByType(Long.TYPE, ToStringSerializer.instance);
        };
    }
} 