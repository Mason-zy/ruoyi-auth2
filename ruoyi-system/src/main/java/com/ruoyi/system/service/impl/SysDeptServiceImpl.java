package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.annotation.DataScope;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.domain.TreeSelect;
import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.system.mapper.SysDeptMapper;
import com.ruoyi.system.mapper.SysRoleMapper;
import com.ruoyi.system.service.ISysDeptService;

/**
 * 部门管理 服务实现
 * 
 * @author ruoyi
 */
@Service
public class SysDeptServiceImpl implements ISysDeptService
{
    @Autowired
    private SysDeptMapper deptMapper;

    @Autowired
    private SysRoleMapper roleMapper;

    /**
     * 查询部门管理数据
     * 
     * @param dept 部门信息
     * @return 部门信息集合
     */
    @Override
    @DataScope(deptAlias = "d")
    public List<SysDept> selectDeptList(SysDept dept)
    {
        return deptMapper.selectDeptList(dept);
    }

    /**
     * 查询部门树结构信息
     * 
     * @param dept 部门信息
     * @return 部门树信息集合
     */
    @Override
    public List<TreeSelect> selectDeptTreeList(SysDept dept)
    {
        List<SysDept> depts = SpringUtils.getAopProxy(this).selectDeptList(dept);
        return buildDeptTreeSelect(depts);
    }

    /**
     * 构建前端所需要树结构
     * 
     * @param depts 部门列表
     * @return 树结构列表
     */
    @Override
    public List<SysDept> buildDeptTree(List<SysDept> depts)
    {
        List<SysDept> returnList = new ArrayList<SysDept>();
        List<Long> tempList = depts.stream().map(SysDept::getDeptId).collect(Collectors.toList());
        for (SysDept dept : depts)
        {
            // 如果是顶级节点, 遍历该父节点的所有子节点
            if (!tempList.contains(dept.getParentId()))
            {
                recursionFn(depts, dept);
                returnList.add(dept);
            }
        }
        if (returnList.isEmpty())
        {
            returnList = depts;
        }
        return returnList;
    }

    /**
     * 构建前端所需要下拉树结构
     * 
     * @param depts 部门列表
     * @return 下拉树结构列表
     */
    @Override
    public List<TreeSelect> buildDeptTreeSelect(List<SysDept> depts)
    {
        List<SysDept> deptTrees = buildDeptTree(depts);
        return deptTrees.stream().map(TreeSelect::new).collect(Collectors.toList());
    }

    /**
     * 根据角色ID查询部门树信息
     * 
     * @param roleId 角色ID
     * @return 选中部门列表
     */
    @Override
    public List<Long> selectDeptListByRoleId(Long roleId)
    {
        SysRole role = roleMapper.selectRoleById(roleId);
        return deptMapper.selectDeptListByRoleId(roleId, role.isDeptCheckStrictly());
    }

    /**
     * 根据部门ID查询信息
     * 
     * @param deptId 部门ID
     * @return 部门信息
     */
    @Override
    public SysDept selectDeptById(Long deptId)
    {
        return deptMapper.selectDeptById(deptId);
    }

    /**
     * 根据ID查询所有子部门（正常状态）
     * 
     * @param deptId 部门ID
     * @return 子部门数
     */
    @Override
    public int selectNormalChildrenDeptById(Long deptId)
    {
        return deptMapper.selectNormalChildrenDeptById(deptId);
    }

    /**
     * 是否存在子节点
     * 
     * @param deptId 部门ID
     * @return 结果
     */
    @Override
    public boolean hasChildByDeptId(Long deptId)
    {
        int result = deptMapper.hasChildByDeptId(deptId);
        return result > 0;
    }

    /**
     * 查询部门是否存在用户
     * 
     * @param deptId 部门ID
     * @return 结果 true 存在 false 不存在
     */
    @Override
    public boolean checkDeptExistUser(Long deptId)
    {
        int result = deptMapper.checkDeptExistUser(deptId);
        return result > 0;
    }

