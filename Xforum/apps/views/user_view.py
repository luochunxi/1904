import os
import re

from flask import Blueprint, render_template, session, Response, request, redirect, url_for

# from VerfiCode import VerfiCode
from sqlalchemy import func
from werkzeug.security import check_password_hash, generate_password_hash

from exts import photos
from settings import UPLOAD_DIR

bbs = Blueprint('bbs', __name__)
from apps.models.model import *


# 首页
@bbs.route('/')
def index():
    # 大板块
    bz = BbsCategory.query.filter(BbsCategory.parentid == 0).all()
    # 小版块
    smallbz = BbsCategory.query.filter(BbsCategory.classpath > 0).all()
    # 得到最新注册用户名
    newuser = User.query.order_by(-User.uid).first()
    # 普通用户个数
    numberuser = User.query.count()
    # 帖子数
    numbertz = BbsDetails.query.filter(BbsDetails.first == 1).count()

    username = session.get('username', None)
    # print('llllllllll')
    # print(username)
    user = User.query.filter(User.username == username).first()
    if user:
        if user.udertype:
            utype = '普通用户'
        else:
            utype = '管理员'
    else:
        utype = ''
    # print(user)
    # print(username)
    # print('xixixiiiiiiiiii')
    return render_template('index.html', **{
        'category': bz,
        'smalls': smallbz,
        'newuser': newuser,
        'user': user,
        'utype': utype,
        'number': numberuser,
        'numbertz': numbertz
    })


# 帖子列表
@bbs.route('/list/<int:id>')
def list(id):
    # 所有大板块
    dbk = BbsCategory.query.filter(BbsCategory.parentid == 0).all()
    # 所有小版块
    xbk = BbsCategory.query.filter(BbsCategory.parentid == 1).all()
    # 取ID的小版块
    idxbk = BbsCategory.query.filter(BbsCategory.cid == id).all()
    # 取ID的小版块的帖子数量
    tzs = BbsDetails.query.filter(BbsDetails.classid == id).count()
    # 帖子
    tz = BbsDetails.query.filter(BbsDetails.classid == id, BbsDetails.first == 1).all()
    # 得到最新注册用户名
    newuser = User.query.order_by(-User.uid).first()
    # 获取session里的username
    username = session.get('username', None)
    # 根据session里的username查用户表
    user = User.query.filter(User.username == username).first()
    if user:
        if user.udertype:
            utype = '普通用户'
        else:
            utype = '管理员'
    else:
        utype = ''
    # print('xixi')
    # print(hu)
    return render_template('list.html', **{
        'category': dbk,
        'id': id,
        'tz': tz,
        'dbk': dbk,
        'xbk': xbk,
        'idxbk': idxbk,
        'tzs': tzs,
        'newuser': newuser,
        'user': user,
        'utype': utype

    })


# 版块分类
@bbs.route('/index_1/<int:id>')
def index_1(id):
    # 得到指定ID大板块
    dd = BbsCategory.query.filter(BbsCategory.cid == id).all()
    # 得到指定ID小版块
    xbk = BbsCategory.query.filter(BbsCategory.classpath == id).all()
    # 所有大板块
    bz = BbsCategory.query.filter(BbsCategory.parentid == 0).all()
    # 得到最新注册用户名
    newuser = User.query.order_by(-User.uid).first()
    # 获取session里的username
    username = session.get('username', None)
    # 根据session里的username查用户表
    user = User.query.filter(User.username == username).first()
    if user:
        if user.udertype:
            utype = '普通用户'
        else:
            utype = '管理员'
    else:
        utype = ''
    return render_template('index_1.html', **{
        'bkk': dd,
        'smalls': xbk,
        'id': id,
        'category': bz,
        'newuser': newuser,
        'user': user,
        'utype': utype

    })


# 搜索
@bbs.route('/search')
def search():
    return render_template('search.html')


# 找回密码
@bbs.route('/getpass')
def getpass():
    return render_template('getpass.html')


