from datetime import datetime

from exts import db


class User(db.Model):
    uid = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(15), nullable=False, unique=True)
    password = db.Column(db.String(200), nullable=False)
    udertype = db.Column(db.SmallInteger, default=1)  # 账号类型（1=管理员，0=用户）
    sex = db.Column(db.SmallInteger, default=1)  # 性别（1=男，2=女）
    qq = db.Column(db.String(13) )  # QQ号码
    place = db.Column(db.String(50))  # 所在地
    autograph = db.Column(db.String(500))  # 个人签名
    picture = db.Column(db.String(1000), default='index/images/timg.gif')  # 头像
    grade = db.Column(db.Integer, default=0)  # 积分
    regtime = db.Column(db.DateTime, default=datetime.now)  # 注册时间
    phone = db.Column(db.String(11), nullable=False,unique=True)  # 手机号
    problem = db.Column(db.String(200) )  # 找回密码问题
    result = db.Column(db.String(200) )  # 答案
    def save(self):
        try:
            db.session.add(self)
            db.session.commit()
            return True
        except:
            return False



    def __str__(self):
        return self.username

# 用户基本资料表  bbs_user
class BbsUser(db.Model):
    __tablename__ = 'bbs_user'

    uid = db.Column(db.Integer, primary_key=True, nullable=False, autoincrement=True)  # 主键
    username = db.Column(db.String(16), nullable=False)  # 账号
    password = db.Column(db.String(32), nullable=False)  # 密码（md5加密）

    email = db.Column(db.String(30))  # 邮箱
    udertype = db.Column(db.SmallInteger,default=0 )  # 账号类型（1=管理员，0=用户）
    regtime = db.Column(db.DateTime, default=datetime.now)  # 注册时间

    lasttime = db.Column(db.DateTime, default=datetime.now) # 最后登录时间
    regip = db.Column(db.Integer)  # 注册IP
    picture = db.Column(db.String(255), default='../static/index/images/avatar_blank.gif')  # 头像

    grade = db.Column(db.Integer, default=0)  # 积分
    problem = db.Column(db.String(200), default='NULL')  # 找回密码问题
    result = db.Column(db.String(200), default='NULL')  # 答案
    realname = db.Column(db.String(50), default='NULL')  # 真实姓名

    sex = db.Column(db.SmallInteger, default=2)  # 性别（1=男，2=女）
    birthday = db.Column(db.String(20), default='NULL')  # 生日
    place = db.Column(db.String(50), default='NULL')  # 所在地

    qq = db.Column(db.String(13), default='NULL')  # QQ号码
    autograph = db.Column(db.String(500), default='NULL')  # 个人签名
    allowlogin = db.Column(db.SmallInteger, default=0)  # 是否允许登录（0=允许，1=不允许）

    def save(self):
        try:
            db.session.add(self)
            db.session.commit()
            return True
        except:
            return False

    def __str__(self):
        return self.uid


# IP 黑名单表 bbs_closeip
class BbsCloseip(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)  # 主键
    ip = db.Column(db.Integer, nullable=False)  # IP地址
    addtime = db.Column(db.Integer, nullable=False)  # 记录添加时间
    overtime = db.Column(db.Integer, nullable=False, default='NULL')  # IP 限制的结束时间

    def __str__(self):
        return self.id


# 友情链接表 bbs_link
class BbsLink(db.Model):
    __tablename__ = 'bbs_link'
    lid = db.Column(db.SmallInteger, primary_key=True, autoincrement=True, nullable=False)  # 主键
    displayorder = db.Column(db.SmallInteger, nullable=False, default=0)  # 排序（数字大排在前面）
    name = db.Column(db.String(20), nullable=False)  # 名称

    url = db.Column(db.String(255), nullable=False)  # 链接跳转地址
    description = db.Column(db.Text, default='NULL')  # 描述
    logo = db.Column(db.String(255), default='NULL')  # LOGO的URL地址
    addtime = db.Column(db.Integer, nullable=False)  # 添加时间

    def __str__(self):
        return self.lid


