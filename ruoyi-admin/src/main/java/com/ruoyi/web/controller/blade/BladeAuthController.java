package com.ruoyi.web.controller.blade;

import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.blade.BladeAuthUtil;
import com.ruoyi.common.utils.ip.IpUtils;
import com.ruoyi.framework.manager.AsyncManager;
import com.ruoyi.framework.manager.factory.AsyncFactory;
import com.ruoyi.framework.web.service.SysPermissionService;
import com.ruoyi.framework.web.service.TokenService;
import com.ruoyi.framework.web.service.UserDetailsServiceImpl;
import com.ruoyi.system.service.ISysUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
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
    
    @Autowired
    private ISysUserService userService;
    
    @Autowired
    private TokenService tokenService;
    
    @Autowired
    private SysPermissionService permissionService;
    
    @Autowired
    private UserDetailsServiceImpl userDetailsService;
    
    @Autowired
    private RedisCache redisCache;

    /**
     * 获取BladeX用户信息并登录若依系统
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
        
        // 配置检查
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
        
        // 获取BladeX token
        log.info("开始调用BladeAuthUtil获取令牌");
        Map<String, Object> tokenInfo = BladeAuthUtil.getTokenByCode(
            authUrl, clientId, clientSecret, code, redirectUri, tenantId);
        
        log.info("获取令牌结果: {}", tokenInfo);
        
        // 如果获取令牌成功，处理若依登录
        if (tokenInfo != null && tokenInfo.containsKey("account")) {
            String userName = (String) tokenInfo.get("account");
            if (userName == null || userName.isEmpty()) {
                userName = (String) tokenInfo.get("user_name");
            }
            
            if (userName != null && !userName.isEmpty()) {
                // 在若依系统中查询用户
                log.info("尝试在若依系统中查询用户: {}", userName);
                SysUser user = userService.selectUserByUserName(userName);
                
                if (user != null) {
                    log.info("找到匹配的若依用户: {}, 开始模拟登录流程", userName);
                    try {
                        // 1. 记录登录成功日志
                        AsyncManager.me().execute(AsyncFactory.recordLogininfor(userName, Constants.LOGIN_SUCCESS, "BladeX单点登录成功"));
                        
                        // 2. 使用UserDetailsServiceImpl创建LoginUser对象(与原生登录流程一致)
                        LoginUser loginUser = (LoginUser) userDetailsService.createLoginUser(user);
                        
                        // 3. 记录登录IP和时间
                        recordLoginInfo(user.getUserId());
                        
                        // 4. 生成token(与原生登录流程完全一致)
                        String token = tokenService.createToken(loginUser);
                        
                        // 5. 使用与原生登录接口相同的返回格式
                        AjaxResult ajax = AjaxResult.success();
                        ajax.put(Constants.TOKEN, token);
                        
                        // 6. 同时返回BladeX的token信息给前端
                        Map<String, Object> bladeTokens = new HashMap<>();
                        bladeTokens.put("access_token", tokenInfo.get("access_token"));
                        bladeTokens.put("refresh_token", tokenInfo.get("refresh_token"));
                        bladeTokens.put("expires_in", tokenInfo.get("expires_in"));
                        ajax.put("blade_token", bladeTokens);
                        
                        log.info("成功生成若依系统令牌并执行登录");
                        return ajax;
                    } catch (Exception e) {
                        log.error("BladeX单点登录失败", e);
                        AsyncManager.me().execute(AsyncFactory.recordLogininfor(userName, Constants.LOGIN_FAIL, e.getMessage()));
                        return AjaxResult.error("登录失败：" + e.getMessage());
                    }
                } else {
                    log.warn("未找到匹配的若依用户: {}", userName);
                    return AjaxResult.error("未找到对应的系统用户，请联系管理员创建用户");
                }
            }
        }
        
        // 返回错误信息
        return AjaxResult.error("BladeX认证失败或返回信息不完整");
    }
    
    /**
     * 记录登录信息（与SysLoginService.recordLoginInfo保持一致）
     *
     * @param userId 用户ID
     */
    private void recordLoginInfo(Long userId) {
        SysUser sysUser = new SysUser();
        sysUser.setUserId(userId);
        sysUser.setLoginIp(IpUtils.getIpAddr());
        sysUser.setLoginDate(new java.util.Date());
        userService.updateUserProfile(sysUser);
    }
} 