# 退出
@bbs.route('/logout')
def logout():
    # session.pop('username')
    session.clear()
    return redirect(url_for('bbs.index'))
    # return render_template('login.html', msg='您已退出站点，现在将以游客身份转入退出前页面', ht='')


# 立即注册
@bbs.route('/reg')
def reg():
    return render_template('reg.html')


# 提交注册
@bbs.route('/zhuce', methods=['GET', 'POST'])
def zhuce():
    if request.method == 'GET':
        return render_template('login.html', msg='走错路了', ht='')
    else:
        username = request.form.get('username', None)
        # print(username)
        password = request.form.get('password', None)
        # print(password)  # ''  None
        repassword = request.form.get('repassword')
        phone = request.form.get('phone')

        if username and password and repassword and phone:
            # a = re.search(r'\d{6,12}[a-z]*',password)
            a = re.search(r'(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$',password)
            b = re.search(r'\d{6,11}',phone)
            print('aaaaaaaaaaaaaaaaaaaaa')
            print(a)
            if b:
                if a:
                    if password == repassword:
                        user = User.query.filter(User.username == username).first()
                        # phone = User.query.filter(User.phone==phone).first()
                        if not user:
                            # 注册
                            user = User()
                            user.username = username
                            hash_password = generate_password_hash(password)
                            user.password = hash_password
                            user.phone = phone

                            flag = user.save()
                            if flag:
                                session['username'] = username

                                return redirect(url_for('bbs.index'))
                        else:
                            # 用户已经注册
                            return render_template('login.html', msg='此用户名或手机号已被占用', ht='reg')
                    else:
                        # 密码不一致
                        return render_template('login.html', msg='密码不一致', ht='reg')
                else:
                    return render_template('login.html', msg='密码为6-12位，不能只为数字，', ht='reg')
            else:
                return render_template('login.html', msg='电话号格式不正确，', ht='reg')
        else:
            return render_template('login.html', msg='必须输入用户名或者密码', ht='reg')


# 登录
@bbs.route('/denglu', methods=['POST', 'GET'])
def denglu():
    if request.method == 'GET':
        return render_template('login.html', msg='走错路了', ht='')
    else:
        username = request.form.get('username', None)
        password = request.form.get('password', None)

        if username and password:
            user = User.query.filter(User.username == username).first()
            # print(user)
            if user:
                result = check_password_hash(user.password, password)
                if result:
                    # 服务器保存 session 当成字典
                    session['username'] = username

                    return redirect(url_for('bbs.index'))

                else:
                    return render_template('login.html', msg='用户名或者密码错误', ht='')
            else:
                return render_template('login.html', msg='没有此用户', ht='')
        else:
            return render_template('login.html', msg='必须输入用户名或者密码', ht='')


# 判断发帖有没有登陆
@bbs.route('/fatie/<int:id>')
def fatie(id):
    username = session.get('username', None)
    if username is None:
        return render_template('register.html', id=id)
    return redirect(url_for('bbs.addc', id=id))


# 发帖登录
@bbs.route('/ftdl/<int:id>', methods=['POST', 'GET'])
def ftdl(id):
    if request.method == 'GET':
        return render_template('login.html', msg='走错路了', ht='')
    else:
        username = request.form.get('username', None)
        password = request.form.get('password', None)
        questionid = request.form.get('questionid')
        answer = request.form.get('answer')

        # 获取session里的username
        username = session.get('username', None)
        # 根据session里的username查用户表
        user = User.query.filter(User.username == username).first()
        if user:
            if user.udertype:
                utype = '普通用户'
            else:
                utype = '管理员'
        else:
            utype = ''
        if username and password:
            user = User.query.filter(User.username == username).first()
            # print(user)
            if user:
                result = check_password_hash(user.password, password)
                if result:
                    user.problem = questionid
                    user.result = answer
                    flag = user.save()
                    if flag:
                        session['username'] = username

                        return redirect(url_for('bbs.addc', id=id))
                    return '错误'
                else:
                    return render_template('login.html', msg='用户名或者密码错误', ht='ftdl/' + 'id', user=user, utype=utype)
            else:
                return render_template('login.html', msg='没有此用户', ht='ftdl/' + 'id', user=user, utype=utype)
        else:
            return render_template('login.html', msg='必须输入用户名,密码或者密保', ht='ftdl/' + 'id', user=user, utype=utype)


