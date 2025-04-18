package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.validation.Validator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import com.ruoyi.common.annotation.DataScope;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.bean.BeanValidators;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.system.domain.SysPost;
import com.ruoyi.system.domain.SysUserPost;
import com.ruoyi.system.domain.SysUserRole;
import com.ruoyi.system.mapper.SysPostMapper;
import com.ruoyi.system.mapper.SysRoleMapper;
import com.ruoyi.system.mapper.SysUserMapper;
import com.ruoyi.system.mapper.SysUserPostMapper;
import com.ruoyi.system.mapper.SysUserRoleMapper;
import com.ruoyi.system.service.ISysConfigService;
import com.ruoyi.system.service.ISysDeptService;
import com.ruoyi.system.service.ISysUserService;

/**
 * 用户 业务层处理
 * 
 * @author ruoyi
 */
@Service
public class SysUserServiceImpl implements ISysUserService
{
    private static final Logger log = LoggerFactory.getLogger(SysUserServiceImpl.class);

    @Autowired
    private SysUserMapper userMapper;

    @Autowired
    private SysRoleMapper roleMapper;

    @Autowired
    private SysPostMapper postMapper;

    @Autowired
    private SysUserRoleMapper userRoleMapper;

    @Autowired
    private SysUserPostMapper userPostMapper;

    @Autowired
    private ISysConfigService configService;

    @Autowired
    private ISysDeptService deptService;

    @Autowired
    protected Validator validator;

    /**
     * 根据条件分页查询用户列表
     * 
     * @param user 用户信息
     * @return 用户信息集合信息
     */
    @Override
    @DataScope(deptAlias = "d", userAlias = "u")
    public List<SysUser> selectUserList(SysUser user)
    {
        return userMapper.selectUserList(user);
    }

    /**
     * 根据条件分页查询已分配用户角色列表
     * 
     * @param user 用户信息
     * @return 用户信息集合信息
     */
    @Override
    @DataScope(deptAlias = "d", userAlias = "u")
    public List<SysUser> selectAllocatedList(SysUser user)
    {
        return userMapper.selectAllocatedList(user);
    }

    /**
     * 根据条件分页查询未分配用户角色列表
     * 
     * @param user 用户信息
     * @return 用户信息集合信息
     */
    @Override
    @DataScope(deptAlias = "d", userAlias = "u")
    public List<SysUser> selectUnallocatedList(SysUser user)
    {
        return userMapper.selectUnallocatedList(user);
    }

    /**
     * 通过用户名查询用户
     * 
     * @param userName 用户名
     * @return 用户对象信息
     */
    @Override
    public SysUser selectUserByUserName(String userName)
    {
        return userMapper.selectUserByUserName(userName);
    }

    /**
     * 通过用户ID查询用户
     * 
     * @param userId 用户ID
     * @return 用户对象信息
     */
    @Override
    public SysUser selectUserById(Long userId)
    {
        return userMapper.selectUserById(userId);
    }

    /**
     * 查询用户所属角色组
     * 
     * @param userName 用户名
     * @return 结果
     */
    @Override
    public String selectUserRoleGroup(String userName)
    {
        List<SysRole> list = roleMapper.selectRolesByUserName(userName);
        if (CollectionUtils.isEmpty(list))
        {
            return StringUtils.EMPTY;
        }
        return list.stream().map(SysRole::getRoleName).collect(Collectors.joining(","));
    }

    /**
     * 查询用户所属岗位组
     * 
     * @param userName 用户名
     * @return 结果
     */
    @Override
    public String selectUserPostGroup(String userName)
    {
        List<SysPost> list = postMapper.selectPostsByUserName(userName);
        if (CollectionUtils.isEmpty(list))
        {
            return StringUtils.EMPTY;
        }
        return list.stream().map(SysPost::getPostName).collect(Collectors.joining(","));
    }