# 论坛版块表  bbs_category
class BbsCategory(db.Model):
    __tablename__ = 'bbs_category'

    cid = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)  # 主键
    classname = db.Column(db.String(60), nullable=False)  # 版块名称
    parentid = db.Column(db.Integer, nullable=False,default=1)  # 版块ID 0=大板块   1=小版块

    classpath = db.Column(db.Integer,default=0)  # 父版块CID
    replycount = db.Column(db.Integer, nullable=False, default=0)  # 回贴数量
    motifcount = db.Column(db.Integer, nullable=False, default=0)  # 帖子数量

    compere = db.Column(db.String(10), default='NULL')  # 版主
    classpic = db.Column(db.String(255), nullable=False, default='../static/images/forum.gif')  # 版块ICON
    description = db.Column(db.Text(1000), default='NULL')  # 版块描述

    orderby = db.Column(db.SmallInteger, nullable=False, default=0)  # 排序
    lastpost = db.Column(db.String(255), default='NULL')  # 最后发表
    namestyle = db.Column(db.String(10), default='NULL')

    ispass = db.Column(db.SmallInteger, nullable=False, default=1)  # 审核状态

    def __str__(self):
        return self.cid


# 帖子信息表  bbs_details
class BbsDetails(db.Model):
    __tablename__ = 'bbs_details'
    tid = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)  # 主键
    first = db.Column(db.SmallInteger, nullable=False, default=0)  # 帖子回复（1=帖子，0=回复）
    # id = db.Column(db.Integer, nullable=False)  # 帖子ID

    authorid = db.Column(db.Integer)  # 发布人ID
    title = db.Column(db.String(600), nullable=False)  # 帖子标题
    content = db.Column(db.Text, nullable=False)  # 帖子内容

    addtime = db.Column(db.DateTime, default=datetime.now)  # 发布时间
    # addip = db.Column(db.Integer, nullable=False)  # 发布人IP
    classid = db.Column(db.Integer)  # 版块ID
    #
    replycount = db.Column(db.Integer, default=0)  # 帖子的回复数量
    hits = db.Column(db.Integer, default=0)  # 浏览次数
    # istop = db.Column(db.SmallInteger, nullable=False, default=0)  # 是否置顶帖（1=是，0=否）
    #
    # elite = db.Column(db.SmallInteger, nullable=False, default=0)  # 是否精华帖（1=是，0=否）
    # ishot = db.Column(db.SmallInteger, nullable=False, default=0)  # 是否热门帖（1=是，0=否）
    rate = db.Column(db.SmallInteger, nullable=False, default=0)  # 帖子售价（积分）
    #
    # attachment = db.Column(db.SmallInteger, default='NULL')  # 帖子附件
    # isdel = db.Column(db.Integer, nullable=False, default=0)  # 是否放入回收站
    # style = db.Column(db.String(10), default='NULL')  # 帖子标题颜色（css样式）
    #
    # isdisplay = db.Column(db.Integer, nullable=False, default=0)  # 是否屏蔽回复内容（1=是，0=否）

    def save(self):
        try:
            db.session.add(self)
            db.session.commit()
            return True
        except:
            return False

    # def __str__(self):
    #     return self.tid


# 帖子订单表  bbs_order
class BbsOrder(db.Model):
    __tablename__ = 'bbs_order'
    oid = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)  # 主键
    uid = db.Column(db.Integer, nullable=False)  # 用户ID
    tid = db.Column(db.Integer, nullable=False)  # 帖子ID

    rate = db.Column(db.Integer, nullable=False)  # 价格
    addtime = db.Column(db.Integer, nullable=False)  # 创建时间
    ispay = db.Column(db.SmallInteger, nullable=False, default=0)  # 是否已支付（0=未支付，1=已支付）

    def __str__(self):
        return self.old
