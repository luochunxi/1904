from django.urls import path, include
from .views import *

app_name = 'User'

urlpatterns = [
    path('', index, name='index'),  # 首页
    # path('/<int:page>', index, name='index'),  # 首页分页
    path('head_photo/', head_photo, name='head_photo'),
    path('search/', search, name='search'),  # 搜索
    # path('search/<int:page>/', search, name='search'),  # 搜索分页

    path('refresh/', captcha_refresh, name='captcha-refresh'),  # 动态生成验证码
    path('login/', login, name='login'),  # 登录
    path('register/', register, name='register'),  # 注册
    path('logout/', logout, name='logout'),  # 退出
    path('detail/', detail, name='detail'),  # 书内容
    path('detail/', detail, name='detail'),  # 书内容
    path('personal/', personal, name='personal'),  # 个人资料
    path('password/', password, name='password'),  # 改密
    path('send_emails/', send_emails, name='send_emails'),  # 发邮件

    path('add_gifts/', add_gifts, name='add_gifts'),  # 添加赠送
    path('add_wish/', add_wish, name='add_wish'),  # 添加心愿
    path('gifts_list/', gifts_list, name='gifts_list'),  # 赠送清单
    path('wish_list/', wish_list, name='wish_list'),  # 心愿清单
    path('pending_list/', pending_list, name='pending_list'),  # 鱼漂清单
    path('pending_repeal/', pending_repeal, name='pending_repeal'),  # 鱼漂清单撤销
    path('repeal/', repeal, name='repeal'),  # 撤销
    path('order/', order, name='order'),  # 订单
    path('give/', give, name='give'),  # 向他赠送此书
    path("pay/", pay, name='pay'),
    # path("check_pay/", check_pay, name='check_pay'),

]
