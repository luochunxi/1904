# 发邮件
from random import randint

from django.core.mail import send_mail

from yushu.settings import EMAIL_HOST_USER


def send_email(email, username,m):

    subject = '鱼书商城验证码'
    # message = '''
    #     尊敬的%s用户：<br>
    #     &emsp;&emsp;您的验证码：%s
    #     &emsp;&emsp;&emsp;&emsp;发件人：嘻嘻
    # ''' %(username, m)
    message = '''
           尊敬的%s用户：<br>
           &emsp;&emsp;您的银行卡收入一笔存款共计%s元 <br>
           &emsp;&emsp;请您确认<a href="http://192.168.43.197:8000/aa/">点击这里</a><br>
           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;发件人：中国建设银行
       ''' % (username, m)

    result = send_mail(subject, "", EMAIL_HOST_USER, [email, ],html_message=message)
    return result
