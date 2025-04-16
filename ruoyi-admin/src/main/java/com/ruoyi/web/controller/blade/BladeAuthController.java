package com.ruoyi.web.controller.blade;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.blade.BladeAuthUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * BladeX认证控制器
 * 
 * @author ruoyi
 */
@RestController
@RequestMapping("/blade/auth")
public class BladeAuthController {
    private static final Logger log = LoggerFactory.getLogger(BladeAuthController.class);

    @Value("${blade.auth.url:}")
    private String authUrl;

    @Value("${blade.auth.client-id:}")
    private String clientId;

    @Value("${blade.auth.client-secret:}")
    private String clientSecret;

    @Value("${blade.auth.redirect-uri:}")
    private String redirectUri;

    /**
     * 获取BladeX用户信息和令牌
     * 
     * @param code 授权码
     * @param tenantId 租户ID（可选）
     * @return token信息
     */
    @GetMapping("/getTokenInfo")
    public AjaxResult getTokenInfo(@RequestParam("code") String code, 
                               @RequestParam(value = "tenant_id", required = false) String tenantId) {
        log.info("接收到获取BladeX令牌请求，code={}, tenantId={}", code, tenantId);
        log.info("当前BladeX配置: authUrl={}, clientId={}, redirectUri={}", authUrl, clientId, redirectUri);
        
        // 如果没有配置BladeX认证参数，返回错误信息
        if (authUrl == null || authUrl.isEmpty()) {
            log.error("未配置BladeX认证服务URL");
            return AjaxResult.error("未配置BladeX认证服务");
        }
        
        if (clientId == null || clientId.isEmpty()) {
            log.error("未配置BladeX客户端ID");
            return AjaxResult.error("未配置BladeX客户端ID");
        }
        
        if (clientSecret == null || clientSecret.isEmpty()) {
            log.error("未配置BladeX客户端密钥");
            return AjaxResult.error("未配置BladeX客户端密钥");
        }
        
        if (redirectUri == null || redirectUri.isEmpty()) {
            log.error("未配置BladeX重定向URI");
            return AjaxResult.error("未配置BladeX重定向URI");
        }
        
        // 获取token
        log.info("开始调用BladeAuthUtil获取令牌");
        Map<String, Object> tokenInfo = BladeAuthUtil.getTokenByCode(
            authUrl, clientId, clientSecret, code, redirectUri, tenantId);
        
        log.info("获取令牌结果: {}", tokenInfo);
        
        // 返回token信息
        return AjaxResult.success(tokenInfo);
    }
} 