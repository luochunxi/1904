from flask import Flask

import settings
from apps.views.admin import admin
from apps.views.user_view import bbs
from exts import db

def create_app():
    app = Flask(__name__,template_folder='../templates',static_folder='../static')
    app.config.from_object(settings)

    # 初始化db
    db.init_app(app)
    # 蓝图
    app.register_blueprint(bbs)
    app.register_blueprint(admin)

    return app






