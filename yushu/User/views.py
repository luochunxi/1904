import json
import os
import re
import time
import uuid
from datetime import datetime
from random import randint

from alipay import AliPay
from captcha.helpers import captcha_image_url
from captcha.models import CaptchaStore
from django.core.paginator import Paginator
from django.db.models import Q
from django.http import HttpResponse, JsonResponse, Http404
from django.shortcuts import render, redirect
from django.urls import reverse
from django.views.decorators.csrf import csrf_exempt

from User.send_code import send_email
from User.upload_files import upload_files, route

from yushu import settings

from yushu.settings import MEDIA_URL, NUMOFPAGE, PRIVATE_KEY_PATH, PUBLIC_KEY_PATH
from .models import *
from User.forms import UserForm, RegisterForm
import hashlib


# 首页
def index(request):
    # if request.session['user_id'] :
    user = User.objects.filter(pk=request.session.get('user_id')).first()

    page = request.GET.get('page')
    book = Book.objects.all()
    if page == None:
        page = 1
    else:
        page = int(page)
    # 1 创建分页器对象
    paginator = Paginator(book, NUMOFPAGE)
    # 2 调用分页 方法
    pagination = paginator.page(page)
    # 3 自定义页码范围
    if paginator.num_pages > 10:
        # 如果当前页码-5小于0
        if page - 5 <= 0:
            number = range(1, 11)
        elif page + 4 > paginator.num_pages:
            number = range(paginator.num_pages - 9, paginator.num_pages + 1)
        else:
            number = range(page - 5, page + 5)
    else:  # 页码总数小于10
        number = paginator.page_range
    return render(request, 'index.html',locals() )


# 内容
def detail(request):
    bid = request.GET.get('id')
    content = Book.objects.get(pk=bid)
    uid = request.session.get('user_id')
    user = User.objects.filter(pk=uid).first()
    isgifts = Gifts.objects.filter(bookid_id=bid, uid_id=uid).first()
    idwish = Wish.objects.filter(bookid_id=bid, uid_id=uid).first()
    wuser = Wish.objects.filter(bookid_id=bid)
    guser = Gifts.objects.filter(bookid_id=bid)

    return render(request, 'detail.html', locals())


# 搜索
def search(request):
    # if request.method == 'POST':
    q = request.GET.get('q')
    page = request.GET.get('page')
    print('ssssssssss', q)
    print('ssssssssss', page)


    if q:
        if page == None:
            page = 1
        else:
            page = int(page)
        soushuo = Book.objects.filter(Q(bname__icontains=q) | Q(isbn__icontains=q)).order_by('-date')
        num = Book.objects.filter(Q(bname__icontains=q) | Q(isbn__icontains=q)).order_by('-date').count()

        # 1 创建分页器对象
        paginator = Paginator(soushuo, NUMOFPAGE)
        # 2 调用分页 方法
        pagination = paginator.page(page)
        # 3 自定义页码范围
        if paginator.num_pages > 10:
            # 如果当前页码-5小于0
            if page - 5 <= 0:
                number = range(1, 11)
            elif page + 4 > paginator.num_pages:
                number = range(paginator.num_pages - 9, paginator.num_pages + 1)
            else:
                number = range(page - 5, page + 5)
        else:  # 页码总数小于10
            number = paginator.page_range
        return render(request, 'search.html',locals())
    return render(request,'search.html',locals())


# 资料
def personal(request):
    res = request.session.get('user_name')
    ui = User.objects.filter(name=res).first()
    return render(request, 'personal.html', locals())


# 添加赠送
def add_gifts(request):
    user_id = request.session.get('user_id')
    if not user_id:
        return JsonResponse({'status': 2})
    else:
        bid = request.GET.get('id')
        isgifts = Gifts.objects.filter(bookid=bid, uid=user_id).exists()
        if not isgifts:
            # Gifts.objects.create(bookid=bid, uid=user_id)
            wish = Gifts()
            wish.bookid_id = bid
            wish.uid_id = user_id
            wish.save()
            user = User.objects.get(pk=user_id)
            user.beans += 0.5

            user.save()
            return JsonResponse({'status': 0})
        else:
            return JsonResponse({'status': 1})


