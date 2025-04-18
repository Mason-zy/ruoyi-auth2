<template>
  <div class="app-container">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>BladeX API 测试面板</span>
      </div>
      <el-row :gutter="20" class="mb20">
        <el-col :span="24">
          <el-button type="primary" :loading="loading" @click="handleCheckToken">检查令牌状态</el-button>
          <el-button type="success" :loading="loading" @click="handleGetUserInfo">获取用户信息</el-button>
          <el-button type="danger" :loading="loading" @click="handleClearToken">清除令牌</el-button>
          <el-button type="warning" :loading="loading" @click="openUserListDialog">获取用户列表</el-button>
          <el-button type="info" :loading="loading" @click="openPostListDialog">获取岗位列表</el-button>
          <el-button :loading="loading" @click="handleGetDeptList">获取部门列表</el-button>
        </el-col>
      </el-row>

      <el-divider content-position="left">令牌状态信息</el-divider>
      <el-descriptions class="margin-top" :column="3" border v-if="tokenInfo.hasToken !== undefined">
        <el-descriptions-item>
          <template slot="label">令牌状态</template>
          <el-tag :type="tokenInfo.hasToken ? 'success' : 'danger'">
            {{ tokenInfo.hasToken ? '有效' : '无效' }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">用户ID</template>
          {{ tokenInfo.userId }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">用户名</template>
          {{ tokenInfo.userName }}
        </el-descriptions-item>
      </el-descriptions>

      <el-divider content-position="left">响应结果</el-divider>
      
      <el-row>
        <el-col :span="24">
          <el-input
            type="textarea"
            :rows="12"
            placeholder="API响应结果将显示在这里"
            v-model="responseText"
            readonly
          >
          </el-input>
        </el-col>
      </el-row>
    </el-card>

    <!-- 用户列表查询弹窗 -->
    <el-dialog title="BladeX用户列表查询" :visible.sync="userListDialogVisible" width="80%" append-to-body>
      <el-form :model="queryParams" ref="queryForm" :inline="true" class="mb20">
        <el-form-item label="账号" prop="account">
          <el-input
            v-model="queryParams.account"
            placeholder="请输入账号"
            clearable
            style="width: 160px"
          />
        </el-form-item>
        <el-form-item label="姓名" prop="realName">
          <el-input
            v-model="queryParams.realName"
            placeholder="请输入姓名"
            clearable
            style="width: 160px"
          />
        </el-form-item>
        <el-form-item label="部门ID" prop="deptId">
          <el-input
            v-model="queryParams.deptId"
            placeholder="请输入部门ID"
            clearable
            style="width: 160px"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" :loading="loading" @click="handleGetUserList">搜索</el-button>
          <el-button icon="el-icon-refresh" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
      
      <div class="action-buttons" style="margin-bottom: 15px;">
        <el-button type="success" icon="el-icon-download" :loading="userSyncLoading" @click="handleSyncUsers">同步到若依系统</el-button>
      </div>
      
      <!-- 用户列表表格 -->
      <el-table
        v-loading="loading"
        :data="userList"
        border
        @selection-change="handleSelectionChange"
        style="width: 100%">
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column prop="id" label="用户ID" width="180" />
        <el-table-column prop="account" label="账号" width="120" />
        <el-table-column prop="realName" label="姓名" width="120" />
        <el-table-column prop="deptName" label="部门" width="150" />
        <el-table-column prop="postName" label="岗位" width="150" />
        <el-table-column prop="email" label="邮箱" width="180" />
        <el-table-column prop="phone" label="手机号" width="120" />
        <el-table-column prop="createTime" label="创建时间" width="160" />
      </el-table>
      
      <!-- 分页 -->
      <pagination
        v-if="total>0"
        :total="total"
        :page.sync="queryParams.current"
        :limit.sync="queryParams.size"
        @pagination="handleGetUserList"
      />
      
      <div slot="footer" class="dialog-footer">
        <el-button @click="userListDialogVisible = false">关 闭</el-button>
      </div>
    </el-dialog>
    
    <!-- 岗位列表查询弹窗 -->
    <el-dialog title="BladeX岗位列表查询" :visible.sync="postListDialogVisible" width="80%" append-to-body>
      <el-form :model="postQueryParams" ref="postQueryForm" :inline="true" class="mb20">
        <el-form-item label="岗位名称" prop="postName">
          <el-input
            v-model="postQueryParams.postName"
            placeholder="请输入岗位名称"
            clearable
            style="width: 160px"
          />
        </el-form-item>
        <el-form-item label="岗位编号" prop="postCode">
          <el-input
            v-model="postQueryParams.postCode"
            placeholder="请输入岗位编号"
            clearable
            style="width: 160px"
          />
        </el-form-item>
        <el-form-item label="岗位类型" prop="category">
          <el-select v-model="postQueryParams.category" placeholder="请选择岗位类型" clearable style="width: 160px">
            <el-option label="全部" value=""></el-option>
            <el-option label="高层" :value="1"></el-option>
            <el-option label="中层" :value="2"></el-option>
            <el-option label="基层" :value="3"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" :loading="loading" @click="handleGetPostList">搜索</el-button>
          <el-button icon="el-icon-refresh" @click="resetPostQuery">重置</el-button>
        </el-form-item>
      </el-form>
      
      <div class="action-buttons" style="margin-bottom: 15px;">
        <el-button type="success" icon="el-icon-download" :loading="postSyncLoading" @click="handleSyncPosts">同步到若依系统</el-button>
      </div>
      
      <!-- 岗位列表表格 -->
      <el-table
        v-loading="loading"
        :data="postList"
        border
        @selection-change="handlePostSelectionChange"
        style="width: 100%">
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column prop="id" label="岗位ID" width="180" />
        <el-table-column prop="postCode" label="岗位编号" width="120" />
        <el-table-column prop="postName" label="岗位名称" width="150" />
        <el-table-column prop="category" label="岗位类型" width="100">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.category === 1" type="danger">高层</el-tag>
            <el-tag v-else-if="scope.row.category === 2" type="warning">中层</el-tag>
            <el-tag v-else-if="scope.row.category === 3" type="success">基层</el-tag>
            <el-tag v-else type="info">未知</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="sort" label="排序" width="80" />
        <el-table-column prop="createTime" label="创建时间" width="160" />
        <el-table-column prop="remark" label="备注" />
      </el-table>
      
      <!-- 分页 -->
      <pagination
        v-if="postTotal>0"
        :total="postTotal"
        :page.sync="postQueryParams.current"
        :limit.sync="postQueryParams.size"
        @pagination="handleGetPostList"
      />
      
      <div slot="footer" class="dialog-footer">
        <el-button @click="postListDialogVisible = false">关 闭</el-button>
      </div>
    </el-dialog>
    
    <!-- 部门列表树形图弹窗 -->
    <el-dialog title="BladeX部门列表" :visible.sync="deptListDialogVisible" width="80%" append-to-body>
      <div class="action-buttons" style="margin-bottom: 15px;">
        <el-button type="primary" icon="el-icon-refresh" :loading="loading" @click="handleGetDeptList">刷新部门数据</el-button>
        <el-button type="success" icon="el-icon-download" :loading="deptSyncLoading" @click="handleSyncDepts">同步到若依系统</el-button>
      </div>
      <el-row v-if="deptList.length > 0">
        <el-col :span="10">
          <el-card shadow="never" class="dept-tree-card">
            <div slot="header" class="clearfix">
              <span>部门结构</span>
            </div>
            <el-tree
              :data="deptList"
              :props="deptProps"
              node-key="id"
              default-expand-all
              :expand-on-click-node="false"
              highlight-current
              @node-click="handleNodeClick"
            >
              <span class="custom-tree-node" slot-scope="{ node, data }">
                <span>{{ data.deptName }}</span>
                <el-tag v-if="data.status === 1" type="success" size="mini">启用</el-tag>
                <el-tag v-else-if="data.status === -1" type="danger" size="mini">禁用</el-tag>
              </span>
            </el-tree>
          </el-card>
        </el-col>
        <el-col :span="14">
          <el-card shadow="never" class="dept-detail-card">
            <div slot="header" class="clearfix">
              <span>部门详情</span>
            </div>
            <div v-if="selectedDept">
              <el-descriptions border :column="1">
                <el-descriptions-item label="部门ID">{{ selectedDept.id }}</el-descriptions-item>
                <el-descriptions-item label="部门名称">{{ selectedDept.deptName }}</el-descriptions-item>
                <el-descriptions-item label="部门全称">{{ selectedDept.fullName }}</el-descriptions-item>
                <el-descriptions-item label="部门类型">
                  {{ formatDeptCategory(selectedDept.deptCategory) }}
                  <el-tag type="info" size="mini">{{ selectedDept.deptCategory }}</el-tag>
                </el-descriptions-item>
                <el-descriptions-item label="部门状态">
                  <el-tag v-if="selectedDept.status === 1" type="success">启用</el-tag>
                  <el-tag v-else-if="selectedDept.status === -1" type="danger">禁用</el-tag>
                  <el-tag v-else type="info">未知</el-tag>
                </el-descriptions-item>
                <el-descriptions-item label="上级部门">{{ selectedDept.parentName || '无' }}</el-descriptions-item>
                <el-descriptions-item label="排序">{{ selectedDept.sort }}</el-descriptions-item>
                <el-descriptions-item label="祖级列表">{{ selectedDept.ancestors || '无' }}</el-descriptions-item>
                <el-descriptions-item label="备注">{{ selectedDept.remark || '无' }}</el-descriptions-item>
              </el-descriptions>
            </div>
            <el-empty v-else description="请选择部门查看详情"></el-empty>
          </el-card>
        </el-col>
      </el-row>
      <el-empty v-else description="暂无部门数据"></el-empty>
      
      <div slot="footer" class="dialog-footer">
        <el-button @click="deptListDialogVisible = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { 
  checkToken, 
  getUserInfo, 
  clearToken, 
  getUserList, 
  getPostList, 
  getDeptList, 
  syncBladeDeptToRuoyi, 
  syncBladePostToRuoyi,
  syncBladeUserToRuoyi
} from "@/api/blade/apiTest";
import Pagination from "@/components/Pagination";

export default {
  name: "BladeApiTest",
  components: { Pagination },
  data() {
    return {
      responseText: "",
      loading: false,
      tokenInfo: {},
      userListDialogVisible: false,
      userList: [],
      userSelection: [],
      userSyncLoading: false,
      total: 0,
      queryParams: {
        current: 1,
        size: 10,
        account: undefined,
        realName: undefined,
        deptId: undefined
      },
      // 岗位列表相关变量
      postListDialogVisible: false,
      postList: [],
      postTotal: 0,
      postQueryParams: {
        current: 1,
        size: 10,
        postName: undefined,
        postCode: undefined,
        category: undefined
      },
      // 部门列表相关变量
      deptListDialogVisible: false,
      deptList: [],
      deptProps: {
        children: 'children',
        label: 'deptName'
      },
      selectedDept: null,
      postSyncLoading: false,
      deptSelection: [],
      deptSyncLoading: false
    };
  },
  created() {
    // 页面加载时自动检查令牌状态
    this.handleCheckToken();
  },
  methods: {
    // 格式化JSON响应为更易读的形式
    formatResponse(response) {
      try {
        // 如果是错误对象，尝试提取有用信息
        if (response instanceof Error) {
          const result = {
            name: response.name,
            message: response.message,
            stack: response.stack
          };
          
          // 添加响应相关信息（如果存在）
          if (response.response) {
            result.status = response.response.status;
            result.statusText = response.response.statusText;
            result.data = response.response.data;
          }
          
          // 添加请求相关信息（如果存在）
          if (response.request) {
            result.requestMethod = response.request.method;
            result.requestUrl = response.request.responseURL;
          }
          
          return JSON.stringify(result, null, 2);
        }
        
        // 常规响应处理
        return JSON.stringify(response, null, 2);
      } catch (error) {
        console.error("格式化响应出错:", error);
        return String(response);
      }
    },
    
    // 检查令牌状态
    handleCheckToken() {
      this.loading = true;
      this.responseText = "正在检查令牌状态...";
      
      checkToken()
        .then(res => {
          // 直接显示完整响应以调试
          this.responseText = "成功响应:\n" + this.formatResponse(res);
          
          // 无论数据结构如何，尝试从任何可能的位置提取信息
          const data = res.data || res;
          const hasToken = data.hasToken;
          const userId = data.userId;
          const userName = data.userName;
          
          if (hasToken !== undefined) {
            this.tokenInfo = { hasToken, userId, userName };
          }
        })
        .catch(error => {
          this.responseText = "请求失败:\n" + this.formatResponse(error);
        })
        .finally(() => {
          this.loading = false;
        });
    },
    
    // 获取用户信息
    handleGetUserInfo() {
      this.loading = true;
      this.responseText = "正在获取用户信息...";
      getUserInfo().then(response => {
        this.responseText = this.formatResponse(response);
      }).catch(error => {
        this.responseText = "请求失败: " + this.formatResponse(error);
      }).finally(() => {
        this.loading = false;
      });
    },
    
    // 清除令牌
    handleClearToken() {
      this.$confirm('确定要清除当前用户的BladeX令牌吗?', '警告', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.loading = true;
        this.responseText = "正在清除令牌...";
        clearToken().then(response => {
          this.responseText = this.formatResponse(response);
          this.$message({
            type: 'success',
            message: '令牌已清除!'
          });
          // 清除令牌后更新状态信息
          this.handleCheckToken();
        }).catch(error => {
          this.responseText = "请求失败: " + this.formatResponse(error);
        }).finally(() => {
          this.loading = false;
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消清除'
        });
      });
    },
    
    // 打开用户列表查询弹窗
    openUserListDialog() {
      this.userListDialogVisible = true;
      this.handleGetUserList();
    },
    
    // 获取用户列表
    handleGetUserList() {
      this.loading = true;
      
      getUserList(this.queryParams).then(response => {
        // 更新响应结果显示
        this.responseText = this.formatResponse(response);
        
        // 处理嵌套的数据结构
        if (response.code === 200 && response.data) {
          const nestedData = response.data;
          if (nestedData.code === 200 && nestedData.data) {
            const pageData = nestedData.data;
            this.userList = pageData.records || [];
            this.total = Number(pageData.total) || 0;
            
            this.$message({
              type: 'success',
              message: '成功获取用户列表，共 ' + this.total + ' 条记录'
            });
          } else {
            this.$message.error('获取用户列表失败: ' + (nestedData.msg || '未知错误'));
          }
        } else {
          this.$message.error('获取用户列表失败: ' + (response.msg || '未知错误'));
        }
      }).catch(error => {
        this.responseText = "请求失败: " + this.formatResponse(error);
        this.$message.error('获取用户列表失败: ' + error);
      }).finally(() => {
        this.loading = false;
      });
    },
    
    // 重置查询条件
    resetQuery() {
      this.queryParams = {
        current: 1,
        size: 10,
        account: undefined,
        realName: undefined,
        deptId: undefined
      };
      this.handleGetUserList();
    },
    
    // 打开岗位列表查询弹窗
    openPostListDialog() {
      this.postListDialogVisible = true;
      this.handleGetPostList();
    },
    
    // 获取岗位列表
    handleGetPostList() {
      this.loading = true;
      
      getPostList(this.postQueryParams).then(response => {
        // 更新响应结果显示
        this.responseText = this.formatResponse(response);
        
        // 处理嵌套的数据结构
        if (response.code === 200 && response.data) {
          const nestedData = response.data;
          if (nestedData.code === 200 && nestedData.data) {
            const pageData = nestedData.data;
            this.postList = pageData.records || [];
            this.postTotal = Number(pageData.total) || 0;
            
            this.$message({
              type: 'success',
              message: '成功获取岗位列表，共 ' + this.postTotal + ' 条记录'
            });
          } else {
            this.$message.error('获取岗位列表失败: ' + (nestedData.msg || '未知错误'));
          }
        } else {
          this.$message.error('获取岗位列表失败: ' + (response.msg || '未知错误'));
        }
      }).catch(error => {
        this.responseText = "请求失败: " + this.formatResponse(error);
        this.responseText = "请求失败: " + this.formatResponse(error);
      }).finally(() => {
        this.loading = false;
      });
    },
    
    // 重置岗位查询条件
    resetPostQuery() {
      this.postQueryParams = {
        current: 1,
        size: 10,
        postName: undefined,
        postCode: undefined,
        category: undefined
      };
      this.handleGetPostList();
    },
    
    // 获取部门列表
    handleGetDeptList() {
      this.loading = true;
      this.responseText = "正在获取部门列表数据...";
      
      getDeptList().then(response => {
        // 更新响应结果显示
        this.responseText = this.formatResponse(response);
        
        if (response.code === 200 && response.data && response.data.data) {
          this.deptList = response.data.data;
          this.deptListDialogVisible = true;
          
          this.$message({
            type: 'success',
            message: '成功获取部门列表'
          });
        } else if (response.code === 200 && response.data) {
          // 直接返回data数组的情况
          this.deptList = response.data;
          this.deptListDialogVisible = true;
          
          this.$message({
            type: 'success',
            message: '成功获取部门列表'
          });
        } else {
          this.$message.error('获取部门列表失败: ' + (response.msg || '未知错误'));
        }
      }).catch(error => {
        this.responseText = "请求失败: " + this.formatResponse(error);
        this.$message.error('获取部门列表失败: ' + error);
      }).finally(() => {
        this.loading = false;
      });
    },
    
    // 格式化部门类型
    formatDeptCategory(category) {
      const categoryMap = {
        1: '公司',
        2: '部门',
        3: '小组',
        4: '其他'
      };
      return categoryMap[category] || '未知';
    },
    
    // 处理部门树节点点击
    handleNodeClick(data) {
      this.selectedDept = data;
      console.log('选中部门节点:', data);
    },
    
    // 处理岗位表格选择变化
    handlePostSelectionChange(selection) {
      this.postSelection = selection;
    },
    
    // 同步岗位数据到若依系统
    handleSyncPosts() {
      if (!this.postSelection || this.postSelection.length === 0) {
        this.$message.error('请至少选择一个岗位进行同步');
        return;
      }
      
      this.$confirm('确认将选中的BladeX岗位数据同步到若依系统吗？此操作可能会覆盖现有数据', '警告', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.postSyncLoading = true;
        this.responseText = "正在同步岗位数据到若依系统...";
        
        // 打印要发送的数据，便于调试
        console.log('发送同步请求，数据数量:', this.postSelection.length);
        
        // 使用选中的岗位数据进行同步
        syncBladePostToRuoyi(this.postSelection).then(response => {
          console.log('同步响应成功:', response);
          this.responseText = this.formatResponse(response);
          
          // 判断响应中是否包含警告信息
          if (response.msg && response.msg.includes("警告信息")) {
            // 有警告信息，使用HTML格式展示
            this.$alert(response.msg, "同步结果", {
              dangerouslyUseHTMLString: true,
              closeOnClickModal: false
            });
          } else {
            // 没有警告，直接显示成功信息
            this.$modal.msgSuccess(response.msg || "同步成功");
          }
        }).catch(error => {
          console.error('同步请求失败:', error);
          
          // 处理错误响应
          let errorMessage = '';
          if (error.response) {
            console.error('错误响应数据:', error.response);
            errorMessage = `状态码: ${error.response.status}, 信息: ${error.response.statusText || '未知'}`;
          } else if (error.request) {
            console.error('无响应:', error.request);
            errorMessage = '服务器未响应请求';
          } else {
            console.error('请求配置错误:', error.message);
            errorMessage = error.message || '未知错误';
          }
          
          this.responseText = `同步失败: ${errorMessage}\n${this.formatResponse(error)}`;
          
          // 使用通知而不是弹窗，避免遮挡界面
          this.$notify.error({
            title: '同步失败',
            message: errorMessage,
            duration: 5000
          });
        }).finally(() => {
          this.postSyncLoading = false;
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消同步操作'
        });
      });
    },
    
    // 同步部门数据到若依系统
    handleSyncDepts() {
      if (!this.deptList || this.deptList.length === 0) {
        this.$message.error('没有可同步的部门数据，请先获取部门列表');
        return;
      }
      
      // 因为部门是树形结构，我们使用整个部门列表而不是选择
      // 但仍然提供更好的界面反馈
      this.$confirm('确认将BladeX的部门数据同步到若依系统吗？此操作可能会覆盖现有数据', '警告', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.deptSyncLoading = true;
        this.responseText = "正在同步部门数据到若依系统...";
        
        // 打印要发送的数据，便于调试
        console.log('发送同步请求，部门数量:', this.deptList.length);
        
        // 直接传递部门数组
        syncBladeDeptToRuoyi(this.deptList).then(response => {
          console.log('同步响应成功:', response);
          this.responseText = this.formatResponse(response);
          
          // 判断响应中是否包含警告信息
          if (response.msg && response.msg.includes("警告信息")) {
            // 有警告信息，使用HTML格式展示
            this.$alert(response.msg, "同步结果", {
              dangerouslyUseHTMLString: true,
              closeOnClickModal: false
            });
          } else {
            // 没有警告，直接显示成功信息
            this.$modal.msgSuccess(response.msg || "同步成功");
          }
        }).catch(error => {
          console.error('同步请求失败:', error);
          
          // 处理错误响应
          let errorMessage = '';
          if (error.response) {
            console.error('错误响应数据:', error.response);
            errorMessage = `状态码: ${error.response.status}, 信息: ${error.response.statusText || '未知'}`;
          } else if (error.request) {
            console.error('无响应:', error.request);
            errorMessage = '服务器未响应请求';
          } else {
            console.error('请求配置错误:', error.message);
            errorMessage = error.message || '未知错误';
          }
          
          this.responseText = `同步失败: ${errorMessage}\n${this.formatResponse(error)}`;
          
          // 使用通知而不是弹窗，避免遮挡界面
          this.$notify.error({
            title: '同步失败',
            message: errorMessage,
            duration: 5000
          });
        }).finally(() => {
          this.deptSyncLoading = false;
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消同步操作'
        });
      });
    },
    
    // 同步用户数据到若依系统
    handleSyncUsers() {
      if (!this.userSelection || this.userSelection.length === 0) {
        this.$message.error('请至少选择一个用户进行同步');
        return;
      }
      
      this.$modal.confirm('确定要同步选中的用户数据到系统中吗？').then(() => {
        this.userSyncLoading = true;
        
        const userList = this.userSelection.map(item => {
          // 转换为若依需要的格式
          return {
            id: item.id,
            account: item.account,
            realName: item.realName,
            email: item.email,
            phone: item.phone,
            avatar: item.avatar,
            sex: item.sex,
            deptId: item.deptId,
            postId: item.postId,
            postCode: item.postCode,
            status: item.status,
            isDeleted: item.isDeleted
          };
        });
        
        syncBladeUserToRuoyi(userList).then(response => {
          this.userSyncLoading = false;
          
          // 判断响应中是否包含警告信息
          if (response.msg && response.msg.includes("警告信息")) {
            // 有警告信息，使用HTML格式展示
            this.$alert(response.msg, "同步结果", {
              dangerouslyUseHTMLString: true,
              closeOnClickModal: false
            });
          } else {
            // 没有警告，直接显示成功信息
            this.$modal.msgSuccess(response.msg || "同步成功");
          }
        }).catch(() => {
          this.userSyncLoading = false;
        });
      });
    },
    
    // 处理表格选择变化
    handleSelectionChange(selection) {
      this.userSelection = selection;
    },
  }
};
</script>

<style scoped>
.mb20 {
  margin-bottom: 20px;
}
.custom-tree-node {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 14px;
  padding-right: 8px;
}
.dept-tree-card {
  height: 600px;
  overflow-y: auto;
}
.dept-detail-card {
  height: 600px;
  overflow-y: auto;
}
</style> 