import os

ENV = 'development'
DEBUG = True
host='0.0.0.0'
port=8001

#  mysql+驱动://用户名:密码@主机:3306/数据库名
SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://root:123123@localhost:3306/xforum'
SQLALCHEMY_TRACK_MODIFICATIONS = False

SECRET_KEY = 'jkdfkldsj7345374^&5'
# 获取当前文件路径
BASE_DIR = os.path.dirname(__file__)
UPLOAD_DIR = os.path.join(BASE_DIR, 'static/upload')
# 插件上传
UPLOADED_PHOTOS_DEST = os.path.join(BASE_DIR, 'static/upload')
MAX_CONTENT_LENGTH = 8 * 1024 * 1024
