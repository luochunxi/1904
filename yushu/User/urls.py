from django.urls import path, include
from .views import *

app_name = 'User'

urlpatterns = [
    path('', index, name='index'),  # 首页
    path('search/', search, name='search'),
    # path('captcha', include('captcha.urls')),  # 验证码
    path('login/', login, name='login'),  # 登录
    path('register/', register, name='register'),  # 注册
    path('logout/', logout, name='logout'),  # 退出
    path('detail/<int:id>/', detail, name='detail'),  # 书内容
    path('personal/', personal, name='personal'),  # 个人资料
    path('password/', password, name='password'),  # 改密
    path('send_emails/', send_emails, name='send_emails'),  # 发邮件
    path('send_sms/', send_sms, name='send_sms'),  # 发验证码
    path('my_gifts/', my_gifts, name='my_gifts'),  # 赠送清单
    path('my_wish/', my_wish, name='my_wish'),  # 心愿清单
    path('pending/', pending, name='pending'),  # 鱼漂

]



