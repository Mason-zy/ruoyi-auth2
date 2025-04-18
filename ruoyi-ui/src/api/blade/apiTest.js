import request from '@/utils/request'

// 检查当前用户的BladeX令牌状态
export function checkToken() {
  return request({
    url: '/blade/api/checkToken',
    method: 'get'
  })
}

// 获取当前用户的BladeX用户信息
export function getUserInfo() {
  return request({
    url: '/blade/api/getUserInfo',
    method: 'get'
  })
}

// 清除当前用户的BladeX令牌
export function clearToken() {
  return request({
    url: '/blade/api/clearToken',
    method: 'get'
  })
}

// 获取BladeX系统用户列表
export function getUserList(params) {
  return request({
    url: '/blade/api/getUserList',
    method: 'get',
    params
  })
}

// 获取岗位列表
export function getPostList(query) {
  return request({
    url: '/blade/api/getPostList',
    method: 'get',
    params: query
  })
}

// 获取部门列表
export function getDeptList() {
  return request({
    url: '/blade/api/getDeptList',
    method: 'get'
  })
}

// 将BladeX部门数据同步到若依系统
export function syncBladeDeptToRuoyi(data) {
  return request({
    url: '/system/dept/syncBladeDept',
    method: 'post',
    headers: {
      'Content-Type': 'application/json;charset=utf-8'
    },
    data: data,
    // 添加额外配置以便更好地处理错误
    validateStatus: function (status) {
      // 接受所有状态码，让响应拦截器处理
      return true;
    },
    timeout: 30000 // 增加超时时间到30秒，处理大量数据同步
  })
}

// 将BladeX岗位数据同步到若依系统
export function syncBladePostToRuoyi(data) {
  return request({
    url: '/system/post/syncBladePost',
    method: 'post',
    headers: {
      'Content-Type': 'application/json;charset=utf-8'
    },
    data: data,
    // 添加额外配置以便更好地处理错误
    validateStatus: function (status) {
      // 接受所有状态码，让响应拦截器处理
      return true;
    },
    timeout: 30000 // 增加超时时间到30秒，处理大量数据同步
  })
}

// 将BladeX用户数据同步到若依系统
export function syncBladeUserToRuoyi(data) {
  return request({
    url: '/system/user/syncBladeUser',
    method: 'post',
    headers: {
      'Content-Type': 'application/json;charset=utf-8'
    },
    data: data,
    // 添加额外配置以便更好地处理错误
    validateStatus: function (status) {
      // 接受所有状态码，让响应拦截器处理
      return true;
    },
    timeout: 30000 // 增加超时时间到30秒，处理大量数据同步
  })
} 