# 发帖页面
@bbs.route('/addc/<int:id>')
def addc(id):
    # 大板块
    bz = BbsCategory.query.filter(BbsCategory.parentid == 0).all()
    # 取对应小版块的大版块
    idxbk = BbsCategory.query.filter(BbsCategory.cid == id).all()
    username = session.get('username', None)
    # 根据session里的username查用户表
    user = User.query.filter(User.username == username).first()
    if user:
        if user.udertype:
            utype = '普通用户'
        else:
            utype = '管理员'
    else:
        utype = ''

    return render_template('addc.html', **{
        'category': bz,
        'id': id,
        'idxbk': idxbk,
        'user': user,
        'utype': utype
    })


# 发帖提交
@bbs.route('/posted/<int:id>', methods=['POST', 'GET'])
def posted(id):
    if request.method == 'GET':
        return redirect(url_for('bbs.addc', id=id))
    else:
        # 获取session里的username
        username = session.get('username', None)
        # 根据session里的username查用户表
        user = User.query.filter(User.username == username).first()
        if user:
            if user.udertype:
                utype = '普通用户'
            else:
                utype = '管理员'
        else:
            utype = ''

        title = request.form.get('title', None)
        textbox = request.form.get('textbox', None)
        price = request.form.get('price', None)

        if title and textbox and price:  # and tzb

            username = session.get('username', None)
            authorid = User.query.filter(User.username == username).first()
            tz = BbsDetails()
            tz.title = title  # 标题
            tz.content = textbox  # 内容
            tz.rate = price  # 售价
            tz.first = 1
            tz.hits = 0
            tz.authorid = authorid.uid  # 发布人id
            tz.classid = id  # 版块id
            flag = tz.save()

            newdetail = db.session.query(func.max(BbsDetails.tid)).first()
            dd = str(newdetail[0])
            if flag:
                return render_template('login.html', msg='发表成功', ht='detail/' + dd, user=user, utype=utype)
            return render_template('login.html', msg='发表不成功', ht='addc/' + 'id', user=user, utype=utype)
        return render_template('login.html', msg='不能发空帖', ht='addc/' + 'id', user=user, utype=utype)


# 帖子内容
@bbs.route('/detail/<int:id>')
def detail(id):
    # 得到所有大板块
    souyou = BbsCategory.query.filter(BbsCategory.parentid == 0).all()
    # 帖子
    tz = BbsDetails.query.filter(BbsDetails.tid == id).first()
    # 所有id的帖子
    stz = BbsDetails.query.filter(BbsDetails.classid == tz.classid).all()
    # 上一主题/下一主题
    xb = stz.index(tz)
    le = len(stz)

    # 回复
    hu = BbsDetails.query.filter(BbsDetails.first == 0).all()
    # 回复数量
    hfs = BbsDetails.query.filter(BbsDetails.classid == id).count()
    # 获取当前登录里的username
    username = session.get('username', None)
    # 根据session里的username查用户表
    user = User.query.filter(User.username == username).first()
    # 查看帖子的数
    tznumber = BbsDetails.query.get(id)
    hits = tznumber.hits + 1
    tznumber.hits = hits
    tznumber.save()

    # print('xixixixiixix')
    # print(hits)
    if user:
        if user.udertype:
            utype = '普通用户'
        else:
            utype = '管理员'
    else:
        utype = ''

    return render_template('detail.html', **{
        'len':le,
        'xb':xb,
        'stz': stz,
        'id': id,
        'category': souyou,
        'tz': tz,
        'hu': hu,
        'hfs': hfs,
        'user': user,
        'utype': utype

    })


