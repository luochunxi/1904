from django.shortcuts import render

# Create your views here.
import hashlib
from datetime import datetime

import os
from random import randint

from django.core.paginator import Paginator
from django.http import HttpResponse
from django.shortcuts import render, redirect

# Create your views here.
from django.urls import reverse

from User.forms import UserForm
from User.models import *
from User.views import hash_code

from yushu import settings
from yushu.settings import NUMOFPAGE, MEDIA_ROOT


#


# 首页
def index(request):
    import datetime
    cuser = User.objects.count()
    cbook = Book.objects.count()
    today = datetime.date.today()
    book_time = Book.objects.filter(date=today).count()
    print(book_time)
    print('-------------', today)

    return render(request, 'admin/index.html', context={
        'cuser': cuser,
        'cbook': cbook,
        'book_time': book_time
    })


# 书籍管理
def admin_book(request, page=1):
    # 1 创建分页器
    data = Book.objects.filter(isdel=1)
    paginator = Paginator(data, NUMOFPAGE)
    # 2 创建分页对象
    page = int(page)
    pagination = paginator.page(page)

    # 3 自定义页码范围
    if paginator.num_pages > 10:
        # 如果当前页码-5小于0
        if page - 5 <= 0:
            customRange = range(1, 11)
        elif page + 4 > paginator.num_pages:
            customRange = range(paginator.num_pages - 9, paginator.num_pages + 1)
        else:
            customRange = range(page - 5, page + 5)
    else:  # 页码总数小于10
        customRange = paginator.page_range

    return render(request, 'admin/admin_book.html', context={
        'data': pagination.object_list,
        'pagerange': customRange,
        'pagination': pagination
    })


# 用户管理
def admin_user(request, page=1):
    data = User.objects.filter(allowlogin=1)
    paginator = Paginator(data, NUMOFPAGE)
    page = int(page)
    pagination = paginator.page(page)
    if paginator.num_pages > 10:
        if page - 5 <= 0:
            customRange = range(1, 11)
        elif page + 4 > paginator.num_pages:
            customRange = range(paginator.num_pages - 9, paginator.num_pages + 1)
        else:
            customRange = range(page - 5, page + 5)
    else:  # 页码总数小于10
        customRange = paginator.page_range
    return render(request, 'admin/admin_user.html', context={
        'data': pagination.object_list,
        'pagerange': customRange,
        'pagination': pagination
    })


# 上传书籍
def add_book(request):
    if request.method == 'POST':
        # form = BookForm(request.POST)
        bname = request.POST.get('bname')
        author = request.POST.get('author')
        publisher = request.POST.get('publisher')
        jingz = request.POST.get('jingz')
        price = request.POST.get('price')
        pages = request.POST.get('pages')
        isbn = request.POST.get('isbn')
        pubdate = request.POST.get('pubdate')
        intro = request.POST.get('intro')
        image = request.FILES.get('image')
        # photo 是表单中文件上传的name
        file = request.FILES.get('photo')
        print('kkkk', file)
        # 文件路径
        # path = os.path.join(settings.MEDIA_ROOT,file.name)
        local_path = os.path.join(settings.UPLOAD_PATH, file.name)
        path = local_path.replace("\\", '/')
        ext = os.path.splitext(file.name)
        if len(ext) < 1 or not ext[1] in settings.ALLOWED_FILEEXTS:  # ALLOWED_FILEEXTS
            print(settings.ALLOWED_FILEEXTS)
            return HttpResponse('no')
        # 解决文件重名
        if os.path.exists(path):
            dir = datetime.today().strftime("%Y/%m/%d")
            dir = os.path.join(settings.UPLOAD_PATH, dir)  # settings.MEDIA_ROOT
            if not os.path.exists(dir):
                os.makedirs(dir)  # 递归创建目录
            file_name = ext[0] + datetime.today().strftime("%Y%m%d%H%M%S") + str(randint(1, 1000)) + ext[1] if len(
                ext) > 1 else ''
            path = os.path.join(dir, file_name).replace("\\", '/')  #
            print(path, type(path))
        with open(path, 'wb') as fp:
            if file.multiple_chunks():
                for block1 in file.chunks():
                    fp.write(block1)
            else:
                fp.write(file.read())
        path = '/' + path
        book1 = Book(bname=bname, author=author, publisher=publisher, jingz=jingz, price=price, pages=pages, isbn=isbn,
                     pubdate=pubdate,
                     intro=intro, image=path)
        book1.save()
        return render(request, 'admin/admin_book.html')
    return render(request, 'admin/add_book.html')