    /**
     * 校验用户名称是否唯一
     * 
     * @param user 用户信息
     * @return 结果
     */
    @Override
    public boolean checkUserNameUnique(SysUser user)
    {
        Long userId = StringUtils.isNull(user.getUserId()) ? -1L : user.getUserId();
        SysUser info = userMapper.checkUserNameUnique(user.getUserName());
        if (StringUtils.isNotNull(info) && info.getUserId().longValue() != userId.longValue())
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验手机号码是否唯一
     *
     * @param user 用户信息
     * @return
     */
    @Override
    public boolean checkPhoneUnique(SysUser user)
    {
        Long userId = StringUtils.isNull(user.getUserId()) ? -1L : user.getUserId();
        SysUser info = userMapper.checkPhoneUnique(user.getPhonenumber());
        if (StringUtils.isNotNull(info) && info.getUserId().longValue() != userId.longValue())
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验email是否唯一
     *
     * @param user 用户信息
     * @return
     */
    @Override
    public boolean checkEmailUnique(SysUser user)
    {
        Long userId = StringUtils.isNull(user.getUserId()) ? -1L : user.getUserId();
        SysUser info = userMapper.checkEmailUnique(user.getEmail());
        if (StringUtils.isNotNull(info) && info.getUserId().longValue() != userId.longValue())
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验用户是否允许操作
     * 
     * @param user 用户信息
     */
    @Override
    public void checkUserAllowed(SysUser user)
    {
        if (StringUtils.isNotNull(user.getUserId()) && user.isAdmin())
        {
            throw new ServiceException("不允许操作超级管理员用户");
        }
    }

    /**
     * 校验用户是否有数据权限
     * 
     * @param userId 用户id
     */
    @Override
    public void checkUserDataScope(Long userId)
    {
        if (!SysUser.isAdmin(SecurityUtils.getUserId()))
        {
            SysUser user = new SysUser();
            user.setUserId(userId);
            List<SysUser> users = SpringUtils.getAopProxy(this).selectUserList(user);
            if (StringUtils.isEmpty(users))
            {
                throw new ServiceException("没有权限访问用户数据！");
            }
        }
    }

    /**
     * 新增保存用户信息
     * 
     * @param user 用户信息
     * @return 结果
     */
    @Override
    @Transactional
    public int insertUser(SysUser user)
    {
        // 新增用户信息
        int rows = userMapper.insertUser(user);
        // 新增用户岗位关联
        insertUserPost(user);
        // 新增用户与角色管理
        insertUserRole(user);
        return rows;
    }

    /**
     * 注册用户信息
     * 
     * @param user 用户信息
     * @return 结果
     */
    @Override
    public boolean registerUser(SysUser user)
    {
        return userMapper.insertUser(user) > 0;
    }

    /**
     * 修改保存用户信息
     * 
     * @param user 用户信息
     * @return 结果
     */
    @Override
    @Transactional
    public int updateUser(SysUser user)
    {
        Long userId = user.getUserId();
        // 删除用户与角色关联
        userRoleMapper.deleteUserRoleByUserId(userId);
        // 新增用户与角色管理
        insertUserRole(user);
        // 删除用户与岗位关联
        userPostMapper.deleteUserPostByUserId(userId);
        // 新增用户与岗位管理
        insertUserPost(user);
        return userMapper.updateUser(user);
    }

    /**
     * 用户授权角色
     * 
     * @param userId 用户ID
     * @param roleIds 角色组
     */
    @Override
    @Transactional
    public void insertUserAuth(Long userId, Long[] roleIds)
    {
        userRoleMapper.deleteUserRoleByUserId(userId);
        insertUserRole(userId, roleIds);
    }

    /**
     * 修改用户状态
     * 
     * @param user 用户信息
     * @return 结果
     */
    @Override
    public int updateUserStatus(SysUser user)
    {
        return userMapper.updateUser(user);
    }

    /**
     * 修改用户基本信息
     * 
     * @param user 用户信息
     * @return 结果
     */
    @Override
    public int updateUserProfile(SysUser user)
    {
        return userMapper.updateUser(user);
    }

    /**
     * 修改用户头像
     * 
     * @param userName 用户名
     * @param avatar 头像地址
     * @return 结果
     */
    @Override
    public boolean updateUserAvatar(String userName, String avatar)
    {
        return userMapper.updateUserAvatar(userName, avatar) > 0;
    }

    /**
     * 重置用户密码
     * 
     * @param user 用户信息
     * @return 结果
     */
    @Override
    public int resetPwd(SysUser user)
    {
        return userMapper.updateUser(user);
    }

    /**
     * 重置用户密码
     * 
     * @param userName 用户名
     * @param password 密码
     * @return 结果
     */
    @Override
    public int resetUserPwd(String userName, String password)
    {
        return userMapper.resetUserPwd(userName, password);
    }

    /**
     * 新增用户角色信息
     * 
     * @param user 用户对象
     */
    public void insertUserRole(SysUser user)
    {
        this.insertUserRole(user.getUserId(), user.getRoleIds());
    }

    /**
     * 新增用户岗位信息
     * 
     * @param user 用户对象
     */
    public void insertUserPost(SysUser user)
    {
        Long[] posts = user.getPostIds();
        if (StringUtils.isNotEmpty(posts))
        {
            // 新增用户与岗位管理
            List<SysUserPost> list = new ArrayList<SysUserPost>(posts.length);
            for (Long postId : posts)
            {
                SysUserPost up = new SysUserPost();
                up.setUserId(user.getUserId());
                up.setPostId(postId);
                list.add(up);
            }
            userPostMapper.batchUserPost(list);
        }
    }

    /**
     * 新增用户角色信息
     * 
     * @param userId 用户ID
     * @param roleIds 角色组
     */
    public void insertUserRole(Long userId, Long[] roleIds)
    {
        if (StringUtils.isNotEmpty(roleIds))
        {
            // 新增用户与角色管理
            List<SysUserRole> list = new ArrayList<SysUserRole>(roleIds.length);
            for (Long roleId : roleIds)
            {
                SysUserRole ur = new SysUserRole();
                ur.setUserId(userId);
                ur.setRoleId(roleId);
                list.add(ur);
            }
            userRoleMapper.batchUserRole(list);
        }
    }

    /**
     * 通过用户ID删除用户
     * 
     * @param userId 用户ID
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteUserById(Long userId)
    {
        // 删除用户与角色关联
        userRoleMapper.deleteUserRoleByUserId(userId);
        // 删除用户与岗位表
        userPostMapper.deleteUserPostByUserId(userId);
        return userMapper.deleteUserById(userId);
    }

    /**
     * 批量删除用户信息
     * 
     * @param userIds 需要删除的用户ID
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteUserByIds(Long[] userIds)
    {
        for (Long userId : userIds)
        {
            checkUserAllowed(new SysUser(userId));
            checkUserDataScope(userId);
        }
        // 删除用户与角色关联
        userRoleMapper.deleteUserRole(userIds);
        // 删除用户与岗位关联
        userPostMapper.deleteUserPost(userIds);
        return userMapper.deleteUserByIds(userIds);
    }

    /**
     * 导入用户数据
     * 
     * @param userList 用户数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @param operName 操作用户
     * @return 结果
     */
    @Override
    public String importUser(List<SysUser> userList, Boolean isUpdateSupport, String operName)
    {
        if (StringUtils.isNull(userList) || userList.size() == 0)
        {
            throw new ServiceException("导入用户数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        for (SysUser user : userList)
        {
            try
            {
                // 验证是否存在这个用户
                SysUser u = userMapper.selectUserByUserName(user.getUserName());
                if (StringUtils.isNull(u))
                {
                    BeanValidators.validateWithException(validator, user);
                    deptService.checkDeptDataScope(user.getDeptId());
                    String password = configService.selectConfigByKey("sys.user.initPassword");
                    user.setPassword(SecurityUtils.encryptPassword(password));
                    user.setCreateBy(operName);
                    userMapper.insertUser(user);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、账号 " + user.getUserName() + " 导入成功");
                }
                else if (isUpdateSupport)
                {
                    BeanValidators.validateWithException(validator, user);
                    checkUserAllowed(u);
                    checkUserDataScope(u.getUserId());
                    deptService.checkDeptDataScope(user.getDeptId());
                    user.setUserId(u.getUserId());
                    user.setUpdateBy(operName);
                    userMapper.updateUser(user);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、账号 " + user.getUserName() + " 更新成功");
                }
                else
                {
                    failureNum++;
                    failureMsg.append("<br/>" + failureNum + "、账号 " + user.getUserName() + " 已存在");
                }
            }
            catch (Exception e)
            {
                failureNum++;
                String msg = "<br/>" + failureNum + "、账号 " + user.getUserName() + " 导入失败：";
                failureMsg.append(msg + e.getMessage());
                log.error(msg, e);
            }
        }
        if (failureNum > 0)
        {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
            throw new ServiceException(failureMsg.toString());
        }
        else
        {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
        }
        return successMsg.toString();
    }

    /**
     * 同步BladeX用户数据到若依系统
     * 
     * @param bladeUserList BladeX用户数据列表
     * @return 同步结果信息
     */
    @Override
    @Transactional
    public String syncBladeUser(List<Map<String, Object>> bladeUserList)
    {
        if (bladeUserList == null || bladeUserList.isEmpty())
        {
            return "未接收到有效的用户数据";
        }
        
        int insertCount = 0;
        int updateCount = 0;
        int postRelationCount = 0;
        StringBuilder warningMsg = new StringBuilder(); // 收集警告信息
        
        // 获取所有岗位，用于后续匹配岗位ID
        List<SysPost> allPosts = postMapper.selectPostAll();
        Map<String, SysPost> postCodeMap = allPosts.stream()
                .collect(Collectors.toMap(SysPost::getPostCode, post -> post));
        
        for (Map<String, Object> bladeUser : bladeUserList)
        {
            try
            {
                // 解析BladeX用户数据
                String id = getStringValue(bladeUser, "id");
                String account = getStringValue(bladeUser, "account");
                String realName = getStringValue(bladeUser, "realName");
                String email = getStringValue(bladeUser, "email");
                String phone = getStringValue(bladeUser, "phone");
                String avatar = getStringValue(bladeUser, "avatar");
                String sex = getStringValue(bladeUser, "sex");
                String deptId = getStringValue(bladeUser, "deptId");
                
                // 状态: BladeX的1对应若依的0(正常)，其他值对应1(停用)
                String status = "0";
                Object statusObj = bladeUser.get("status");
                if (statusObj != null) {
                    int statusValue = ((Number) statusObj).intValue();
                    status = (statusValue == 1) ? "0" : "1";
                }
                
                // 删除标志: BladeX的0对应若依的0(存在)，1对应2(删除)
                String delFlag = "0";
                Object deletedObj = bladeUser.get("isDeleted");
                if (deletedObj != null) {
                    int deleteValue = ((Number) deletedObj).intValue();
                    delFlag = (deleteValue == 0) ? "0" : "2";
                }
                
                // 性别转换: 需要确认对应关系
                if (sex != null) {
                    // BladeX的性别值(1=男, 2=女, -1=未知)转换为若依的性别值(0=男,1=女,2=未知)
                    switch (sex) {
                        case "1":
                            sex = "0"; // 男
                            break;
                        case "2":
                            sex = "1"; // 女
                            break;
                        default:
                            sex = "2"; // 未知或其他值
                            break;
                    }
                } else {
                    sex = "2"; // 默认为未知
                }
                
                // 如果ID为空，则跳过
                if (StringUtils.isEmpty(id) || StringUtils.isEmpty(account))
                {
                    String warning = "用户ID或账号为空，跳过同步";
                    log.warn(warning);
                    warningMsg.append("<br/>- ").append(warning);
                    continue;
                }
                
                Long userId = Long.parseLong(id);
                
                // 准备SysUser对象
                SysUser sysUser = new SysUser();
                sysUser.setUserId(userId);
                sysUser.setUserName(account);
                sysUser.setNickName(realName);
                sysUser.setEmail(email);
                sysUser.setPhonenumber(phone);
                sysUser.setAvatar(avatar);
                sysUser.setSex(sex);
                sysUser.setStatus(status);
                sysUser.setDelFlag(delFlag);
                
                // 设置部门ID
                if (StringUtils.isNotEmpty(deptId)) {
                    sysUser.setDeptId(Long.parseLong(deptId));
                }
                
                // 默认密码设置
                // 注意：实际应用中应该为同步的用户设置合适的初始密码或使用随机密码并通知用户修改
                sysUser.setPassword(SecurityUtils.encryptPassword("123456"));
                
                // 检查用户是否已存在
                SysUser existUser = userMapper.selectUserById(userId);
                if (existUser != null)
                {
                    // 用户已存在，更新用户信息
                    if (checkUserNameUnique(sysUser) == UserConstants.UNIQUE) {
                        sysUser.setUpdateBy(SecurityUtils.getUsername());
                        userMapper.updateUser(sysUser);
                        updateCount++;
                        
                        // 处理岗位关联
                        syncUserPost(sysUser, bladeUser, postCodeMap);
                        postRelationCount++;
                    } else {
                        String warning = String.format("用户名 '%s' 已存在，无法更新 ID '%s'", account, id);
                        log.warn(warning);
                        warningMsg.append("<br/>- ").append(warning);
                    }
                }
                else
                {
                    // 用户不存在，新增用户
                    if (checkUserNameUnique(sysUser) == UserConstants.UNIQUE)
                    {
                        sysUser.setCreateBy(SecurityUtils.getUsername());
                        userMapper.insertUser(sysUser);
                        insertCount++;
                        
                        // 处理岗位关联
                        syncUserPost(sysUser, bladeUser, postCodeMap);
                        postRelationCount++;
                    } else {
                        String warning = String.format("用户名 '%s' 已存在，无法新增", account);
                        log.warn(warning);
                        warningMsg.append("<br/>- ").append(warning);
                    }
                }
            }
            catch (Exception e)
            {
                String error = "同步用户数据失败: " + e.getMessage();
                log.error(error, e);
                warningMsg.append("<br/>- ").append(error);
            }
        }
        
        StringBuilder resultMsg = new StringBuilder();
        resultMsg.append(String.format("同步完成，新增用户: %d个，更新用户: %d个，更新岗位关联: %d个", 
                insertCount, updateCount, postRelationCount));
        
        // 如果有警告信息，添加到结果中
        if (warningMsg.length() > 0) {
            resultMsg.append("<br/><br/>警告信息:").append(warningMsg);
        }
        
        return resultMsg.toString();
    }
    
    /**
     * 同步用户与岗位关联关系
     */
    private void syncUserPost(SysUser user, Map<String, Object> bladeUser, Map<String, SysPost> postCodeMap)
    {
        try
        {
            // 先删除用户与岗位关联
            userPostMapper.deleteUserPostByUserId(user.getUserId());
            
            // 获取BladeX用户的postId
            Object postIdObj = bladeUser.get("postId");
            if (postIdObj == null) {
                return;
            }
            
            String postId = postIdObj.toString();
            if (StringUtils.isEmpty(postId)) {
                return;
            }
            
            // 从BladeX获取岗位编码
            Object postCodeObj = bladeUser.get("postCode");
            String postCode = (postCodeObj != null) ? postCodeObj.toString() : null;
            
            // 根据岗位编码查找若依系统中的岗位
            if (StringUtils.isNotEmpty(postCode) && postCodeMap.containsKey(postCode)) {
                SysPost post = postCodeMap.get(postCode);
                // 插入用户岗位关联记录
                Long[] postIds = {post.getPostId()};
                user.setPostIds(postIds);
                insertUserPost(user);
                log.info("用户 {} 关联岗位 {} 成功", user.getUserName(), post.getPostName());
            } else {
                // 直接使用BladeX的岗位ID
                Long bladePostId = Long.parseLong(postId);
                SysPost post = postMapper.selectPostById(bladePostId);
                if (post != null) {
                    // 插入用户岗位关联记录
                    Long[] postIds = {post.getPostId()};
                    user.setPostIds(postIds);
                    insertUserPost(user);
                    log.info("用户 {} 关联岗位 {} 成功", user.getUserName(), post.getPostName());
                } else {
                    log.warn("未找到用户 {} 对应的岗位信息，postId={}, postCode={}", 
                            user.getUserName(), postId, postCode);
                }
            }
        }
        catch (Exception e)
        {
            log.error("同步用户岗位关联失败: {}", e.getMessage(), e);
        }
    }
    
    /**
     * 从Map中获取字符串值，避免类型转换异常
     */
    private String getStringValue(Map<String, Object> map, String key)
    {
        Object value = map.get(key);
        return value != null ? value.toString() : "";
    }
}

