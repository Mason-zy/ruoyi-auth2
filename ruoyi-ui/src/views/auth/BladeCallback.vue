<template>
  <div class="blade-callback-container">
    <div class="callback-card">
      <div v-if="loading">
        <h2>正在处理BladeX授权...</h2>
        <p>授权码: {{ code }}</p>
        <el-progress :percentage="progress"></el-progress>
      </div>
      <div v-else-if="error">
        <h2>授权处理失败</h2>
        <p>{{ errorMessage }}</p>
        <el-button type="primary" @click="returnToLogin">返回登录页</el-button>
      </div>
    </div>
  </div>
</template>

<script>
import { Message } from 'element-ui';
import { setToken } from '@/utils/auth';
import request from '@/utils/request';
import store from '@/store';

export default {
  name: 'BladeCallback',
  data() {
    return {
      loading: true,
      error: false,
      errorMessage: '',
      progress: 0,
      code: '',
      tenantId: '',
      progressTimer: null
    };
  },
  created() {
    // 获取URL参数中的授权码
    this.code = this.$route.query.code;
    this.tenantId = this.$route.query.state || '';
    
    if (!this.code) {
      this.handleError('未接收到有效的授权码，请重试');
      return;
    }
    
    // 设置进度条动画
    this.progressTimer = setInterval(() => {
      if (this.progress < 90) {
        this.progress += 10;
      }
    }, 300);
    
    // 处理授权码
    this.handleAuthorizationCode();
  },
  beforeDestroy() {
    if (this.progressTimer) {
      clearInterval(this.progressTimer);
    }
  },
  methods: {
    // 处理授权码
    handleAuthorizationCode() {
      console.log('开始处理授权码:', this.code, '租户ID:', this.tenantId);
      
      // 调用后端接口处理授权码
      request({
        url: '/blade/auth/getTokenInfo',
        method: 'get',
        params: {
          code: this.code,
          tenant_id: this.tenantId
        }
      }).then(response => {
        console.log('请求成功，响应数据:', response);
        
        // 清除进度条计时器
        if (this.progressTimer) {
          clearInterval(this.progressTimer);
        }
        
        // 设置进度为100%
        this.progress = 100;
        
        if (response.code === 200) {
          // 添加调试语句，查看返回的数据结构
          console.log('响应数据结构检查:', {
            responseData: response.data,
            hasToken: response.data && response.data.token,
            token: response.data ? response.data.token : 'undefined'
          });
          
          // 检查是否包含若依系统token
          if (response.data && response.data.token) {
            // 使用若依token直接登录
            this.handleLoginSuccess(response.data.token);
            return;
          }
          
          // 如果响应中直接包含token（而不是在data.token中）
          if (response.token) {
            this.handleLoginSuccess(response.token);
            return;
          }
          
          // 获取token信息
          const tokenInfo = response.data;
          
          // 显示获取到的信息
          this.showTokenInfo(tokenInfo);
        } else {
          // 处理失败
          this.handleError(response.msg || '获取令牌失败');
        }
      }).catch(error => {
        this.handleError('获取令牌失败: ' + (error.message || '未知错误'));
      });
    },
    
    // 显示令牌信息
    showTokenInfo(tokenInfo) {
      // 构建HTML内容
      let htmlContent = `
        <h3>BladeX认证结果</h3>
      `;
      
      if (tokenInfo.msg) {
        // 显示错误信息
        htmlContent += `<p class="error-msg">${tokenInfo.msg}</p>`;
      } else {
        // 添加令牌信息
        if (tokenInfo.access_token) {
          htmlContent += `<p><strong>访问令牌:</strong> ${tokenInfo.access_token.substring(0, 20)}...</p>`;
        }
        
        // 添加用户信息(如果有)
        if (tokenInfo.user_name) {
          htmlContent += `<p><strong>用户名:</strong> ${tokenInfo.user_name}</p>`;
        }
        
        if (tokenInfo.account) {
          htmlContent += `<p><strong>账号:</strong> ${tokenInfo.account}</p>`;
        }
        
        htmlContent += `
          <h4>说明:</h4>
          <p>BladeX认证成功，但未找到对应的若依系统用户。</p>
          <p>请联系管理员为您创建对应的系统账号。</p>
        `;
      }
      
      // 弹窗显示获取到的信息
      this.$alert(htmlContent, '认证结果', {
        dangerouslyUseHTMLString: true,
        confirmButtonText: '返回登录',
        callback: action => {
          this.$router.push('/login');
        }
      });
    },
    
    // 处理登录成功
    handleLoginSuccess(token) {
      console.log('处理登录成功，token:', token);
      // 保存token
      setToken(token);
      
      // 显示登录成功消息
      Message.success({
        message: '第三方登录成功，即将跳转到首页',
        duration: 1500
      });
      
      // 获取用户信息并生成路由
      this.$store.dispatch('GetInfo').then(() => {
        this.$store.dispatch('GenerateRoutes').then(accessRoutes => {
          // 动态添加可访问路由表
          this.$router.addRoutes(accessRoutes);
          
          // 跳转到首页
          setTimeout(() => {
            this.$router.push({ path: '/' });
          }, 1000);
        });
      }).catch(err => {
        // 若获取信息失败，可能是token格式不正确
        Message.error('获取用户信息失败，请重试');
        this.$router.push('/login');
      });
    },
    
    // 处理错误
    handleError(message) {
      if (this.progressTimer) {
        clearInterval(this.progressTimer);
      }
      this.loading = false;
      this.error = true;
      this.errorMessage = message;
    },
    
    // 返回登录页
    returnToLogin() {
      this.$router.push('/login');
    }
  }
};
</script>

<style scoped>
.blade-callback-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background-color: #f0f2f5;
}

.callback-card {
  background-color: #fff;
  padding: 30px;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  width: 500px;
  text-align: center;
}

h2 {
  margin-bottom: 20px;
  font-weight: 500;
  font-size: 24px;
  color: #303133;
}

p {
  margin-bottom: 20px;
  color: #606266;
}
</style> 