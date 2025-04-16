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
      
      <!-- 用户列表表格 -->
      <el-table
        v-loading="loading"
        :data="userList"
        border
        style="width: 100%">
        <el-table-column prop="id" label="用户ID" width="180" />
        <el-table-column prop="account" label="账号" width="120" />
        <el-table-column prop="realName" label="姓名" width="120" />
        <el-table-column prop="deptName" label="部门" width="150" />
        <el-table-column prop="roleName" label="角色" width="150" />
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
  </div>
</template>

<script>
import { checkToken, getUserInfo, clearToken, getUserList } from "@/api/blade/apiTest";
import Pagination from '@/components/Pagination';

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
      total: 0,
      queryParams: {
        current: 1,
        size: 10,
        account: undefined,
        realName: undefined,
        deptId: undefined
      }
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
        return JSON.stringify(response, null, 2);
      } catch (error) {
        return JSON.stringify(response);
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
    }
  }
};
</script>

<style scoped>
.mb20 {
  margin-bottom: 20px;
}
</style> 