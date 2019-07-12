from datetime import datetime
from django.db import models


class User(models.Model):
    '''用户表'''

    gender = (
        ('male', '男'),
        ('female', '女'),
    )

    name = models.CharField(max_length=128, unique=True)
    password = models.CharField(max_length=256)
    email = models.EmailField(unique=True)
    sex = models.CharField(max_length=32, choices=gender, default='男')
    c_time = models.DateTimeField(auto_now_add=True)
    beans = models.FloatField(default=0, verbose_name='鱼豆')
    send_counter = models.IntegerField(default=0, verbose_name='送出')
    receive_counter = models.IntegerField(default=0, verbose_name='收到')
    head_photo = models.CharField(max_length=5000,default='upload/head_photo/timg.gif', verbose_name='头像')
    usertype = models.IntegerField(default=1)  # 类型
    allowlogin = models.IntegerField(default=1) # 是否允许登录
    def __str__(self):
        return self.name

    class Meta:
        db_table = 'User'
        ordering = ['c_time']
        verbose_name = '用户'
        verbose_name_plural = '用户'


# 书籍表
class Book(models.Model):
    bname = models.CharField(max_length=50, verbose_name='书名')
    author = models.CharField(max_length=300, default="未名", verbose_name='作者')
    publisher = models.CharField(max_length=50, verbose_name='出版社')
    pubdate = models.CharField(max_length=50, default='1900-01', verbose_name='出版年')
    jingz = models.CharField(max_length=20, null=True, blank=True, verbose_name='精装')
    price = models.FloatField(verbose_name='定价')
    pages = models.IntegerField(verbose_name='页数')
    isbn = models.CharField(max_length=15, null=True, blank=True, unique=True, verbose_name='ISBN')
    intro = models.CharField(max_length=1000, verbose_name='内容简介')
    image = models.ImageField(upload_to='upload/%Y/%m', verbose_name='书籍图片')
    date = models.DateTimeField(auto_now=True, verbose_name='添加日期')

    isdel = models.IntegerField() # 回收
    # 一对多关系
    uid = models.ForeignKey(User, on_delete=models.CASCADE, related_name='book_user', db_column='uid', default=8)

    def __str__(self):
        return self.bname

    class Meta:
        db_table = 'book'


# 赠送表
class Gifts(models.Model):
    # 一对多关系
    uid = models.ForeignKey(User, on_delete=models.CASCADE, related_name='gifts_user', db_column='uid')
    bookid = models.ForeignKey(Book, on_delete=models.CASCADE, related_name='gifts_book', db_column='bookid')
    launched = models.IntegerField(default=0)
    date = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.uid

    class Meta:
        db_table = 'gifts'


# 心愿表
class Wish(models.Model):
    uid = models.ForeignKey(to=User, on_delete=models.CASCADE, related_name='wish_user', db_column='uid')
    bookid = models.ForeignKey(to=Book, on_delete=models.CASCADE, related_name='wish_book', db_column='bookid')
    # 是否已经赠送出去
    launched = models.IntegerField(default=0, )
    date = models.DateTimeField(auto_now=True, )

    def __str__(self):
        return self.uid

    class Meta:
        db_table = 'wish'


# 交易表
class Pending(models.Model):
    # 请求者信息
    uid = models.ForeignKey(User, on_delete=models.CASCADE, related_name='pending_user', db_column='uid',)
    bookid = models.ForeignKey(Book, on_delete=models.CASCADE, related_name='pending_book', db_column='bookid')
    tuid = models.CharField(max_length=20)        # 发送者id
    tname = models.CharField(max_length=20)        # 发送者姓名
    recipients = models.CharField(max_length=128)  # 收件名
    phone = models.CharField(max_length=19) #电话
    address = models.CharField(max_length=2000)   # 地址
    message = models.CharField(max_length=2000,null=True,blank=True)   # 留言
    times = models.DateTimeField(auto_now_add=True) # 时间
    state = models.IntegerField(default=0)  # 状态

    def __str__(self):
        return self.recipients

    class Meta:
        db_table = 'pending'
