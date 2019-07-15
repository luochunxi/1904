from flask_migrate import Migrate, MigrateCommand
from flask_script import Manager
from flask_uploads import configure_uploads, patch_request_class

from apps.models.model import BbsUser,BbsLink,BbsCategory,BbsDetails,BbsOrder,User
from apps import create_app
from exts import db, photos

app = create_app()

manager = Manager(app=app)
# 上传图片，整合命令
configure_uploads(app, photos)
patch_request_class(app, size=8 * 1024 * 1024)
# 添加上传数据库三条命令
migrate = Migrate(app=app, db=db)  # 整合app和db对象
manager.add_command('db', MigrateCommand)

if __name__ == '__main__':
    manager.run()
