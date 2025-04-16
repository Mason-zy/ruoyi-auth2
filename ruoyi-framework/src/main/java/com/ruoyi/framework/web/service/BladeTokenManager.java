package com.ruoyi.framework.web.service;

import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ruoyi.common.core.domain.model.BladeToken;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.StringUtils;

/**
 * BladeX令牌管理器
 * 
 * @author ruoyi
 */
@Component
public class BladeTokenManager
{
    private static final Logger log = LoggerFactory.getLogger(BladeTokenManager.class);

    @Autowired
    private RedisCache redisCache;
    
    private static final String BLADE_TOKEN_KEY = "blade_tokens:";
    
    /**
     * 保存用户的BladeX令牌
     * 
     * @param userId 用户ID
     * @param userName 用户名
     * @param accessToken 访问令牌
     * @param expiresIn 有效期（秒）
     */
    public void setBladeToken(Long userId, String userName, String accessToken, int expiresIn)
    {
        BladeToken bladeToken = new BladeToken();
        bladeToken.setUserId(userId);
        bladeToken.setUserName(userName);
        bladeToken.setAccessToken(accessToken);
        bladeToken.setLoginTime(System.currentTimeMillis());
        bladeToken.setExpireTime(bladeToken.getLoginTime() + expiresIn * 1000L);
        
        // 存储到Redis，过期时间设置为令牌有效期
        String tokenKey = getTokenKey(userId);
        log.info("保存用户BladeX令牌, userId={}, tokenKey={}, expiresIn={}秒", userId, tokenKey, expiresIn);
        redisCache.setCacheObject(tokenKey, bladeToken, expiresIn, TimeUnit.SECONDS);
    }
    
    /**
     * 获取用户的BladeX令牌
     * 
     * @param userId 用户ID
     * @return BladeToken对象
     */
    public BladeToken getBladeToken(Long userId)
    {
        String tokenKey = getTokenKey(userId);
        BladeToken token = redisCache.getCacheObject(tokenKey);
        if (token == null)
        {
            log.info("未找到用户BladeX令牌, userId={}, tokenKey={}", userId, tokenKey);
        }
        return token;
    }
    
    /**
     * 获取用户的访问令牌
     * 
     * @param userId 用户ID
     * @return 访问令牌
     */
    public String getAccessToken(Long userId)
    {
        BladeToken token = getBladeToken(userId);
        if (token != null)
        {
            return token.getAccessToken();
        }
        return null;
    }
    
    /**
     * 删除用户的BladeX令牌
     * 
     * @param userId 用户ID
     */
    public void removeToken(Long userId)
    {
        String tokenKey = getTokenKey(userId);
        log.info("删除用户BladeX令牌, userId={}, tokenKey={}", userId, tokenKey);
        redisCache.deleteObject(tokenKey);
    }
    
    /**
     * 检查用户是否有有效的BladeX令牌
     * 
     * @param userId 用户ID
     * @return 是否有效
     */
    public boolean hasValidToken(Long userId)
    {
        BladeToken token = getBladeToken(userId);
        return token != null;
    }
    
    /**
     * 获取令牌在Redis中的键名
     * 
     * @param userId 用户ID
     * @return Redis键名
     */
    private String getTokenKey(Long userId)
    {
        return BLADE_TOKEN_KEY + userId;
    }
} 