# 赠送清单
def gifts_list(request):
    uid = request.session.get('user_id')
    user = User.objects.filter(pk=uid).first()
    lists = Gifts.objects.filter(uid_id=uid)
    book = Wish.objects.all()
    a = []
    for bid in book:
        a.append(bid.bookid.id)

    return render(request, 'gifts.html', locals())


# 添加心愿
def add_wish(request):
    uid = request.session.get('user_id')
    if not uid:
        return JsonResponse({'status': 2})
    else:
        bid = request.GET.get('id')
        b = Book.objects.filter(pk=bid)
        # print('---b', bid)
        # print('---b', b)
        iswish = Wish.objects.filter(bookid=bid, uid=uid).exists()
        # print('-----is', iswish)
        # print('-----is', (not iswish))
        if not iswish:
            # print('sssssssssss')
            wish = Wish()
            wish.bookid_id = bid
            wish.uid_id = uid
            wish.save()
            # print('sssss')
            return JsonResponse({'status': 0})
        return JsonResponse({'status': 1})


# 心愿清单
def wish_list(request):
    uid = request.session.get('user_id')
    user = User.objects.filter(pk=uid).first()
    lists = Wish.objects.filter(uid_id=uid)
    book = Gifts.objects.all()
    a = []
    for bid in book:
        a.append(bid.bookid.id)
    return render(request, 'wish.html', locals())


# 撤销
def repeal(request):
    bid = request.GET.get('id')
    uid = request.session.get('user_id')
    is_wish = Wish.objects.filter(bookid_id=bid, uid_id=uid)
    is_gifts = Gifts.objects.filter(bookid_id=bid, uid_id=uid)
    if is_wish:
        is_wish.delete()
        return redirect('app:wish_list')
    if is_gifts:
        is_gifts.delete()
        user = User.objects.filter(pk=uid).first()
        if user.beans == 0:
            user.beans = 0
            user.save()
        else:
            user.beans -= 0.5
            user.save()
        return redirect('app:gifts_list')


# 订单
def order(request):
    uid = request.session.get('user_id')
    user = User.objects.filter(pk=uid).first()
    id = request.GET.get('id')
    user = User.objects.filter(pk=uid).first()
    gifts = Gifts.objects.filter(pk=id).first()
    if user.beans >= 1:
        if request.method == 'POST':
            recipient_name = request.POST.get('recipient_name')
            mobile = request.POST.get('mobile')
            address = request.POST.get('address')
            message = request.POST.get('message')
            # print(mobile, type(mobile))
            # print(gifts.uid_id)
            # print(gifts.bookid.bname)
            if not recipient_name and not mobile and not address:
                msg = '填写不能有空'
                return render(request, 'dirft.html', locals())
            elif not re.match(r"1[35678]\d{9}$", mobile):
                msg = '手机号格式不正确'
                return render(request, 'dirft.html', locals())
            elif len(address) < 10:
                msg = '地址还不到10个字吗？尽量写详细一些吧'
                return render(request, 'dirft.html', locals())
            else:
                pending = Pending()
                pending.uid_id = uid
                pending.bookid_id = gifts.bookid_id
                pending.tuid = gifts.uid_id
                pending.tname = gifts.uid.name
                pending.recipients = recipient_name
                pending.phone = mobile
                pending.address = address
                pending.message = message
                pending.state = 2  # 状态 提交订单
                pending.save()

                return redirect('app:pending_list')  # redirect('/app/detail/?id=%d'%(wish.bookid_id))
        else:
            return render(request, 'dirft.html', locals())
    else:
        return render(request, 'nodrift.html', locals())


# 鱼漂
def pending_list(request):
    uid = request.session.get('user_id')
    user = User.objects.filter(pk=uid).first()
    pending = Pending.objects.filter(uid=uid).order_by('-times')
    return render(request, 'pending.html', locals())


# 鱼漂撤销
def pending_repeal(request):
    id = request.GET.get('id')
    pending = Pending.objects.filter(pk=id).first()
    pending.state = 0
    pending.save()
    return redirect('app:pending_list')


