package com.ruoyi.framework.web.service;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;

/**
 * BladeX API调用客户端
 * 
 * @author ruoyi
 */
@Component
public class BladeApiClient
{
    private static final Logger log = LoggerFactory.getLogger(BladeApiClient.class);

    @Autowired
    private BladeTokenManager tokenManager;
    
    private final RestTemplate restTemplate = new RestTemplate();
    
    /**
     * 使用指定用户的令牌调用BladeX API
     * 
     * @param userId 用户ID
     * @param url API地址
     * @param method HTTP方法
     * @param requestBody 请求体（可为null）
     * @param responseType 响应类型
     * @return API响应
     */
    public <T> T callBladeApi(Long userId, String url, HttpMethod method, Object requestBody, Class<T> responseType)
    {
        // 获取用户的访问令牌
        String accessToken = tokenManager.getAccessToken(userId);
        if (StringUtils.isEmpty(accessToken))
        {
            log.error("用户没有有效的BladeX访问令牌, userId={}", userId);
            throw new ServiceException("用户没有有效的BladeX访问令牌，请重新登录");
        }
        
        // 构建请求头
        HttpHeaders headers = new HttpHeaders();
        headers.set("Blade-Auth", "bearer " + accessToken);
        headers.set("Blade-Requested-With", "BladeHttpRequest");
        
        // 构建请求实体
        HttpEntity<?> requestEntity = new HttpEntity<>(requestBody, headers);
        
        try
        {
            log.info("调用BladeX API, userId={}, url={}, method={}", userId, url, method);
            // 发送请求
            ResponseEntity<T> response = restTemplate.exchange(url, method, requestEntity, responseType);
            return response.getBody();
        }
        catch (HttpClientErrorException e)
        {
            if (e.getStatusCode() == HttpStatus.UNAUTHORIZED)
            {
                // 令牌失效，删除该用户的令牌
                log.error("BladeX访问令牌已过期, userId={}", userId);
                tokenManager.removeToken(userId);
                throw new ServiceException("BladeX访问令牌已过期，请重新登录");
            }
            log.error("调用BladeX API失败: {}", e.getMessage());
            throw new ServiceException("调用BladeX API失败: " + e.getMessage());
        }
    }
    
    /**
     * 获取指定用户的BladeX用户信息
     * 
     * @param userId 用户ID
     * @return 用户信息
     */
    public Map<String, Object> getUserInfo(Long userId)
    {
        return callBladeApi(userId, "http://localhost/blade-auth/oauth/user-info", 
                          HttpMethod.GET, null, Map.class);
    }
} 