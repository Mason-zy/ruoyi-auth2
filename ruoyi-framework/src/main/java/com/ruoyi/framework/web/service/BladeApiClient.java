package com.ruoyi.framework.web.service;

import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
    
    @Value("${blade.api.base-url:https://we-safer.net/api}")
    private String apiBaseUrl;
    
    @Value("${blade.api.client-id:chem_ruoyi}")
    private String clientId;
    
    @Value("${blade.api.client-secret:chem_ruoyi_secret}")
    private String clientSecret;
    
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
        
        // 添加Basic认证
        String auth = clientId + ":" + clientSecret;
        byte[] encodedAuth = Base64.getEncoder().encode(auth.getBytes());
        String authHeader = "Basic " + new String(encodedAuth);
        headers.set("Authorization", authHeader);
        
        // 构建请求实体
        HttpEntity<?> requestEntity = new HttpEntity<>(requestBody, headers);
        
        try
        {
            log.info("调用BladeX API, userId={}, url={}, method={}, headers={}", userId, url, method, headers);
            // 发送请求
            ResponseEntity<T> response = restTemplate.exchange(url, method, requestEntity, responseType);
            log.info("API响应状态码: {}", response.getStatusCode());
            return response.getBody();
        }
        catch (HttpClientErrorException e)
        {
            log.error("调用BladeX API发生HttpClientErrorException: 状态码={}, 响应内容={}", e.getStatusCode(), e.getResponseBodyAsString());
            
            if (e.getStatusCode() == HttpStatus.UNAUTHORIZED)
            {
                // 令牌失效，删除该用户的令牌 dev

                log.error("BladeX访问令牌已过期, userId={}", userId);
                // tokenManager.removeToken(userId);
                throw new ServiceException("BladeX访问令牌已过期，请重新登录");
            }
            
            // 尝试解析错误响应内容，可能包含更详细的错误信息
            String errorResponse = e.getResponseBodyAsString();
            log.error("BladeX API错误响应详情: {}", errorResponse);
            
            throw new ServiceException("调用BladeX API失败: " + e.getMessage() + ", 响应内容: " + errorResponse);
        }
        catch (Exception e) {
            log.error("调用BladeX API发生异常: {}, 异常类型: {}", e.getMessage(), e.getClass().getName(), e);
            throw new ServiceException("调用BladeX API发生异常: " + e.getMessage());
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
        // 获取访问令牌，记录更多日志信息
        String accessToken = tokenManager.getAccessToken(userId);
        log.info("获取用户信息，userId={}, 令牌长度={}", userId, 
                 StringUtils.isNotEmpty(accessToken) ? accessToken.length() : 0);
        
        // 硬编码API路径
        String apiUrl = apiBaseUrl + "/blade-auth/oauth/user-info";
        log.info("调用BladeX获取用户信息API: {}", apiUrl);
        
        Map<String, Object> result = callBladeApi(userId, apiUrl, HttpMethod.GET, null, Map.class);
        log.info("获取用户信息结果: {}", result);
        return result;
    }
    
    /**
     * 获取BladeX系统中的用户列表，用于用户同步
     * 
     * @param userId 当前用户ID（用于获取令牌）
     * @param current 当前页
     * @param size 每页条数
     * @param account 账号名称（可选）
     * @param realName 真实姓名（可选）
     * @param deptId 部门ID（可选）
     * @return 用户列表分页数据
     */
    public Map<String, Object> getUserList(Long userId, int current, int size, String account, String realName, String deptId)
    {
        // 硬编码API路径
        String apiUrl = apiBaseUrl + "/blade-system/user/page";
        
        // 构建查询参数
        StringBuilder urlBuilder = new StringBuilder(apiUrl);
        urlBuilder.append("?current=").append(current).append("&size=").append(size);
        
        // 添加可选查询参数
        if (StringUtils.isNotEmpty(account)) {
            urlBuilder.append("&account=").append(account);
        }
        if (StringUtils.isNotEmpty(realName)) {
            urlBuilder.append("&realName=").append(realName);
        }
        if (StringUtils.isNotEmpty(deptId)) {
            urlBuilder.append("&deptId=").append(deptId);
        }
        
        String finalUrl = urlBuilder.toString();
        log.info("调用BladeX获取用户列表API: {}", finalUrl);
        
        // 使用GET方法而不是POST
        Map<String, Object> result = callBladeApi(userId, finalUrl, HttpMethod.GET, null, Map.class);
        log.info("获取用户列表结果，总条数: {}", result != null && result.containsKey("total") ? result.get("total") : "未知");
        return result;
    }
    
    /**
     * 获取BladeX系统中的岗位列表
     * 
     * @param userId 当前用户ID（用于获取令牌）
     * @param current 当前页
     * @param size 每页条数
     * @param postName 岗位名称（可选）
     * @param postCode 岗位编号（可选）
     * @param category 岗位类型（可选）
     * @return 岗位列表分页数据
     */
    public Map<String, Object> getPostList(Long userId, int current, int size, String postName, String postCode, Integer category)
    {
        // 硬编码API路径
        String apiUrl = apiBaseUrl + "/blade-system/post/page";
        
        // 构建查询参数
        StringBuilder urlBuilder = new StringBuilder(apiUrl);
        urlBuilder.append("?current=").append(current).append("&size=").append(size);
        
        // 添加可选查询参数
        if (StringUtils.isNotEmpty(postName)) {
            urlBuilder.append("&postName=").append(postName);
        }
        if (StringUtils.isNotEmpty(postCode)) {
            urlBuilder.append("&postCode=").append(postCode);
        }
        if (category != null) {
            urlBuilder.append("&category=").append(category);
        }
        
        String finalUrl = urlBuilder.toString();
        log.info("调用BladeX获取岗位列表API: {}", finalUrl);
        
        // 使用GET方法
        Map<String, Object> result = callBladeApi(userId, finalUrl, HttpMethod.GET, null, Map.class);
        log.info("获取岗位列表结果，总条数: {}", result != null && result.containsKey("total") ? result.get("total") : "未知");
        return result;
    }
    
    /**
     * 获取BladeX系统中的部门列表
     * 
     * @param userId 当前用户ID（用于获取令牌）
     * @return 部门列表数据
     */
    public Map<String, Object> getDeptList(Long userId)
    {
        // 硬编码API路径
        String apiUrl = apiBaseUrl + "/blade-system/dept/list";
        
        log.info("调用BladeX获取部门列表API: {}", apiUrl);
        
        // 使用GET方法，无需查询参数
        Map<String, Object> result = callBladeApi(userId, apiUrl, HttpMethod.GET, null, Map.class);
        
        if (result != null) {
            if (result.containsKey("data") && result.get("data") instanceof java.util.List) {
                java.util.List<?> dataList = (java.util.List<?>) result.get("data");
                log.info("获取部门列表成功，共 {} 个顶级部门", dataList.size());
            } else {
                log.info("获取部门列表成功，但数据结构与预期不符");
            }
        } else {
            log.warn("获取部门列表结果为空");
        }
        
        return result;
    }
} 