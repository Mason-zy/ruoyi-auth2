package com.ruoyi.common.core.domain.model;

import java.io.Serializable;

/**
 * BladeX令牌对象
 * 
 * @author ruoyi
 */
public class BladeToken implements Serializable
{
    private static final long serialVersionUID = 1L;

    /** 用户ID */
    private Long userId;
    
    /** 用户名 */
    private String userName;
    
    /** 访问令牌 */
    private String accessToken;
    
    /** 过期时间 */
    private Long expireTime;
    
    /** 登录时间 */
    private Long loginTime;

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public String getUserName()
    {
        return userName;
    }

    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getAccessToken()
    {
        return accessToken;
    }

    public void setAccessToken(String accessToken)
    {
        this.accessToken = accessToken;
    }

    public Long getExpireTime()
    {
        return expireTime;
    }

    public void setExpireTime(Long expireTime)
    {
        this.expireTime = expireTime;
    }

    public Long getLoginTime()
    {
        return loginTime;
    }

    public void setLoginTime(Long loginTime)
    {
        this.loginTime = loginTime;
    }
} 