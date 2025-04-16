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
      state: '',
      progressTimer: null
    };
  },
  created() {
    // 获取URL参数中的授权码
    this.code = this.$route.query.code;
    this.state = this.$route.query.state || '';
    
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
    
    // 模拟处理授权码
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
      // 模拟API请求延迟
      setTimeout(() => {
        // 模拟成功获取token
        this.mockExchangeCodeForToken();
      }, 1500);
    },
    
    // 模拟与后端接口交换授权码获取token
    mockExchangeCodeForToken() {
      // 清除进度条计时器
      if (this.progressTimer) {
        clearInterval(this.progressTimer);
      }
      
      // 设置进度为100%
      this.progress = 100;
      
      // 模拟获取到的用户信息和token
      const mockResponse = {
        token: 'mock_token_' + Date.now(),
        userInfo: {
          username: 'blade_user',
          nickname: 'BladeX用户',
          avatar: '',
          roles: ['common'],
          permissions: ['system:user:list']
        }
      };
      
      // 弹窗显示获取到的信息
      this.$alert(`
        <h3>成功获取授权信息</h3>
        <p><strong>授权码:</strong> ${this.code}</p>
        <p><strong>租户ID:</strong> ${this.state}</p>
        <p><strong>模拟Token:</strong> ${mockResponse.token}</p>
        <p><strong>用户名:</strong> ${mockResponse.userInfo.username}</p>
        <p><strong>昵称:</strong> ${mockResponse.userInfo.nickname}</p>
        <p><strong>角色:</strong> ${mockResponse.userInfo.roles.join(', ')}</p>
        <h4>后端实际处理流程:</h4>
        <ol>
          <li>使用授权码从BladeX获取访问令牌</li>
          <li>用访问令牌获取用户信息</li>
          <li>在若依系统中查找/创建用户</li>
          <li>生成若依系统Token并返回</li>
        </ol>
        <h4>后端获取访问令牌的CURL命令示例:</h4>
        <pre style="background:#f5f5f5;padding:8px;overflow:auto;font-size:12px;line-height:1.4;border-radius:4px;text-align:left;">
curl -X POST "${process.env.VUE_APP_BLADE_AUTH_SERVER}/oauth/token" \\
  -H "Tenant-Id: ${this.state}" \\
  -H "Authorization: Basic $(echo -n "${process.env.VUE_APP_BLADE_CLIENT_ID}:客户端密钥" | base64)" \\
  -H "Content-Type: application/x-www-form-urlencoded" \\
  -d "grant_type=authorization_code" \\
  -d "scope=all" \\
  -d "code=${this.code}" \\
  -d "redirect_uri=${process.env.VUE_APP_BLADE_CALLBACK_URL}"
        </pre>
      `, '第三方登录处理结果', {
        dangerouslyUseHTMLString: true,
        confirmButtonText: '确定',
        callback: action => {
          // 保存token并跳转到首页
          this.handleLoginSuccess(mockResponse.token);
        }
      });
    },
    
    // 处理登录成功
    handleLoginSuccess(token) {
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