# 回帖
@bbs.route('/reply<int:id>', methods=['POST', 'GET'])
def reply(id):
    if request.method == 'GET':
        tid = str(id)
        return render_template('login.html', msg='回复不能为空', ht='detail/' + tid)
    else:
        reply = request.form.get('reply', None)
        if reply:
            username = session.get('username', None)
            authorid = User.query.filter(User.username == username).first()
            # replycount = BbsDetails.query.filter(BbsDetails.tid == id).first()
            # print('xiiiiiiiii')
            # print(replycount.replycount)
            # dd = int(replycount.replycount)
            tz = BbsDetails()
            tz.title = ''  # 标题
            tz.content = reply  # 内容
            tz.rate = 0  # 售价
            tz.first = 0
            tz.hits = 0
            # tz.replycount = dd + 1
            tz.authorid = authorid.uid  # 发布人id
            tz.classid = id  # 帖子父id
            flag = tz.save()
            if flag:
                return redirect(url_for('bbs.detail', id=id))

            return render_template('login.html', msg='回复不成功', ht='detail/' + 'id')

        return render_template('login.html', msg='回复不能为空', ht='detail/' + 'id')


# # 中间错误
# @bbs.route('/cuowu')
# def cuowu(msg, ht):
#     # 获取session里的username
#     username = session.get('username', None)
#     # 根据session里的username查用户表
#     user = User.query.filter(User.username == username).first()
#     if user:
#         if user.udertype:
#             utype = '普通用户'
#         else:
#             utype = '管理员'
#     else:
#         utype = ''
#
#     return render_template('login.html', **{
#         'ht': ht,
#         'msg': msg,
#         'user': user,
#         'utype': utype,
#     })


# 回家传参
@bbs.route('/can/<int:homeid>')
def can(homeid):
    # 获取session里的username
    username = session.get('username', None)
    # 根据session里的username查用户表
    user = User.query.filter(User.username == username).first()
    if user:
        if user.udertype:
            utype = '普通用户'
        else:
            utype = '管理员'
    else:
        utype = ''

    return render_template('home.html', **{
        'homeid': homeid,
        'user': user,
        'utype': utype,
    })


# 回家
@bbs.route('/home/<int:homeid>')
def home(homeid):
    if homeid == 1:
        return redirect(url_for('bbs.can', homeid=1))
    elif homeid == 2:
        return redirect(url_for('bbs.can', homeid=2))
    elif homeid == 3:
        return redirect(url_for('bbs.can', homeid=3))
    elif homeid == 4:
        return redirect(url_for('bbs.can', homeid=4))


#  # 头像
# @bbs.route('/pic', methods=['POST', 'GET'])
# def pic():
#     if request.method == 'GET':
#         return render_template('login.html', msg='走错路了', ht='/can/' + '1')
#     else:
#         pic = request.files.get('pic')
#         if pic:
#             username = session.get('username')
#             user = User.query.filter(User.username == username).first()
#             print(pic.filename)
#             # 数据库保存
#             user.picture = 'upload/' + pic.filename
#             user.save()
#             # 本地保存
#             file_path = os.path.join(UPLOAD_DIR,pic.filename)
#             pic.save(file_path)
#
#             return redirect(url_for('bbs.home',homeid=1))
#         return redirect(url_for('bbs.cuowu',msg='不能提交空文件',ht='can/1' ))


# 头像
@bbs.route('/pic', methods=['POST', 'GET'])
def pic():
    if request.method == 'GET':
        return render_template('login.html', msg='走错路了', ht='can/1')
    else:
        pic = request.files.get('pic')
        if pic:
            username = session.get('username')
            user = User.query.filter(User.username == username).first()
            # print(pic.filename)
            # 数据库保存
            user.picture = 'upload/' + pic.filename
            user.save()
            # 保存上传文件，返回文件名
            filename = photos.save(pic)
            # 根据文件名获取上传文件的URL
            img_url = photos.url(filename)
            # print(img_url)
            return redirect(url_for('bbs.home', homeid=1))
        return redirect(url_for('bbs.home', homeid=1))