    /**
     * 校验部门名称是否唯一
     * 
     * @param dept 部门信息
     * @return 结果
     */
    @Override
    public boolean checkDeptNameUnique(SysDept dept)
    {
        Long deptId = StringUtils.isNull(dept.getDeptId()) ? -1L : dept.getDeptId();
        SysDept info = deptMapper.checkDeptNameUnique(dept.getDeptName(), dept.getParentId());
        if (StringUtils.isNotNull(info) && info.getDeptId().longValue() != deptId.longValue())
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验部门是否有数据权限
     * 
     * @param deptId 部门id
     */
    @Override
    public void checkDeptDataScope(Long deptId)
    {
        if (!SysUser.isAdmin(SecurityUtils.getUserId()) && StringUtils.isNotNull(deptId))
        {
            SysDept dept = new SysDept();
            dept.setDeptId(deptId);
            List<SysDept> depts = SpringUtils.getAopProxy(this).selectDeptList(dept);
            if (StringUtils.isEmpty(depts))
            {
                throw new ServiceException("没有权限访问部门数据！");
            }
        }
    }

    /**
     * 新增保存部门信息
     * 
     * @param dept 部门信息
     * @return 结果
     */
    @Override
    public int insertDept(SysDept dept)
    {
        SysDept info = deptMapper.selectDeptById(dept.getParentId());
        // 如果父节点不为正常状态,则不允许新增子节点
        if (!UserConstants.DEPT_NORMAL.equals(info.getStatus()))
        {
            throw new ServiceException("部门停用，不允许新增");
        }
        dept.setAncestors(info.getAncestors() + "," + dept.getParentId());
        return deptMapper.insertDept(dept);
    }

    /**
     * 修改保存部门信息
     * 
     * @param dept 部门信息
     * @return 结果
     */
    @Override
    public int updateDept(SysDept dept)
    {
        SysDept newParentDept = deptMapper.selectDeptById(dept.getParentId());
        SysDept oldDept = deptMapper.selectDeptById(dept.getDeptId());
        if (StringUtils.isNotNull(newParentDept) && StringUtils.isNotNull(oldDept))
        {
            String newAncestors = newParentDept.getAncestors() + "," + newParentDept.getDeptId();
            String oldAncestors = oldDept.getAncestors();
            dept.setAncestors(newAncestors);
            updateDeptChildren(dept.getDeptId(), newAncestors, oldAncestors);
        }
        int result = deptMapper.updateDept(dept);
        if (UserConstants.DEPT_NORMAL.equals(dept.getStatus()) && StringUtils.isNotEmpty(dept.getAncestors())
                && !StringUtils.equals("0", dept.getAncestors()))
        {
            // 如果该部门是启用状态，则启用该部门的所有上级部门
            updateParentDeptStatusNormal(dept);
        }
        return result;
    }

    /**
     * 修改该部门的父级部门状态
     * 
     * @param dept 当前部门
     */
    private void updateParentDeptStatusNormal(SysDept dept)
    {
        String ancestors = dept.getAncestors();
        Long[] deptIds = Convert.toLongArray(ancestors);
        deptMapper.updateDeptStatusNormal(deptIds);
    }

    /**
     * 修改子元素关系
     * 
     * @param deptId 被修改的部门ID
     * @param newAncestors 新的父ID集合
     * @param oldAncestors 旧的父ID集合
     */
    public void updateDeptChildren(Long deptId, String newAncestors, String oldAncestors)
    {
        List<SysDept> children = deptMapper.selectChildrenDeptById(deptId);
        for (SysDept child : children)
        {
            child.setAncestors(child.getAncestors().replaceFirst(oldAncestors, newAncestors));
        }
        if (children.size() > 0)
        {
            deptMapper.updateDeptChildren(children);
        }
    }

    /**
     * 删除部门管理信息
     * 
     * @param deptId 部门ID
     * @return 结果
     */
    @Override
    public int deleteDeptById(Long deptId)
    {
        return deptMapper.deleteDeptById(deptId);
    }

    /**
     * 递归列表
     */
    private void recursionFn(List<SysDept> list, SysDept t)
    {
        // 得到子节点列表
        List<SysDept> childList = getChildList(list, t);
        t.setChildren(childList);
        for (SysDept tChild : childList)
        {
            if (hasChild(list, tChild))
            {
                recursionFn(list, tChild);
            }
        }
    }

    /**
     * 得到子节点列表
     */
    private List<SysDept> getChildList(List<SysDept> list, SysDept t)
    {
        List<SysDept> tlist = new ArrayList<SysDept>();
        Iterator<SysDept> it = list.iterator();
        while (it.hasNext())
        {
            SysDept n = (SysDept) it.next();
            if (StringUtils.isNotNull(n.getParentId()) && n.getParentId().longValue() == t.getDeptId().longValue())
            {
                tlist.add(n);
            }
        }
        return tlist;
    }

    /**
     * 判断是否有子节点
     */
    private boolean hasChild(List<SysDept> list, SysDept t)
    {
        return getChildList(list, t).size() > 0;
    }

    /**
     * 同步BladeX部门数据到若依系统
     * 
     * @param bladeDeptList BladeX部门数据列表
     * @return 同步结果信息
     */
    @Override
    @Transactional
    public String syncBladeDept(List<Map<String, Object>> bladeDeptList)
    {
        if (bladeDeptList == null || bladeDeptList.isEmpty())
        {
            return "未接收到有效的部门数据";
        }
        
        int insertCount = 0;
        int updateCount = 0;
        Map<String, Long> idMapping = new HashMap<>();
        
        // 获取当前所有部门ID和对应对象的映射
        List<SysDept> existingDepts = deptMapper.selectDeptList(new SysDept());
        Map<Long, SysDept> existingDeptMap = existingDepts.stream()
                .collect(Collectors.toMap(SysDept::getDeptId, dept -> dept));
        
        // 先将树形结构扁平化，确保正确处理所有部门
        List<Map<String, Object>> flatDeptList = new ArrayList<>();
        flattenDeptTree(bladeDeptList, flatDeptList);
        
        // 开始同步部门数据
        for (Map<String, Object> bladeDept : flatDeptList)
        {
            try
            {
                // 解析BladeX部门数据
                String id = getStringValue(bladeDept, "id");
                String parentId = getStringValue(bladeDept, "parentId");
                String deptName = getStringValue(bladeDept, "deptName");
                if (StringUtils.isEmpty(deptName)) {
                    deptName = getStringValue(bladeDept, "fullName");
                }
                String fullName = getStringValue(bladeDept, "fullName");
                String ancestors = getStringValue(bladeDept, "ancestors");
                
                // 默认为正常状态
                Integer status = 0;
                Object statusObj = bladeDept.get("status");
                if (statusObj != null) {
                    status = ((Number) statusObj).intValue();
                    // 状态值转换：BladeX的1对应若依的0(正常)，BladeX的其他值对应若依的1(停用)
                    status = (status == 1) ? 0 : 1;
                }
                
                Integer sort = 0;
                Object sortObj = bladeDept.get("sort");
                if (sortObj != null) {
                    sort = ((Number) sortObj).intValue();
                }
                
                // 如果ID为空，则跳过
                if (StringUtils.isEmpty(id))
                {
                    continue;
                }
                
                Long deptId = Long.parseLong(id);
                Long parentDeptId = StringUtils.isEmpty(parentId) || "0".equals(parentId) ? 0L : Long.parseLong(parentId);
                
                // 准备SysDept对象
                SysDept sysDept = new SysDept();
                sysDept.setDeptId(deptId);
                sysDept.setParentId(parentDeptId);
                sysDept.setDeptName(deptName);
                sysDept.setLeader(fullName); // BladeX的fullName对应若依的leader字段
                sysDept.setAncestors(ancestors);
                sysDept.setStatus(status.toString());
                sysDept.setOrderNum(sort);
                sysDept.setDelFlag("0"); // 默认为未删除
                
                // 处理email和phone字段
                String email = getStringValue(bladeDept, "email");
                String phone = getStringValue(bladeDept, "phone");
                sysDept.setEmail(email);
                sysDept.setPhone(phone);
                
                // 检查部门是否已存在
                if (existingDeptMap.containsKey(deptId))
                {
                    // 部门已存在，更新部门信息
                    sysDept.setUpdateBy(SecurityUtils.getUsername());
                    deptMapper.updateDept(sysDept);
                    updateCount++;
                }
                else
                {
                    // 部门不存在，新增部门
                    sysDept.setCreateBy(SecurityUtils.getUsername());
                    deptMapper.insertDept(sysDept);
                    insertCount++;
                }
                
                // 记录ID映射关系，用于后续处理
                idMapping.put(id, deptId);
            }
            catch (Exception e)
            {
                throw new ServiceException("同步部门数据失败: " + e.getMessage());
            }
        }
        
        return String.format("同步完成，新增部门: %d个，更新部门: %d个", insertCount, updateCount);
    }
    
    /**
     * 将树形部门数据扁平化为列表
     * 
     * @param treeList 树形部门列表
     * @param flatList 扁平化结果列表
     */
    private void flattenDeptTree(List<Map<String, Object>> treeList, List<Map<String, Object>> flatList) {
        if (treeList == null || treeList.isEmpty()) {
            return;
        }
        
        for (Map<String, Object> dept : treeList) {
            // 添加当前部门
            flatList.add(dept);
            
            // 递归处理子部门
            @SuppressWarnings("unchecked")
            List<Map<String, Object>> children = (List<Map<String, Object>>) dept.get("children");
            if (children != null && !children.isEmpty()) {
                flattenDeptTree(children, flatList);
            }
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
