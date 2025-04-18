package com.ruoyi.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.SysPost;
import com.ruoyi.system.mapper.SysPostMapper;
import com.ruoyi.system.mapper.SysUserPostMapper;
import com.ruoyi.system.service.ISysPostService;

/**
 * 岗位信息 服务层处理
 * 
 * @author ruoyi
 */
@Service
public class SysPostServiceImpl implements ISysPostService
{
    @Autowired
    private SysPostMapper postMapper;

    @Autowired
    private SysUserPostMapper userPostMapper;

    /**
     * 查询岗位信息集合
     * 
     * @param post 岗位信息
     * @return 岗位信息集合
     */
    @Override
    public List<SysPost> selectPostList(SysPost post)
    {
        return postMapper.selectPostList(post);
    }

    /**
     * 查询所有岗位
     * 
     * @return 岗位列表
     */
    @Override
    public List<SysPost> selectPostAll()
    {
        return postMapper.selectPostAll();
    }

    /**
     * 通过岗位ID查询岗位信息
     * 
     * @param postId 岗位ID
     * @return 角色对象信息
     */
    @Override
    public SysPost selectPostById(Long postId)
    {
        return postMapper.selectPostById(postId);
    }

    /**
     * 根据用户ID获取岗位选择框列表
     * 
     * @param userId 用户ID
     * @return 选中岗位ID列表
     */
    @Override
    public List<Long> selectPostListByUserId(Long userId)
    {
        return postMapper.selectPostListByUserId(userId);
    }

