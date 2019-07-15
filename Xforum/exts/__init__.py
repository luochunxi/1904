from flask_sqlalchemy import SQLAlchemy
from flask_uploads import UploadSet, IMAGES
# 数据库对象
db = SQLAlchemy()
# 图片对象
photos = UploadSet('photos', IMAGES)
