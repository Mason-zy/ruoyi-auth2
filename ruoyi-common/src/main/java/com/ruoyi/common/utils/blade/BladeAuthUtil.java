package com.ruoyi.common.utils.blade;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

/**
 * BladeX认证工具类
 * 
 * @author ruoyi
 */
public class BladeAuthUtil {
    private static final Logger log = LoggerFactory.getLogger(BladeAuthUtil.class);

    private static final ObjectMapper objectMapper = new ObjectMapper();
    private static final RestTemplate restTemplate = new RestTemplate();

    /**
     * 通过授权码获取访问令牌
     *
     * @param tokenUrl BladeX认证服务地址
     * @param clientId 客户端ID
     * @param clientSecret 客户端密钥
     * @param code 授权码
     * @param redirectUri 重定向URI
     * @param tenantId 租户ID（可选）
     * @return 令牌响应Map，包含access_token, token_type, expires_in等信息
     */
    public static Map<String, Object> getTokenByCode(String tokenUrl, String clientId, String clientSecret, 
                                                     String code, String redirectUri, String tenantId) {
        try {
            log.info("开始获取BladeX令牌，tokenUrl={}, clientId={}, code={}, redirectUri={}, tenantId={}", 
                    tokenUrl, clientId, code, redirectUri, tenantId);
            
            // 请求头
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
            
            // Basic认证
            String auth = clientId + ":" + clientSecret;
            byte[] encodedAuth = Base64.getEncoder().encode(auth.getBytes());
            String authHeader = "Basic " + new String(encodedAuth);
            headers.set("Authorization", authHeader);

            // 请求参数
            MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
            params.add("grant_type", "authorization_code");
            params.add("code", code);
            params.add("redirect_uri", redirectUri);
            
            // 添加租户ID（如果有）
            if (tenantId != null && !tenantId.isEmpty()) {
                params.add("tenant_id", tenantId);
            }

            log.info("请求参数: {}", params);
            
            // 发送请求
            HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
            log.info("发送请求到: {}", tokenUrl);
            ResponseEntity<String> response = restTemplate.postForEntity(tokenUrl, request, String.class);
            
            // 解析响应JSON为Map
            String responseBody = response.getBody();
            log.info("收到响应: {}", responseBody);
            
            if (responseBody != null && !responseBody.isEmpty()) {
                return objectMapper.readValue(responseBody, new TypeReference<Map<String, Object>>() {});
            }
            
            log.error("BladeX认证返回数据为空");
            return createErrorResponse("认证返回数据为空");
        } catch (Exception e) {
            log.error("BladeX认证失败", e);
            return createErrorResponse("认证失败: " + e.getMessage());
        }
    }

    /**
     * 简化版的令牌获取方法，可配置是否需要特定参数
     *
     * @param tokenUrl BladeX认证服务地址
     * @param params 认证所需参数
     * @return 令牌响应
     */
    public static Map<String, Object> getToken(String tokenUrl, Map<String, String> params) {
        try {
            // 请求头
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
            
            // 如果提供了客户端ID和密钥，添加Basic认证
            if (params.containsKey("client_id") && params.containsKey("client_secret")) {
                String auth = params.get("client_id") + ":" + params.get("client_secret");
                byte[] encodedAuth = Base64.getEncoder().encode(auth.getBytes());
                String authHeader = "Basic " + new String(encodedAuth);
                headers.set("Authorization", authHeader);
            }

            // 构建请求参数
            MultiValueMap<String, String> requestParams = new LinkedMultiValueMap<>();
            for (Map.Entry<String, String> entry : params.entrySet()) {
                if (!"client_id".equals(entry.getKey()) && !"client_secret".equals(entry.getKey())) {
                    requestParams.add(entry.getKey(), entry.getValue());
                }
            }

            // 发送请求
            HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(requestParams, headers);
            ResponseEntity<String> response = restTemplate.postForEntity(tokenUrl, request, String.class);
            
            // 解析响应
            String responseBody = response.getBody();
            if (responseBody != null && !responseBody.isEmpty()) {
                return objectMapper.readValue(responseBody, new TypeReference<Map<String, Object>>() {});
            }
            
            log.error("BladeX认证返回数据为空");
            return createErrorResponse("认证返回数据为空");
        } catch (Exception e) {
            log.error("BladeX认证失败", e);
            return createErrorResponse("认证失败: " + e.getMessage());
        }
    }

    /**
     * 创建错误响应
     *
     * @param message 错误消息
     * @return 错误响应
     */
    private static Map<String, Object> createErrorResponse(String message) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);
        response.put("code", 500);
        response.put("msg", message);
        return response;
    }
} 