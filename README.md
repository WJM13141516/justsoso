# 2022.4.18更新
已恢复使用,同时增加了pushplus亦或sever酱的微信推送功能，代码放在autopush内
# 2022.4.14更新
道高一尺，魔高一丈，最近先停用了
![image](images/D7AA6845-E153-44F1-A8E2-2C60B1F6AB22.png)
# 2022.4.9更新
已更新进入上报界面所需的hidden项input，fun18，至于value应该没有固定值要求，在我的浏览器为819
# 2022.4.6更新
删除健康🐴颜色，该项已不需要填报
# 2022.3.5更新
针对打卡时候存在的空白姓名没打卡成功问题。原因是密码是纯数字，可以考虑更改密码或者将密码用双引号引起来
# 2022.1.5更新
对于假期的多人模式更新，解决在校期间多人模式共用一套地理位置坐标的问题,利用case区分
创建多个人的myvs.txt文件,如下图所示，并且将学号密码的顺序对应起来，代码参考mode2script.sh去修改原本的script.sh文件
 ![image](https://github.com/mauhin/justsoso/raw/main/images/微信图片_20220105203102.png)

# justsoso
# 郑大健康状况上报平台脚本
# 用机器解放双手

## ❗功能
使用Actions执行脚本，每天4点定时签到，无需手动运行，签到成功后会发送邮件到你的私人邮箱。模拟手动操作，防止登录失效。
建议在手机上打开邮箱的推送服务，每天早上看到邮件推送即安心。
关于安全性：学号和密码和邮箱用Secrect进行保存，复制项目到自己到账号下不会导致任何人的密码泄露。
**注意：项目启用后60天无更新时，Actions功能会自动关闭，届时需要再次手动开启。**

---
## ❓部署
### 1. Fork 仓库
   * 首先要自己注册一个github账号，然后将此项目fork的自己的仓库
   * 点击页面右上角的`Fork`按钮，将本项目保存到自己的仓库。点击`Fork`左侧的`Star`键可以表示您对本项目和作者的认同。🤩
      ![fork.PNG](https://i.loli.net/2020/11/24/2hTtGldiZF9B7DX.png)
### 2. 添加 secrets（此处字数过多，请认真阅读）
   * 点击`Settings`-->`Secrets`-->`New repository secret`，进入新建页面。
      ![secrets.PNG](https://i.loli.net/2020/11/24/mIWLRTzUJxuiMHa.png)
   * 在`Name`栏输入`UID`，`Value`栏输入自己的学号，然后点击`Add secret`。
   * 再次点击`Settings`-->`Secrets`-->`New repository secret`，进入新建页面。
   * 在`Name`栏输入`UPW`，`Value`栏输入自己的登录密码，然后点击`Add secret`。
   * 第三次点击`Settings`-->`Secrets`-->`New repository secret`，进入新建页面。
   * 在`Name`栏输入`MAIL_USERNAME`，`Value`栏输入自己发送邮件的邮箱，然后点击`Add secret`。(**注意：此处默认使用QQ邮箱发送邮件，如果想使用其他邮箱，请自行在main.yml文件中修改服务器参数。` server_address: smtp.qq.com`**)
   * 第四次点击`Settings`-->`Secrets`-->`New repository secret`，进入新建页面。
   * 在`Name`栏输入`MAIL_PASSWORD`，`Value`栏输入自己发送邮件的邮箱的密码，然后点击`Add secret`。(**注意：默认设置的为QQ邮箱服务器， QQ邮箱的密码并非登录密码，而是QQ邮箱授权码，MAIL_PASSWORD不是发送邮箱账号的密码，！！！，是授权码，登录QQ邮箱，登录后点击`设置`然后进入`账户`将找到`POP3/IMAP/SMTP/Exchange/CardDAV/CalDAV服务`,点击开启，获取第三方邮箱登录授权码，将授权码填入即可。**)
      ![image](https://github.com/mauhin/justsoso/raw/main/images/QQMail2.png)
      ![image](https://github.com/mauhin/justsoso/raw/main/images/QQMail3.png)
   * 第五次点击`Settings`-->`Secrets`-->`New repository secret`，进入新建页面。
   * 在`Name`栏输入`RECEIVE_MAIL`，`Value`栏输入自己接收填报成功邮件推送的邮箱，然后点击`Add secret`。（**注意：此处不限制邮箱类型，均可，开启多人模式时若要添加多个邮箱，直接将多个邮箱填入，用英文逗号间隔即可。例如`1233465789@qq.com,jdiaojap@163.com`**）
   * 多人模式与单人模式的添加方法相同，具体格式为`学号,学号,学号`和`密码,密码,密码`，例如：`201884160000,201884160001`和`12345678,12345678`(**注意：逗号为英文标点，使用中文标点会导致脚本运行失败**)（**若开启多人模式，请将script.sh文件中的第21行代码由`echo "$udata" > result.html`修改为`echo "$udata" >> result.html`**）
### 3. 修改个人信息
   * 其中scrip.sh文件中**第19行经纬度**请根据位置进行填写变更，或者将**myvs.txt**文件中的**成功获取**修改为**请求超时**，即系统无法你的具体位置（**例如郑州大学主校区荷园为jingdu=113.538244，weidu=34.821784，目前系统默认设置为郑州大学北校区，如若在北区无需修改**）手机地图即可查询
   * 地址：郑州市中原区郑州大学荷园13幢  坐标：113.538244,34.821784   
   * 查询地址：https://api.map.baidu.com/lbsapi/getpoint/index.html
   * myvs.txt文件中myvs_13a为省级代码编号（例如河南为41），myvs_13b为市级代码编号（例如郑州为4101，代码默认**4153郑州大学北校区**，其他校区或者位置请自行更改），myvs_13c为具体位置，如有位置变动请自行修改，修改时切记同时修改sheng6的值（同样为省级代码编号，已默认为41），省市级代码编号可自行百度查询，根据自身情况修改其等号后的值即可,my_13b的城市对应代码如下图所示，注意**最后三个**为郑州大学三个校区

![image](https://github.com/mauhin/justsoso/raw/main/images/myvs_13.png)


### 4.启用 Actions
   * 点击上方的`Actions`，点击绿色按钮确认启用`Actions`功能。
   * 点击左侧`justsoso`，点击`Run workflow`，运行一次项目。
      ![actions.PNG](https://i.loli.net/2020/11/24/HrQoCwFkgcAYjps.png)

项目部署完毕后，可以在自己填写的邮箱中查看打卡成功的邮件推送，打卡成功截面如下图所示。
请注意每天查看邮件，有异常请及时手动补卡。项目会持续更新。
![image](https://github.com/mauhin/justsoso/raw/main/images/successpage.jpg)
如有疑问可通过`Issues`功能提交问题，如出现签到失败的问题请耐心等待更新，会及时回复。


---
## 📢更新方法
   * 点击`Settings`-->`Options`-->`Dangerous Zone`-->`delete this reposity`，按照提示删除本项目，然后重新部署
   * 使用git，相关命令请自行搜索。
   * 在action里重新开启，选择enable即可
# 在大佬的基础上增加了邮件提醒功能
   * 在[@d6imde9](https://github.com/d6imde9)书写的源代码基础上添加了邮件推送的功能，将打卡成功的界面利用邮件推送，配置方法已经在上方作了说明
   * 在secrets中增加邮箱账号和密码MAIL_USERNAME和MAIL_PASSWORD，RECEIVE_MAIL
   * RECEIVE_MAIL为接收邮件的邮箱，EMAIL_PASSWORD不是发送邮箱账号的密码，！！！，是授权码，以QQ邮箱为例，登录后点击`设置`然后进入`账户`将`POP3/IMAP/SMTP/Exchange/CardDAV/CalDAV服务`中的服务开启，获取授权码，将授权码填入即可
# 特别感谢

 * [@d6imde9](https://github.com/d6imde9)
