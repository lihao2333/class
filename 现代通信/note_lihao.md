## 随记
* 电路交换,分组交换,光交换
	* ATM 融合电路交换和分组交换
	* 现在的网络并不是全光网络，只有接入测和传入侧是光传输
* 交换系统的基本结构噩耗功能描述
	* 标准化组织
		* ITU, 指定全球电信标准
		* CCITT,ITU的前身
		* 3GPP, 2G到3G平滑过度

|Name| Tech | Bandwidth  |
| ------------- |:-------------:| -----:|
|1G|FDMA|64k,模拟|
|2G|CDMA&TDMA | 64k  |
|3G|WCDMA | 2M |
|4G|OFDMA | 100M |
* 专业术语
	* GSM
		* Um接口
		* TDMA
		* PLMN
		* 载频间隔是200k
			* 25k是保证通讯的基本带宽，GSM设计一个频点8个用户，8X25就是200K
	* NFV(Network Function Virtualization)
		* [放弃笨重昂贵的专用网络设备，转而使用标准的IT虚拟化技术来拆分网络功能模块](http://blog.csdn.net/napolunyishi/article/details/60876466)
		* 关注网络转发功能的虚拟化和通用化
	* SDN
		* 关注于网络控制面和转发面的分离
		* [教程](https://www.sdnlab.com/12184.html)
		* openflow,改革派提出的一种新型网络交换模型,致力于重构互联网
			* https://www.cnblogs.com/hymenz/p/3428913.html
			* https://www.linuxidc.com/Linux/2017-06/144772.htm
			* [原理介绍](http://blog.csdn.net/zwto1/article/details/24517371)
		* [mininet](http://blog.csdn.net/zwto1/article/details/24574837)
		* 控制面
		* 数据面
			* http://blog.csdn.net/kkkkkkkooooooo111/article/details/52270256
			* 设备根据控制平面生成的指令完成用户业务转发和处理的部分
				* 设备
				* 控制面
					* 传送指令、计算表项
					* 协议报文转发、协议表项计算、维护
					* 路由系统:路由协议学习,路由表项维护
					* 控制平面进行协议交互、路由计算后，生成若干表项，下发到转发平面，指导转发平面对报文进行转发
				* 转发平面
					* 数据报文的封装、转发分
					* 数据报文的接收、解封装、封装、转发
					* 系统接收到IP报文后，需要进行解封装，查路由表，从出接口转发
				* 用户业务
				* 转发
				* 处理