# 发邮件验证码
def send_emails(request):
    if request.method == 'POST':
        m = randint(100000, 999999)
        email = request.POST.get('email')
        username = request.session['user_name']
        request.session['code'] = str(m)
        subject = '鱼书商城验证码'
        message = '''
                尊敬的%s用户：<br>
                &emsp;&emsp;您的验证码：%s
                &emsp;&emsp;&emsp;&emsp;发件人：嘻嘻
            ''' % (username, m)
        result = send_email(email, subject, message)
        if result:
            return JsonResponse({'code': 1, 'msg': 'ok'})
    return HttpResponse('走错路了')


# 向他赠送此书
def give(request):
    username = request.session['user_name']
    user = User.objects.filter(name=username).first()
    user.send_counter += 1
    user.save()
    id = request.GET.get('id')
    wish = Wish.objects.filter(pk=id).first()
    print(type(wish))
    bname = wish.bookid.bname
    uname = wish.uid.name
    email = wish.uid.email
    wish.launched = 1
    wish.save()

    subject = '[鱼书] 有人赠送你一本书'
    message = '''
            <p><stong>亲爱的 %s,</stong></p>
            <p>%s 有一本《 %s 》可以赠送给你</p>
            <p>点击<a
                    href="http://127.0.0.1:8000/app/dirft?id=%s">这里</a>填写书籍邮寄地址，
                等待 %s 将书籍寄送给你
            </p>
            <p>如果无法点击，你也可以将下面的地址复制到浏览器中打开:</p>
            <p>http://127.0.0.1:8000/app/dirft?id=%s</p>
            <p>你的，</p>
            <p>鱼书</p>
            <p>
                <small>注意，请不要回复此邮件哦</small>
            </p>
            ''' % (uname, username, bname, id, username, id)
    result = send_email(email, subject, message)
    if result:
        print('xxxxxxxxxxxxxxx')
        msg = '已向他/她发送了一封邮件，如果他/她愿意接受你的赠送，你将收到一个鱼漂'
        return redirect('/app/detail/?id=%d' % (wish.bookid_id))

    return redirect('/app/detail/?id=%d' % (wish.bookid_id))


# 头像
def head_photo(request):
    if request.method == 'GET':
        uid = request.session['user_id']
        user = User.objects.get(pk=uid)
        return render(request, 'head_photo.html', locals())
    else:
        pic = request.FILES.get('pic')
        uid = request.session['user_id']
        user = User.objects.get(pk=uid)
        print('ddddddddddddddddddd')
        print('dddddddddddddd', pic)
        if pic:
            path = route(pic)
            if path:
                print('--b--', path)
                res = str(path).partition('static/')
                print('--c--', res[2])
                result = upload_files(pic, path)
                if result:
                    user.head_photo = res[2]
                    user.save()
                    request.session['head_photo'] = res[2]
                    return render(request, 'head_photo.html', locals())
                msg = '上传失败'
                return render(request, 'head_photo.html', locals())
            msg = '文件格式不正确'
            return render(request, 'head_photo.html', locals())
        return render(request, 'head_photo.html', locals())


# 改密码
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
        if not new_password1 == new_password1:
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
            msg = '密码更新成功,请重新登录'
        return redirect('app:login', locals())
    uid = request.session['user_id']
    user = User.objects.filter(pk=uid)
    # print(user[0].email)
    return render(request, 'password.html', locals())


# 登录
def login(request):
    if request.session.get('is_login', None):
        return redirect('app:index')
    if request.method == "POST":
        login_form = UserForm(request.POST)
        message = "验证码错误！"
        if login_form.is_valid():
            username = login_form.cleaned_data['username']
            password = login_form.cleaned_data['password']
            try:
                user = User.objects.get(name=username)
                if user.password == hash_code(password):  # 哈希值和数据库内的值进行比对
                    request.session['is_login'] = True
                    request.session['user_id'] = user.id
                    request.session['user_name'] = user.name
                    request.session['head_photo'] = user.head_photo

                    return redirect('app:index')
                else:
                    message = "密码不正确！"
            except:
                message = "用户不存在！"
        return render(request, 'login.html', locals())

    login_form = UserForm()
    return render(request, 'login.html', locals())


