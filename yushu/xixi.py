import hashlib
import time
import uuid

print(uuid.uuid4())
print(uuid.uuid1())


def create_md5():  # 通过MD5的方式创建
    m = hashlib.md5()
    m.update(bytes(str(time.time()), encoding='utf-8'))
    return m.hexdigest()
suiji = create_md5()
