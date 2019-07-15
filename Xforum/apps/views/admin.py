import os

from flask import Blueprint, render_template, session, Response, request, redirect, url_for

# from VerfiCode import VerfiCode
from sqlalchemy import func
from werkzeug.security import check_password_hash, generate_password_hash

from exts import photos
from settings import UPLOAD_DIR

admin = Blueprint('admin', __name__)
from apps.models.model import *


# 登录
@admin.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == 'GET':
        return render_template('admin.html')
    else:
        print('11111111111111111111111111')
        username = request.form.get('username', None)
        password = request.form.get('password', None)

        # if username and password:
        #     user = User.query.filter(User.username == username).first()
        #     print('22222222222222222222')
        #     if user:
        #         result = check_password_hash(user.password, password)
        #         if result:
        #             # 服务器保存 session 当成字典
        #             session['adminname'] = username
        #             print('33333333333333333333')
        #             return redirect(url_for('admin.index'))
        #
        #         else:
        #             return render_template('admin.html')
        #     else:
        #         return render_template('admin.html')
        #
        # else:
        #     return render_template('admin.html')

        return redirect(url_for('admin.inde'))
# 首页
@admin.route('/inde')
def inde():
    return render_template('admin_index.html')