# 注册
def register(request):
    if request.session.get('is_login', None):
        # 登录状态不允许注册。
        return redirect("app:index")
    if request.method == "POST":

        register_form = RegisterForm(request.POST)
        message = "验证码错误！"
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
                request.session['head_photo'] = new_user.head_photo
                return redirect('app:index')  # 自动跳转到首页

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
    m = hashlib.md5()
    strr = str(randint(1, 10))
    m.update(bytes(strr, encoding='utf-8'))
    return m.hexdigest()


# 动态生成验证码
def captcha_refresh(request):
    """  Return json with new captcha for ajax refresh request """
    if not request.is_ajax():
        # 只接受ajax提交
        raise Http404
    new_key = CaptchaStore.generate_key()
    to_json_response = {
        'key': new_key,
        'image_url': captcha_image_url(new_key),
    }
    return HttpResponse(json.dumps(to_json_response), content_type='application/json')


def pay(request):
    order_id = request.GET.get("id")
    # print('oooooooooo', order_id)
    pending = Pending.objects.filter(pk=order_id).first()
    pending.state = 1
    pending.save()
    # 创建用于进行支付宝支付的工具对象
    alipay = AliPay(
        appid=settings.ALIPAY_APPID,
        app_notify_url=None,  # 默认回调url
        app_private_key_path=os.path.join(settings.BASE_DIR, "alipay_key/private_key_2048.txt"),
        alipay_public_key_path=os.path.join(settings.BASE_DIR, "alipay_key/public_key_2048.txt"),
        # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥,
        sign_type="RSA2",  # RSA 或者 RSA2
        debug=True  # 默认False  配合沙箱模式使用
    )

    # 电脑网站支付，需要跳转到https://openapi.alipay.com/gateway.do? + order_string
    order_string = alipay.api_alipay_trade_page_pay(
        out_trade_no=str(int(time.time())) + str(randint(1000, 9999)),  # 商户订单号
        total_amount=str(pending.bookid.id),  # 将Decimal类型转换为字符串交给支付宝
        subject=pending.bookid.bname,
        return_url='http://10.0.113.134:8080/app/pending_list/',
        notify_url=None  # 可选, 不填则使用默认notify url
    )

    # 让用户进行支付的支付宝页面网址
    url = settings.ALIPAY_URL + "?" + order_string

    # return JsonResponse({"code": 0, "message": "请求支付成功", "url": url})
    return redirect(url)

# def check_pay(request):
#     # 创建用于进行支付宝支付的工具对象
#     id = request.GET.get("id")
#     alipay = AliPay(
#         appid=settings.ALIPAY_APPID,
#         app_notify_url=None,  # 默认回调url
#         app_private_key_path=os.path.join(settings.BASE_DIR, "alipay_key/private_key_2048.txt"),
#         alipay_public_key_path=os.path.join(settings.BASE_DIR, "alipay_key/public_key_2048.txt"),
#         # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥,
#         sign_type="RSA2",  # RSA2,官方推荐，配置公钥的时候能看到
#         debug=True  # 默认False  配合沙箱模式使用
#     )
#
#     while True:
#         # 调用alipay工具查询支付结果
#         response = alipay.api_alipay_trade_query(id)  # response是一个字典
#         # 判断支付结果
#         code = response.get("code")  # 支付宝接口调用成功或者错误的标志
#         trade_status = response.get("trade_status")  # 用户支付的情况
#
#         if code == "10000" and trade_status == "TRADE_SUCCESS":
#             # 表示用户支付成功
#             # 返回前端json，通知支付成功
#             return JsonResponse({"code": 0, "message": "支付成功"})
#
#         elif code == "40004" or (code == "10000" and trade_status == "WAIT_BUYER_PAY"):
#             # 表示支付宝接口调用暂时失败，（支付宝的支付订单还未生成） 后者 等待用户支付
#             # 继续查询
#             print(code)
#             print(trade_status)
#             continue
#             # break
#         else:
#             # 支付失败
#             # 返回支付失败的通知
#             return JsonResponse({"code": 1, "message": "支付失败"})
