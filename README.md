# OpenWRT和 IEDE
云编译OpenWRT固件

OpenWRT-24.10源码：
https://github.com/openwrt/openwrt

LEDE-24.10源码：
https://github.com/coolsnowwolf/lede


# 固件简要说明：
后台IP:192.168.1.1
官方OPENWET刷入后无线是关闭的，要自己手动开下，国家代码	也要选择下5G才正常。

固件每天2点自动编译。

固件信息里的时间为编译开始的时间，方便核对上游源码提交时间。

TP-XDR608X，配套的UBOOT：支持最新官方OPENWRT itb和BIN文件刷入

https://github.com/sos801107/TL-XDR608X/tree/main/UBOOT

用这个UBOOT直接入官方和LEDE这间转换，可能会出现两个ROM都在里面，引导可能只能进入官方的，这时可以刷下这个过度ROM，再通过WEB升级 

https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/UBOOT/immortalwrt-24.10-snapshot-r32679-687c2906ac-mediatek-filogic-tplink_tl-xdr6086-initramfs-recovery.itb

如果还不行，就换下三合一的UBOOT的，刷入后再换回来就可以。

进入UBOOT 后打开http://192.168.1.1/uboot.html 上传新的UBOOT就可以更换

（这个不支持官方ITB刷入）
https://raw.githubusercontent.com/sos801107/TL-XDR608X/refs/heads/main/UBOOT/Uboot-3ro1.7z


以下为官方OPENWRT截图：

![image](https://github.com/user-attachments/assets/52995d5f-68d0-46e6-be6e-14b3a17b8361)

![image](https://github.com/user-attachments/assets/4fff19fd-cfb0-4888-9d19-5f148605301a)

![image](https://github.com/user-attachments/assets/40c55ad8-7353-45e9-8781-d5dd19732ce5)

![image](https://github.com/user-attachments/assets/6877d258-5579-45d4-8830-194ef9a5ef14)


以下为官方LEDE截图：

![image](https://github.com/user-attachments/assets/0619f0e0-e3e5-494b-b079-8b1a5762ae2c)

![image](https://github.com/user-attachments/assets/c79bc135-f90d-429d-b36e-17f5c4d3d31d)

![image](https://github.com/user-attachments/assets/efe79a70-ec2f-4ff6-9ae7-0a32971e82c3)

![image](https://github.com/user-attachments/assets/57d9f759-d78e-4a24-a489-321894206feb)
