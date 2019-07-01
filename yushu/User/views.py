import time
import uuid
from datetime import datetime
from random import randint

from django.db.models import Q
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect
from django.urls import reverse
from django.views.decorators.csrf import csrf_exempt

from User.send_code import send_email
from yushu.settings import MEDIA_URL
from .models import *
from User.forms import UserForm, RegisterForm
import hashlib


# 首页
def index(request):
    book = Book.objects.all()
    a = MEDIA_URL
    return render(request, 'index.html', locals())


# 内容
def detail(request, id):
    content = Book.objects.get(pk=id)
    a = MEDIA_URL
    return render(request, 'detail.html', locals())


# 搜索
def search(request):
    q = request.GET.get('q')
    a = MEDIA_URL
    if q:
        soushuo = Book.objects.filter(Q(bname__icontains=q) | Q(isbn__icontains=q)).order_by('-date')
        num = Book.objects.filter(Q(bname__icontains=q) | Q(isbn__icontains=q)).order_by('-date').count()

    else:
        soushuo = Book.objects.all().order_by('-date')
        num = Book.objects.all().order_by('-date').count()

    return render(request, 'search.html', locals())


# 资料
def personal(request):
    res = request.session.get('user_name')
    ui = User.objects.filter(name=res).first()
    return render(request, 'personal.html', locals())



# 赠送清单
def my_gifts(request):
    pass



# 心愿清单
def my_wish(reequest):
    pass


# 鱼漂
def pending(request):
    pass



# 发邮件验证码
def send_emails(request):
    if request.method == 'POST':
        m = randint(100000, 999999)
        email = request.POST.get('email')
        username = request.session['user_name']
        request.session['code'] = str(m)
        result = send_email(email, username, m)
        if result:
            msg="ok"
            code=1
            return JsonResponse(locals())
    return HttpResponse('走错路了')

# 发验证码
def send_sms(request):
    redirect('captcha-image-2x')
    msg = "ok"
    code = 1
    return JsonResponse(locals())


def password(request):
    if request.method == 'POST':
        id = request.session['user_id']
        old_password = request.POST.get('old_password')
        new_password1 = request.POST.get('new_password1')
        new_password2 = request.POST.get('new_password2')
        email = request.POST.get('email')
        email_code = request.POST.get('email_code')
        cod = request.session['code']
        # print('xxxxxxxxxxx')
        # print(cod)
        user = User.objects.get(pk=id)
        if not old_password == new_password1:
            msg = '新密码不一致'
            return render(request, 'password.html', locals())
        elif not hash_code(old_password) == user.password:
            msg = '密码不正确'
            return render(request, 'password.html', locals())
        elif not email == user.email:
            msg = '邮箱不正确'
            return render(request, 'password.html', locals())
        elif not email_code == cod:
            msg = '验证码不正确'
            return render(request, 'password.html', locals())
        else:
            user.password = hash_code(new_password1)
            user.save()
            ok = '密码更新成功,请重新登录'
        return render(request, 'login.html', locals())
    return render(request, 'password.html')


# 登录
def login(request):
    if request.session.get('is_login', None):
        return redirect('app:index')
    if request.method == "POST":
        suiji = create()
        login_form = UserForm(request.POST)
        message = "请检查填写的内容！"
        if login_form.is_valid():
            username = login_form.cleaned_data['username']
            password = login_form.cleaned_data['password']
            try:
                user = User.objects.get(name=username)
                if user.password == hash_code(password):  # 哈希值和数据库内的值进行比对
                    request.session['is_login'] = True
                    request.session['user_id'] = user.id
                    request.session['user_name'] = user.name
                    return redirect('app:index')
                else:
                    message = "密码不正确！"
            except:
                message = "用户不存在！"
        return render(request, 'login.html', locals())
    suiji = create()
    login_form = UserForm()
    return render(request, 'login.html', locals())


# 注册
def register(request):
    suiji = create()
    if request.session.get('is_login', None):
        # 登录状态不允许注册。你可以修改这条原则！
        return redirect("app:index")
    if request.method == "POST":
        suiji = create()
        register_form = RegisterForm(request.POST)
        message = "请检查填写的内容！"
        if register_form.is_valid():  # 获取数据
            username = register_form.cleaned_data['username']
            password1 = register_form.cleaned_data['password1']
            password2 = register_form.cleaned_data['password2']
            email = register_form.cleaned_data['email']
            sex = register_form.cleaned_data['sex']
            # print('xxxxxxxxxxxxxxxxaaaaaaaaaaaaaaaaaaxxxxxxxx')
            # print(username)
            if password1 != password2:  # 判断两次密码是否相同
                message = "两次输入的密码不同！"
                return render(request, 'register.html', locals())
            else:
                same_name_user = User.objects.filter(name=username)
                if same_name_user:  # 用户名唯一
                    message = '用户已经存在，请重新选择用户名！'
                    return render(request, 'register.html', locals())
                same_email_user = User.objects.filter(email=email)
                if same_email_user:  # 邮箱地址唯一
                    message = '该邮箱地址已被注册，请使用别的邮箱！'
                    return render(request, 'register.html', locals())

                # 当一切都OK的情况下，创建新用户

                new_user = User()

                new_user.name = username
                new_user.password = hash_code(password1)  # 使用加密密码
                new_user.email = email
                new_user.sex = sex
                new_user.save()
                # print('xiiiiiiiiiiiiiiiiiiiiiii')
                # print(new_user)
                request.session['is_login'] = True
                request.session['user_id'] = new_user.id
                request.session['user_name'] = username
                return redirect('app:index')  # 自动跳转到首页
    suiji = create()
    print(suiji)

    register_form = RegisterForm()
    return render(request, 'register.html', locals())


# 退出
def logout(request):
    if not request.session.get('is_login', None):
        return redirect('app:index')
    request.session.flush()

    return redirect('app:index')


# 加密密码
def hash_code(s, salt='mysite_login'):
    h = hashlib.sha256()
    s += salt
    h.update(s.encode())  # update方法只接收bytes类型
    return h.hexdigest()


# 创建随机数生成验证码
def create():
    m = hashlib.sha256()
    strr = str(randint(1, 10))
    m.update(bytes(strr, encoding='utf-8'))
    return m.hexdigest()