    /**
     * 校验岗位名称是否唯一
     * 
     * @param post 岗位信息
     * @return 结果
     */
    @Override
    public boolean checkPostNameUnique(SysPost post)
    {
        Long postId = StringUtils.isNull(post.getPostId()) ? -1L : post.getPostId();
        SysPost info = postMapper.checkPostNameUnique(post.getPostName());
        if (StringUtils.isNotNull(info) && info.getPostId().longValue() != postId.longValue())
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验岗位编码是否唯一
     * 
     * @param post 岗位信息
     * @return 结果
     */
    @Override
    public boolean checkPostCodeUnique(SysPost post)
    {
        Long postId = StringUtils.isNull(post.getPostId()) ? -1L : post.getPostId();
        SysPost info = postMapper.checkPostCodeUnique(post.getPostCode());
        if (StringUtils.isNotNull(info) && info.getPostId().longValue() != postId.longValue())
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 通过岗位ID查询岗位使用数量
     * 
     * @param postId 岗位ID
     * @return 结果
     */
    @Override
    public int countUserPostById(Long postId)
    {
        return userPostMapper.countUserPostById(postId);
    }

    /**
     * 删除岗位信息
     * 
     * @param postId 岗位ID
     * @return 结果
     */
    @Override
    public int deletePostById(Long postId)
    {
        return postMapper.deletePostById(postId);
    }

    /**
     * 批量删除岗位信息
     * 
     * @param postIds 需要删除的岗位ID
     * @return 结果
     */
    @Override
    public int deletePostByIds(Long[] postIds)
    {
        for (Long postId : postIds)
        {
            SysPost post = selectPostById(postId);
            if (countUserPostById(postId) > 0)
            {
                throw new ServiceException(String.format("%1$s已分配,不能删除", post.getPostName()));
            }
        }
        return postMapper.deletePostByIds(postIds);
    }

    /**
     * 新增保存岗位信息
     * 
     * @param post 岗位信息
     * @return 结果
     */
    @Override
    public int insertPost(SysPost post)
    {
        return postMapper.insertPost(post);
    }

    /**
     * 修改保存岗位信息
     * 
     * @param post 岗位信息
     * @return 结果
     */
    @Override
    public int updatePost(SysPost post)
    {
        return postMapper.updatePost(post);
    }

    /**
     * 同步BladeX岗位数据到若依系统
     * 
     * @param bladePostList BladeX岗位数据列表
     * @return 同步结果信息
     */
    @Override
    @Transactional
    public String syncBladePost(List<Map<String, Object>> bladePostList)
    {
        if (bladePostList == null || bladePostList.isEmpty())
        {
            return "未接收到有效的岗位数据";
        }
        
        int insertCount = 0;
        int updateCount = 0;
        
        // 获取当前所有岗位ID和对应对象的映射
        List<SysPost> existingPosts = postMapper.selectPostList(new SysPost());
        Map<Long, SysPost> existingPostMap = existingPosts.stream()
                .collect(Collectors.toMap(SysPost::getPostId, post -> post));
        Map<String, SysPost> existingPostCodeMap = existingPosts.stream()
                .collect(Collectors.toMap(SysPost::getPostCode, post -> post));
        
        // 开始同步岗位数据
        for (Map<String, Object> bladePost : bladePostList)
        {
            try
            {
                // 解析BladeX岗位数据
                String id = getStringValue(bladePost, "id");
                String postCode = getStringValue(bladePost, "postCode");
                String postName = getStringValue(bladePost, "postName");
                
                // 默认为正常状态
                Integer status = 0;
                Object statusObj = bladePost.get("status");
                if (statusObj != null) {
                    status = ((Number) statusObj).intValue();
                    // 状态值转换：BladeX的1对应若依的0(正常)，BladeX的其他值对应若依的1(停用)
                    status = (status == 1) ? 0 : 1;
                }
                
                Integer sort = 0;
                Object sortObj = bladePost.get("sort");
                if (sortObj != null) {
                    sort = ((Number) sortObj).intValue();
                }
                
                // 处理category字段，放到remark中
                String remark = "";
                Object categoryObj = bladePost.get("category");
                if (categoryObj != null) {
                    Integer category = ((Number) categoryObj).intValue();
                    // 映射category到可读的描述
                    String categoryDesc = "未知";
                    switch (category) {
                        case 1: categoryDesc = "高层"; break;
                        case 2: categoryDesc = "中层"; break;
                        case 3: categoryDesc = "基层"; break;
                        default: categoryDesc = "其他"; break;
                    }
                    remark = "岗位类型：" + categoryDesc;
                }
                
                // 如果ID为空，则跳过
                if (StringUtils.isEmpty(id))
                {
                    continue;
                }
                
                Long postId = Long.parseLong(id);
                
                // 准备SysPost对象
                SysPost sysPost = new SysPost();
                sysPost.setPostId(postId);
                sysPost.setPostCode(postCode);
                sysPost.setPostName(postName);
                sysPost.setStatus(status.toString());
                sysPost.setPostSort(sort);
                sysPost.setRemark(remark);
                
                // 检查岗位是否已存在
                if (existingPostMap.containsKey(postId))
                {
                    // 岗位已存在，更新岗位信息
                    sysPost.setUpdateBy(SecurityUtils.getUsername());
                    postMapper.updatePost(sysPost);
                    updateCount++;
                }
                else if (existingPostCodeMap.containsKey(postCode))
                {
                    // 岗位编码已存在，更新岗位信息（使用现有岗位ID）
                    SysPost existingPost = existingPostCodeMap.get(postCode);
                    sysPost.setPostId(existingPost.getPostId());
                    sysPost.setUpdateBy(SecurityUtils.getUsername());
                    postMapper.updatePost(sysPost);
                    updateCount++;
                }
                else
                {
                    // 岗位不存在，新增岗位
                    sysPost.setCreateBy(SecurityUtils.getUsername());
                    postMapper.insertPost(sysPost);
                    insertCount++;
                }
            }
            catch (Exception e)
            {
                throw new ServiceException("同步岗位数据失败: " + e.getMessage());
            }
        }
        
        return String.format("同步完成，新增岗位: %d个，更新岗位: %d个", insertCount, updateCount);
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
