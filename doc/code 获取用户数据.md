 
balde授权码登录后   返回地址：http://192.168.100.106/auth/callback/blade?code=RE7TZN&state=000000 
之后，调用 https://we-safer.net/api/blade-auth/oauth/token 传入对应的参数
请求头： Tenant-Id: 000000(替换为对应的租户id)
Authorization ： Basic Y2hlbV9ydW95aTpjaGVtX3J1b3lpX3NlY3JldA== （"Y2hlbV9ydW95aTpjaGVtX3J1b3lpX3NlY3JldA=="chem_ruoyi:chem_ruoyi_secret串转换为的base64编码,需要和blade_client表的对应字段相匹配）
表单： grant_type：authorization_code  scope：all  code：C5H0Cz  redirect_uri： http://192.168.100.106:81/auth/blade-callback
返回：
{
    "tenant_id": "000000",
    "user_id": "1123598821738675201",
    "dept_id": "1123598813738675201",
    "post_id": "1123598817738675201",
    "role_id": "1123598816738675201",
    "oauth_id": "",
    "account": "admin",
    "user_name": "admin",
    "nick_name": "管理员",
    "real_name": "管理员",
    "role_name": "administrator",
    "avatar": "https://bladex.cn/images/logo-small.png",
    "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJibGFkZXguY24iLCJhdWQiOlsiYmxhZGV4Il0sInRva2VuX3R5cGUiOiJhY2Nlc3NfdG9rZW4iLCJjbGllbnRfaWQiOiJjaGVtX3J1b3lpIiwidGVuYW50X2lkIjoiMDAwMDAwIiwidXNlcl9pZCI6IjExMjM1OTg4MjE3Mzg2NzUyMDEiLCJkZXB0X2lkIjoiMTEyMzU5ODgxMzczODY3NTIwMSIsInBvc3RfaWQiOiIxMTIzNTk4ODE3NzM4Njc1MjAxIiwicm9sZV9pZCI6IjExMjM1OTg4MTY3Mzg2NzUyMDEiLCJvYXV0aF9pZCI6IiIsImFjY291bnQiOiJhZG1pbiIsInVzZXJfbmFtZSI6ImFkbWluIiwibmlja19uYW1lIjoi566h55CG5ZGYIiwicmVhbF9uYW1lIjoi566h55CG5ZGYIiwicm9sZV9uYW1lIjoiYWRtaW5pc3RyYXRvciIsImRldGFpbCI6eyJ0eXBlIjoid2ViIn0sImV4cCI6MTc0NDc3MDI2OCwibmJmIjoxNzQ0NzY2NjY4fQ.yJGm2E8VMaS2TAHuG-MXC85_6Rkhmhem7eN4z-cSUMA",
    "refresh_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJibGFkZXguY24iLCJhdWQiOlsiYmxhZGV4Il0sInRva2VuX3R5cGUiOiJyZWZyZXNoX3Rva2VuIiwidXNlcl9pZCI6IjExMjM1OTg4MjE3Mzg2NzUyMDEiLCJkZXB0X2lkIjoiMTEyMzU5ODgxMzczODY3NTIwMSIsInJvbGVfaWQiOiIxMTIzNTk4ODE2NzM4Njc1MjAxIiwiZXhwIjoxNzQ1MzcxNDY4LCJuYmYiOjE3NDQ3NjY2Njh9.vg7xbGu-ccH0M4af37WkQ3HH8txMMr5wlQcv26cF9Vg",
    "token_type": "bearer",
    "expires_in": 3600,
    "detail": {
        "type": "web"
    },
    "license": "powered by bladex"
}