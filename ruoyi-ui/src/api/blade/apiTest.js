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