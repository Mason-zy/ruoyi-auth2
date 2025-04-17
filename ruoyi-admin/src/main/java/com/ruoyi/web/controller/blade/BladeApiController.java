package com.ruoyi.web.controller.blade;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.framework.web.service.BladeApiClient;
import com.ruoyi.framework.web.service.BladeTokenManager;

import java.util.Map;

/**
 * BladeX API控制器
 * 
 * @author ruoyi
 */
@RestController
@RequestMapping("/blade/api")
public class BladeApiController extends BaseController
{
    @Autowired
    private BladeApiClient bladeApiClient;
    
    @Autowired
    private BladeTokenManager bladeTokenManager;

    /**
     * 检查当前用户的BladeX令牌状态
     */
    @GetMapping("/checkToken")
    @PreAuthorize("@ss.hasPermi('system:user:list')")
    public AjaxResult checkToken()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        boolean hasToken = bladeTokenManager.hasValidToken(loginUser.getUserId());
        
        return AjaxResult.success()
                .put("hasToken", hasToken)
                .put("userId", loginUser.getUserId())
                .put("userName", loginUser.getUsername());
    }
    
    /**
     * 获取当前用户的BladeX用户信息
     */
    @GetMapping("/getUserInfo")
    @PreAuthorize("@ss.hasPermi('system:user:list')")
    @Log(title = "获取BladeX用户信息", businessType = BusinessType.OTHER)
    public AjaxResult getUserInfo()
    {
        try
        {
            LoginUser loginUser = SecurityUtils.getLoginUser();
            if (loginUser == null)
            {
                return AjaxResult.error("用户未登录");
            }
            
            return AjaxResult.success(bladeApiClient.getUserInfo(loginUser.getUserId()));
        }
        catch (ServiceException e)
        {
            return AjaxResult.error(e.getMessage());
        }
    }
    
    /**
     * 清除当前用户的BladeX令牌
     */
    @GetMapping("/clearToken")
    @PreAuthorize("@ss.hasPermi('system:user:list')")
    @Log(title = "清除BladeX令牌", businessType = BusinessType.OTHER)
    public AjaxResult clearToken()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        bladeTokenManager.removeToken(loginUser.getUserId());
        
        return AjaxResult.success("已清除BladeX令牌");
    }

    /**
     * 获取BladeX系统用户列表（用于同步）
     */
    @GetMapping("/getUserList")
    @PreAuthorize("@ss.hasPermi('system:user:list')")
    @Log(title = "获取BladeX用户列表", businessType = BusinessType.OTHER)
    public AjaxResult getUserList(
            @RequestParam(value = "current", defaultValue = "1") Integer current,
            @RequestParam(value = "size", defaultValue = "10") Integer size,
            @RequestParam(value = "account", required = false) String account,
            @RequestParam(value = "realName", required = false) String realName,
            @RequestParam(value = "deptId", required = false) String deptId)
    {
        try
        {
            LoginUser loginUser = SecurityUtils.getLoginUser();
            if (loginUser == null)
            {
                return AjaxResult.error("用户未登录");
            }
            
            Map<String, Object> result = bladeApiClient.getUserList(
                loginUser.getUserId(), current, size, account, realName, deptId);
            
            return AjaxResult.success(result);
        }
        catch (ServiceException e)
        {
            return AjaxResult.error(e.getMessage());
        }
    }

    /**
     * 获取BladeX系统岗位列表
     */
    @GetMapping("/getPostList")
    @PreAuthorize("@ss.hasPermi('system:user:list')")
    @Log(title = "获取BladeX岗位列表", businessType = BusinessType.OTHER)
    public AjaxResult getPostList(
            @RequestParam(value = "current", defaultValue = "1") Integer current,
            @RequestParam(value = "size", defaultValue = "10") Integer size,
            @RequestParam(value = "postName", required = false) String postName,
            @RequestParam(value = "postCode", required = false) String postCode,
            @RequestParam(value = "category", required = false) Integer category)
    {
        try
        {
            LoginUser loginUser = SecurityUtils.getLoginUser();
            if (loginUser == null)
            {
                return AjaxResult.error("用户未登录");
            }
            
            Map<String, Object> result = bladeApiClient.getPostList(
                loginUser.getUserId(), current, size, postName, postCode, category);
            
            return AjaxResult.success(result);
        }
        catch (ServiceException e)
        {
            return AjaxResult.error(e.getMessage());
        }
    }
} 