# 个人资料
@bbs.route('/home', methods=['GET', 'POST'])
def ziliao():
    if request.method == 'GET':
        render_template('login.html', msg='走错路了', ht='can/' + '2')
    else:
        name = session.get('username')
        zname = request.form.get('realname')
        sexx = request.form.get('sex')
        ji = request.form.get('place')
        qh = request.form.get('qq')
        if zname and sexx and ji and qh:
            u = User.query.filter(User.username == name).first()
            print(u, type(u))
            u.username = zname
            u.sex = sexx
            u.place = ji
            u.qq = qh
            session['username'] = zname
            flag = u.save()
            if flag:
                return redirect(url_for('bbs.home', homeid=2))
            return redirect(url_for('bbs.home', homeid=2))
        return redirect(url_for('bbs.home', homeid=2))


# 个性签名
@bbs.route('/sdf', methods=['POST', 'GET'])
def sdf():
    if request.method == 'GET':
        render_template('login.html', msg='走错路了', ht='can/3')
    else:
        ssdf = request.form.get('ssdf', None)
        if ssdf:
            username = session.get('username', None)
            user = User.query.filter(User.username == username).first()
            user.autograph = ssdf  # 个性签名
            flag = user.save()
            if flag:
                return redirect(url_for('bbs.home', homeid=3))
            return redirect(url_for('bbs.home', homeid=3))
        return redirect(url_for('bbs.home', homeid=3))


# 密码安全
@bbs.route('/safety', methods=['GET', 'POST'])
def safety():
    if request.method == 'GET':
        return render_template('login.html', msg='走错路了', ht='')
    else:
        oldpassword = request.form.get('oldpassword', None)
        newpassword = request.form.get('newpassword', None)
        newpassword2 = request.form.get('newpassword2', None)
        phone = request.form.get('phone', None)
        questionidnew = request.form.get('questionidnew', None)
        answernew = request.form.get('answernew', None)
        print('xiiixxxxxxxxxx')
        username = session.get('username')
        user = User.query.filter(User.username == username).first()
        pp = check_password_hash(user.password, oldpassword)

         # 获取session里的username
        username = session.get('username', None)
        # 根据session里的username查用户表
        user = User.query.filter(User.username == username).first()
        if user:
            if user.udertype:
                utype = '普通用户'
            else:
                utype = '管理员'
        else:
            utype = ''

        print(oldpassword)
        print(newpassword2)
        if pp:
            if oldpassword and newpassword:
                if newpassword == newpassword2:

                    hash_password = generate_password_hash(newpassword)
                    user.password = hash_password
                    user.phone = phone
                    user.problem = questionidnew
                    user.result = answernew


                    flag = user.save()
                    if flag:
                        session.clear()
                        return render_template('login.html', msg='修改成功，请重新登录', ht='')
                        # return '修改成功，请重新登录'
                    return '错误'
                else:
                    # 密码不一致
                    return render_template('login.html', msg='密码不一致', ht='can/4',user=user,utype =utype)
                    # return '密码不一致'
            else:
                return render_template('login.html', msg='输入不能为空', ht='can/4',user=user,utype =utype)
                # return '输入不能为空'
        return render_template('login.html', msg='旧密码不正确', ht='can/4',user=user,utype =utype)
        # return '旧密码不正确'


# 搜索
@bbs.route('/sousuo',methods=['POST', 'GET'])
def sousuo():
    if request.method == 'GET':
        return render_template('search.html')
    else:
        keywords = request.form.get('keywords', None)
        tou = BbsDetails.query.filter(BbsDetails.title.like('%' + keywords+ '%')).all()
        print('xiiiiiiiiiiiiii')
        print(tou)
        return render_template('search.html',**{
            'tou':tou,
        })















# 验证码
# @bbs.route('/yzm')
# def yzm():
#     vc = VerfiCode()
#     res = vc.output()
#     # 把验证码字符粗存到session
#     session['yzm'] = vc.code
#     response = Response()
#     response.status_code = 200
#     response.headers['content-type'] = 'image/jpeg'
#     response.data = res
#     return response


# 捕获500的错误
@bbs.app_errorhandler(500)
def file_notfound(error):
    return render_template('500.html')


# 捕获404的错误
@bbs.app_errorhandler(404)
def file_notfound(error):
    return render_template('404.html')