# 回收站
def book_del(request, page=1):
    data = Book.objects.filter(isdel=0)
    paginator = Paginator(data, NUMOFPAGE)
    page = int(page)
    pagination = paginator.page(page)
    if paginator.num_pages > 10:
        # 如果当前页码-5小于0
        if page - 5 <= 0:
            customRange = range(1, 11)
        elif page + 4 > paginator.num_pages:
            customRange = range(paginator.num_pages - 9, paginator.num_pages + 1)
        else:
            customRange = range(page - 5, page + 5)
    else:  # 页码总数小于10
        customRange = paginator.page_range
    return render(request, 'admin/admin_del.html', context={
        'data': pagination.object_list,
        'pagerange': customRange,
        'pagination': pagination
    })


# 书籍放入回收站
def a_del(request, bid):
    bkid = Book.objects.filter(pk=bid).first()
    if bkid.isdel == 0:
        bkid.isdel = 1
        bkid.save()
        return redirect('/admin/book_del/')
    elif bkid.isdel == 1:
        bkid.isdel = 0
        bkid.save()
        return redirect('/admin/admin_book/')


# 删除书
def book_delete(request):
    bid =request.GET.get('bid')
    bkid = Book.objects.filter(pk=bid).first()
    bkid.delete()

    return redirect('/admin/book_del/')


# 加密密码
def hash_code(s, salt='mysite_login'):
    h = hashlib.sha256()
    s += salt
    h.update(s.encode())  # update方法只接收bytes类型
    return h.hexdigest()

# 登录
def login(request):
    if request.method == 'POST':
        print('jjjjjjjjjjjjjjjjjjjjjjj')
        username = request.POST.get('username')
        password = request.POST.get('password')
        rpassword = hash_code(password)
        print(username, password,rpassword)
        res = User.objects.filter(name=username, password=rpassword,usertype=0).first()
        print('jjjjjjj', res)
        if res:
            # 将用户名存入session
            request.session['username'] = username
            request.session['uid'] = res.id
            return redirect('admin:index')
        return redirect('admin:login')

    else:
        return render(request, 'admin/login.html')


# 用户黑名单
def hmd(request, page=1):
    data = User.objects.filter(allowlogin=0)
    paginator = Paginator(data, NUMOFPAGE)
    page = int(page)
    pagination = paginator.page(page)
    if paginator.num_pages > 10:
        if page - 5 <= 0:
            customRange = range(1, 11)
        elif page + 4 > paginator.num_pages:
            customRange = range(paginator.num_pages - 9, paginator.num_pages + 1)
        else:
            customRange = range(page - 5, page + 5)
    else:  # 页码总数小于10
        customRange = paginator.page_range
    return render(request, 'admin/hmd.html', context={
        'data': pagination.object_list,
        'pagerange': customRange,
        'pagination': pagination
    })


# 加入黑名单
def u_del(request):
    uid = request.GET.get('id')
    bkid = User.objects.filter(pk=uid).first()
    bkid.allowlogin = 0
    bkid.save()
    return redirect('/admin/admin_user/')


# 退出
def logout(request):
    request.session.flush()
    return redirect('admin:login')


# 撤销黑名单
def c_del(request):
    uid = request.GET.get('id')
    print(uid,'aaaaaaaaaaaaaaaaaaaaa')
    user = User.objects.filter(pk=uid).first()
    user.allowlogin = 1
    user.save()
    return redirect('admin:hmd')

#删除书籍
def delete(request,bid):
    res = Book.objects.get(pk=bid)
    res.delete()
    return redirect('admin:admin_del')


def s_admin(request):
    uid = request.GET.get('id')
    user = User.objects.filter(pk=uid).first()
    if user.usertype == 0:
        user.usertype = 1
        user.save()
    elif user.usertype == 1:
        user.usertype = 0
        user.save()
    return redirect('admin:admin_user')