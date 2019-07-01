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
    # 一对多关系
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='Book', db_column='uid', default=1)

    def __str__(self):
        return self.bname

    class Meta:
        db_table = 'book'


# 赠送表
class Presented(models.Model):
    gifts = models.IntegerField(null=True, blank=True)  # 赠送
    wish = models.IntegerField(null=True, blank=True)  # 心愿
    # 一对多关系
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='Presented', db_column='uid', default=1)

    def __str__(self):
        return self.user

    class Meta:
        db_table = 'presented'


# 交易表
class Pending(models.Model):
    dou = models.IntegerField(default=0)
    # 一对多关系
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='Pending', db_column='uid', default=1)

    def __str__(self):
        return self.user

    class Meta:
        db_table = 'pending'






