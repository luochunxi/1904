from django.urls import path, include, re_path

from Admin import views

app_name = 'admin'

urlpatterns = [
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
    path('index/', views.index, name='index'),
    path('admin_hmd/', views.hmd, name='hmd'),
    path('admin_hmd/<int:page>/', views.hmd, name='hmd'),
    path('admin_user/', views.admin_user, name='admin_user'),
    path('admin_user/<int:page>/', views.admin_user, name='admin_user'),
    path('admin_book/', views.admin_book, name='admin_book'),
    path('admin_book/<int:page>/', views.admin_book, name='admin_book'),
    path('add_book/', views.add_book, name='add_book'),

    path('book_del/<int:page>/ ', views.book_del, name='admin_del'),
    path('book_del/', views.book_del, name='admin_del'),

    path('a_del/',views.a_del,name='a_del'),
    re_path('a_del/(?P<bid>\d+)/',views.a_del,name='a_del'),

    path('book_delete/',views.book_delete,name='book_delete'),
    # path('repeal/<bid>/',views.rep,name='rep'),

    path('u_del/',views.u_del,name='u_del'),

    path('c_del/',views.c_del,name='c_del'),

    path('delete/',views.delete,name='delete'),  #删除书籍

    path('s_admin/',views.s_admin,name='s_admin'),  #设为管理员

]
