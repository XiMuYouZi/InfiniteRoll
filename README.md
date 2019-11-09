# GFW原理
## 海底光缆分布图

![-w729](http://photograph.ximublog.cn/mweb/15732098360110.jpg)
### 1. APCN2（亚太二号）海底光缆
带宽：2.56Tbps
长度：19000km
经过地区：中国大陆、中国香港、中国台湾、日本、韩国、马来西亚、菲律宾。
入境地点：汕头，上海。

### 2. CUCN（中美）海底光缆
带宽：2.2Tbps
长度：30000km
经过地区：中国大陆，中国台湾，日本，韩国，美国。
入境地点：汕头，上海。

### 3. SEA-ME-WE 3（亚欧）海底光缆
带宽：960Gbps
长度：39000km
经过地区：东亚，东南亚，中东，西欧。
入境地点：汕头，上海。

### 4. EAC-C2C海底光缆
带宽：10.24Tbps
长度：36800km
经过地区：亚太地区
入境地点：上海，青岛

### 5. FLAG海底光缆
带宽：10Gbps
长度：27000km
经过地区：西欧，中东，南亚，东亚
入境地点：上海

### 6. Trans-Pacific Express（TPE，泛太平洋）海底光缆
带宽：5.12Tbps
长度：17700km
经过地区：中国大陆，中国台湾，韩国，美国
入境地点：上海，青岛

## GFW布局和位置
![-w594](http://photograph.ximublog.cn/mweb/15728628381615.jpg)

![-w496](http://photograph.ximublog.cn/mweb/15729450543840.jpg)

位置分散，数据不同步

## GFW拦截的方式介绍
### 1、DNS污染
DNS（Domain Name System）污染是GFW的一种让一般用户由于得到虚假目标主机IP而不能与其通信的方法，是一种DNS缓存投毒攻击（DNS cache poisoning）。

其工作方式是：对经过GFW的在UDP端口53上的DNS查询进行入侵检测，一经发现与关键词相匹配的请求则立即伪装成目标域名的解析服务器（NS，Name Server）给查询者返回虚假结果。由于通常的DNS查询没有任何认证机制，而且DNS查询通常基于的UDP是无连接不可靠的协议，查询者只能接受最先到达的格式正确结果，并丢弃之后的结果。

使用DNSSEC（DNSSEC保护区的所有答案都经过数字签名。通过检验数字签名，DNS解析器可以核查信息是否与区域所有者发布的信息相同（未修改和完整），并确系实际负责的DNS服务器所提供）或者通过SS转发DNS请求，DoH (DNS over HTTPS)
![-w670](http://photograph.ximublog.cn/mweb/15729400440131.jpg)


### 2、DPI
「深度数据包检测」的威力，我们可以把数据包想像成一封信。 「浅度」的数据包检测，就好像是看看信封上的发件人和收件人，即决定是否放行。

它并不实际解读数据包的内容，而是搜集周边信息，对数据流进行「肖像刻划」（Profiling）。举个例子，你用Google搜索时，网络上只会有文本和少量图片经过，数据量很小，并且是突发的；但用YouTube看视频时，就会有持续一段时间的大量数据流过。 

「墙」的监控也是基于这样的抽象指标，比如它监控到到间歇而细小的流量，便推断你不太可能是在用YouTube。将诸如此类的可参考指标放在一起，就组成当前数据流的一副「肖像」。把这个「肖像」与数据库里面已经存放的巨量「翻墙流量肖像」和「非翻墙流量肖像」做个比对，就可以相应归类了。


### 3、TCP 重置
TCP重置是TCP的一种消息，用于重置连接。一般来说，例如服务器端在没有客户端请求的端口或者其它连接信息不符时，系统的TCP协议栈就会给客户端回复一个RESET通知消息，可见RESET功能本来用于应对例如服务器意外重启等情况。

防火长城切断TCP连接的技术实际上就是比连接双方更快地发送连接重置消息，使连接双方认为对方终止了连接而自行关闭连接，其效率被认为比单纯的数据包丢弃更有效，因为后者会令连接双方认为连接超时而不断重试创建连接

### 4、封锁IP段
把某个ip段的数据流都转发到黑洞服务器，不作应答或者虚假应答

### 5、SNI阻断
在建立新的 TLS 连接时，客户端（如浏览器）发出的第一个握手包（称为 Client Hello）中，包含了想要访问的域名信息（称为 SNI，Server Name Indication）。某些服务器（比如 CDN）会同时支持多个域名，在加密传输之前，它需要知道客户端访问的是哪个域名。于是 SNI 必须以明文的方式传输。并且由于浏览器并不知道服务器是否需要 SNI，浏览器会对所有的 TLS 握手都加入 SNI。
![-w601](http://photograph.ximublog.cn/mweb/15729436888007.jpg)

![-w1249](http://photograph.ximublog.cn/mweb/15729441010292.jpg)

![-w821](http://photograph.ximublog.cn/mweb/15729437100633.jpg)
![-w895](http://photograph.ximublog.cn/mweb/15729437735884.jpg)

#### Domain Fronting
 它的原理简单来说是这样的：部分服务器允许 TLS 连接说自己需要域名 A，但之后的 HTTP 协议说自己需要域名 B。或者服务器压根就不看 SNI 的信息。在这种情况下，对于一个黑名单的域名， 我们在建立 TLS 的时候，可以选用一个不在黑名单的域名，绕过对 TLS 连接的监测。
当然，它的缺点是，依赖于服务器行为。也就是说，每个不同的站点，可能都需要不同的策略（域名）。


## 机器学习
![-w541](http://photograph.ximublog.cn/mweb/15729427444649.jpg)

[基于长短期记忆网络的V2ray流量识别方法](https://files.catbox.moe/vmzj04.pdf)

#SS原理
![-w609](http://photograph.ximublog.cn/mweb/15732656976997.jpg)
![-w607](http://photograph.ximublog.cn/mweb/15732657097953.jpg)
![-w735](http://photograph.ximublog.cn/mweb/15732657161544.jpg)

![-w680](http://photograph.ximublog.cn/mweb/15728367751785.jpg)
Shadowsocks 由两部分组成，运行在本地的 ss-local 和运行在防火墙之外服务器上的 ss-server，下面来分别详细介绍它们的职责（以下对 Shadowsocks 原理的解析只是我的大概估计，可能会有细微的差别）
### ss-local
ss-local 的职责是在本机启动和监听着一个服务，本地软件的网络请求都先发送到 ss-local，ss-local 收到来自本地软件的网络请求后，把要传输的原数据根据用户配置的加密方法和密码进行加密，再转发到墙外的服务器去。
### ss-server
ss-server 的职责是在墙外服务器启动和监听一个服务，该服务监听来自本机的 ss-local 的请求。在收到来自 ss-local 转发过来的数据时，会先根据用户配置的加密方法和密码对数据进行对称解密，以获得加密后的数据的原内容。同时还会解 SOCKS5 协议，读出本次请求真正的目标服务地址(例如 Google 服务器地址)，再把解密后得到的原数据转发到真正的目标服务。

当真正的目标服务返回了数据时，ss-server 端会把返回的数据加密后转发给对应的 ss-local 端，ss-local 端收到数据再解密后，转发给本机的软件。这是一个对称相反的过程。

由于 ss-local 和 ss-server 端都需要用对称加密算法对数据进行加密和解密，因此这两端的加密方法和密码必须配置为一样。Shadowsocks 提供了一系列标准可靠的对称算法可供用户选择，例如 rc4、aes、des、chacha20 等等。Shadowsocks 对数据加密后再传输的目的是为了混淆原数据，让途中的防火墙无法得出传输的原数据。
### SS工作在会话层
![-w865](http://photograph.ximublog.cn/mweb/15729494454105.jpg)

## SS交互流程
### 1、建立连接
客户端向服务端连接连接，客户端发送的数据包如下：

![-w841](http://photograph.ximublog.cn/mweb/15729457719908.jpg)

其中各个字段的含义如下：

``-VER``：代表 SOCKS 的版本，SOCKS5 默认为0x05，其固定长度为1个字节；

``-NMETHODS``：表示第三个字段METHODS的长度，它的长度也是1个字节；

``-METHODS``：表示客户端支持的验证方式，可以有多种，他的长度是1-255个字节。

目前支持的验证方式共有：

>
* ``0x00``：NO AUTHENTICATION REQUIRED（不需要验证）
* ``0x01``：GSSAPI
* ``0x02``：USERNAME/PASSWORD（用户名密码）
* ``0x03``: to X'7F' IANA ASSIGNED
* ``0x80``: to X'FE' RESERVED FOR PRIVATE METHODS
* ``0xFF``: NO ACCEPTABLE METHODS（都不支持，没法连接了）


![-w925](http://photograph.ximublog.cn/mweb/15729470643504.jpg)

### 2、响应连接
服务端收到客户端的验证信息之后，就要回应客户端，服务端需要客户端提供哪种验证方式的信息。服务端回应的包格式如下：
![-w836](http://photograph.ximublog.cn/mweb/15729460027394.jpg)

其中各个字段的含义如下：

``VER``：代表 SOCKS 的版本，SOCKS5 默认为0x05，其固定长度为1个字节；

``METHOD``：代表服务端需要客户端按此验证方式提供的验证信息，其值长度为1个字节，可为上面六种验证方式之一。
举例说明，比如服务端不需要验证的话，可以这么回应客户端：

![-w915](http://photograph.ximublog.cn/mweb/15729471288854.jpg)



### 3、和目标服务建立连接
#### 3.1、客户端告诉服务端真正需要访问的网站
客户端发起的连接由服务端验证通过后，客户端下一步应该告诉真正目标服务的地址给服务器，服务器得到地址后再去请求真正的目标服务。也就是说客户端需要把 Google 服务的地址google.com:80告诉服务端，服务端再去请求google.com:80。
目标服务地址的格式为 (IP或域名)+端口，客户端需要发送的包格式如下：

![-w836](http://photograph.ximublog.cn/mweb/15729460831350.jpg)
各个字段的含义如下：

``VER``：代表 SOCKS 协议的版本，SOCKS 默认为0x05，其值长度为1个字节；

``CMD``：代表客户端请求的类型，值长度也是1个字节，有三种类型；
>
* ``CONNECT``： 0x01；
* ``BIND``： 0x02；
* ``UDP``： ASSOCIATE 0x03；

``RSV``：保留字，值长度为1个字节；

``ATYP``：代表请求的远程服务器地址类型，值长度1个字节，有三种类型；

>
* ``IPV4``： address: 0x01；
* ``DOMAINNAME``: 0x03；
* ``IPV6``： address: 0x04；

``DST.ADDR``：代表远程服务器的地址，根据 ATYP 进行解析，值长度不定；

``DST.PORT``：代表远程服务器的端口，要访问哪个端口的意思，值长度2个字节。

![-w922](http://photograph.ximublog.cn/mweb/15729471086739.jpg)

#### 3.2、服务端响应连接
服务端在得到来自客户端告诉的目标服务地址后，便和目标服务进行连接，不管连接成功与否，服务器都应该把连接的结果告诉客户端。在连接成功的情况下，服务端返回的包格式如下：
![-w843](http://photograph.ximublog.cn/mweb/15729463455599.jpg)

各个字段的含义如下：

``VER``：代表 SOCKS 协议的版本，SOCKS 默认为0x05，其值长度为1个字节；

``REP``: 代表响应状态码，值长度也是1个字节，有以下几种类型
> 
 * 0x00 succeeded
* 0x01 general SOCKS server failure
* 0x02 connection not allowed by ruleset
* 0x03 Network unreachable
* 0x04 Host unreachable
* 0x05 Connection refused
* 0x06 TTL expired
* 0x07 Command not supported
* 0x08 Address type not supported
* 0x09 to 0xFF unassigned

``RSV``：保留字，值长度为1个字节

``ATYP``：代表请求的远程服务器地址类型，值长度1个字节，有三种类型
>
* IP V4 address： 0x01
* DOMAINNAME： 0x03
* IP V6 address： 0x04

``BND.ADDR``：表示绑定地址，值长度不定。

``BND.PORT``： 表示绑定端口，值长度2个字节

![-w925](http://photograph.ximublog.cn/mweb/15729471604645.jpg)

### 4、数据转发
#### 4.1、客户端-->服务端
客户端在收到来自服务器成功的响应后，就会开始发送数据了，服务端在收到来自客户端的数据后，会转发到目标服务。

![-w929](http://photograph.ximublog.cn/mweb/15729471817518.jpg)

####4.2、服务端-->客户端

![-w923](http://photograph.ximublog.cn/mweb/15729474410348.jpg)

![-w927](http://photograph.ximublog.cn/mweb/15729474858648.jpg)


### SS封装数据包过程
![-w746](http://photograph.ximublog.cn/mweb/15725977518021.jpg)

### 网传的一份联通客户端对于各个协议的识别情况：

![-w661](http://photograph.ximublog.cn/mweb/15729477570303.jpg)


## SS混淆插件介绍
![-w307](http://photograph.ximublog.cn/mweb/15730395165081.jpg)
此类型的插件用于定义加密后的通信协议，通常用于协议伪装，部分插件能兼容原协议。

混淆插件的作用是绕过部分地区部分运营商的QoS限制。实际上，几乎所有地区的订户都可能被运营商针对特定协议流进行限速，尤其是在每天傍晚的上网高峰期，运营商为了给政企客户留出更多带宽，就会限制普通用户的速度。

混淆插件通过将流量伪装成其他流量，来绕开运营商的QoS，侧面实现了提升连接速率的作用。
要么搭配服务端 redirect 参数做个真实网站，要么就用原版混淆插件 plain。 建议避开日本、美国等热门地区
####1、plain
表示不混淆，直接使用协议加密后的结果发送数据包

#### 2、http_simple
并非完全按照http1.1标准实现，仅仅做了一个头部的GET请求和一个简单的回应，之后依然为原协议流。使用这个混淆后，已在部分地区观察到似乎欺骗了QoS的结果。对于这种混淆，它并非为了减少特征，相反的是提供一种强特征，试图欺骗GFW的协议检测

#### 3、http_post
与http_simple绝大部分相同，区别是使用POST方式发送数据，符合http规范，欺骗性更好，但只有POST请求这种行为容易被统计分析出异常。

#### 4、random_head（不建议使用）
开始通讯前发送一个几乎为随机的数据包（目前末尾4字节为CRC32，会成为特征，以后会有改进版本），之后为原协议流。目标是让首个数据包根本不存在任何有效信息，让统计学习机制见鬼去吧。

#### 5、tls1.2_ticket_auth（强烈推荐）
模拟TLS1.2在客户端有session ticket的情况下的握手连接。目前为完整模拟实现，经抓包软件测试完美伪装为TLS1.2。因为有ticket所以没有发送证书等复杂步骤，因而防火墙无法根据证书做判断。
同时自带一定的抗重放攻击的能力，以及包长度混淆能力。如遇到重放攻击则会在服务端log里搜索到，可以通过grep "replay attack"搜索，可以用此插件发现你所在地区线路有没有针对TLS的干扰。
客户端支持自定义参数，参数为SNI，即发送host名称的字段，此功能与TOR的meek插件十分相似，例如设置为cloudfront.net伪装为云服务器请求，可以使用逗号分割多个host如a.com,b.net,c.org，这时会随机使用。
![-w547](http://photograph.ximublog.cn/mweb/15730298119137.jpg)
Session Ticket 是用只有服务端知道的安全密钥加密过的会话信息，最终保存在浏览器端。浏览器如果在 ClientHello 时带上了 Session Ticket，只要服务器能成功解密就可以完成快速握手。

## SS协议插件介绍
此类型的插件用于定义加密前的协议，通常用于长度混淆及增强安全性和隐蔽性，部分插件能兼容原协议。协议插件的作用是对阁下的数据流进行一层封装和验证，防止数据流直接被GFW嗅探到，同时能够提升连接的可靠性和稳定性

#### 1、origin
表示使用原始SS协议，此配置速度最快效率最高，适用于限制少或审查宽松的环境。否则不建议使用。

#### 2、verify_deflate（不建议）
对每一个包都进行deflate压缩，数据格式为：包长度(2字节) | 压缩数据流 | 原数据流Adler-32，此格式省略了0x78,0x9C两字节的头部。因为压缩及解压缩较占CPU，不建议较多用户同时使用此混淆插件。

#### 3、verify_sha1（即原版OTA协议，已废弃）：
对每一个包都进行SHA-1校验，具体协议描述参阅One Time Auth，握手数据包增加10字节，其它数据包增加12字节。此插件能兼容原协议（需要在服务端配置为verify_sha1_compatible)。

2017年2月23日，Google公司公告宣称他们与CWI Amsterdam合作共同创建了两个有着相同的SHA-1值但内容不同的PDF文件，这代表SHA-1算法已被正式攻破。[16]


#### 4、auth_sha1（已废弃）：
对首个包进行SHA-1校验，同时会发送由客户端生成的随机客户端id(4byte)、连接id(4byte)、unix时间戳(4byte)，之后的通讯使用Adler-32（类似CRC32）作为效验码。
此插件提供了能抵抗一般的重放攻击的认证，默认同一端口最多支持64个客户端同时使用，可通过修改此值限制客户端数量，使用此插件的服务器与客户机的UTC时间差不能超过1小时

#### 5、auth_sha1_v2（已废弃）：
与auth_sha1相似，去除时间验证，以避免部分设备由于时间导致无法连接的问题，增长客户端ID为8字节，使用较大的长度混淆。能兼容原协议（需要在服务端配置为auth_sha1_v2_compatible)，支持服务端自定义参数，参数为10进制整数，表示最大客户端同时使用数。

#### 6、auth_sha1_v4（不建议）：
与auth_sha1对首个包进行SHA-1校验，同时会发送由客户端生成的随机客户端id(4byte)、连接id(4byte)、unix时间戳(4byte)，之后的通讯使用Adler-32作为效验码，对包长度单独校验，以抵抗抓包重放检测，使用较大的长度混淆，使用此插件的服务器与客户机的UTC时间差不能超过24小时，即只需要年份日期正确即可。

#### 7、auth_aes128_md5或auth_aes128_sha1（均推荐）：
对首个包的认证部分进行使用Encrypt-then-MAC模式以真正免疫认证包的CCA攻击，预防各种探测和重防攻击，同时此协议支持单端口多用户。


#### 8、auth_chain_a（推荐）：
对首个包的认证部分进行使用Encrypt-then-MAC模式以真正免疫认证包的CCA攻击，预防各种探测和重防攻击，数据流自带RC4加密，同时此协议支持单端口多用户，不同用户之间无法解密数据，每次加密密钥均不相同

#### 9、auth_chain_b（推荐）：
与auth_chain_a几乎一样，但TCP部分采用特定模式的数据包分布（模式由密码决定），使得看起来像一个实实在在的协议，使数据包分布分析和熵分析难以发挥作用。如果你感觉当前的模式可能被识别，那么你只要简单的更换密码就解决问题了。

#### 10、auth_chain_c（推荐）：
与auth_chain_b相比，尽力使得数据包长度分布归属到模式中，让包分布看起来更规整。但此版本与auth_chain_b相比对带宽有更多的浪费。

#### 11、auth_chain_d（推荐）：
与auth_chain_c相比，在一定程度上增加了各种密码生成的模式的最大适用长度，这样就不需要在极端情况下再临时生成随机数，降低大包传输时的计算量，提高下载极限速度。

#### 熵分析
熵是从热物理学领域引入的一个概念，并在热力学中应用。它用于表示一个系统的无序程度，熵值越大，系统中的数据越无序 ；熵值越小数据就越“纯净”。
熵引入到信息论中，以此作为随机事件不确定性的度量，称为信息熵或香农熵。信息熵将使得熵与信息产生信息熵是一种对异常分布很敏感的度量参数
![-w379](http://photograph.ximublog.cn/mweb/15730322338498.jpg)
![-w866](http://photograph.ximublog.cn/mweb/15730322468821.jpg)

## SS加密技术
table，rc4，aes，camellia，bf， cast5，des， idea，seed，sala20，chacha20
### 推荐使用：
AES-128-GCM
AES-192-GCM
AES-256-GCM
ChaCha20-IETF-Poly1305
XChaCha20-IETF-Poly1305
上述算法都是AEAD算法，带有关联数据的认证加密（authenticated encryption with associated data，AEAD，AE的变种）是一种能够同时保证数据的保密性、 完整性和真实性的一种加密模式

### 参考文章：
[为何 shadowsocks 要弃用一次性验证 (OTA)](https://printempw.github.io/why-do-shadowsocks-deprecate-ota/)
![-w733](http://photograph.ximublog.cn/mweb/15731154389823.jpg)

![-w688](http://photograph.ximublog.cn/mweb/15731154488152.jpg)

因为在ARM v8之后加入了AES指令，所以在这些平台上的设备使用AES方式是比Chacha20更快的，同时使用AES也发挥了服务器的性能优势。谷歌也没有取消使用Chacha20，只是开启了ssl_prefer_server_ciphers ，让终端检测是否支持AES指令，如果支持AES就是首选，不支持Chacha20就是首选

## SS加速技术分析
### 1、TCP拥塞控制

#### 快速重传
![-w268](http://photograph.ximublog.cn/mweb/15731174238930.jpg)

#### 拥塞避免算法
![-w642](http://photograph.ximublog.cn/mweb/15731136864502.jpg)

![-w741](http://photograph.ximublog.cn/mweb/15731790882292.jpg)

网络层的拥塞控制主要使用QOS，主要是给流量进行优先级打标和放到不同的优先级队列来给不同的流量进行限速和丢弃处理，详见这篇文章
[IP网络QoS技术](https://www.cnblogs.com/snailrun/p/5583738.html)
[TCP拥塞控制技术详解](https://cloud.tencent.com/developer/article/1369617)
### 2、单边加速
故名思议，只需要在tcp的一端部署的加速技术。因为部署容易，变动不大，所以应用范围较广，包括目前各种商业的的动态加速技术，也大都包含单边加速技术。但也正因为其在tcp一端部署的特性，其必须兼容标准的tcp协议，导致其能优化和调整的地方不如双边加速那么多。绝大大多数的单边加速都是通过优化tcp的拥塞控制算法来实现tcp加速的。

FastTCP，ZetaTCP（LotServer锐速），TCP Vegas， KernelPCC以及最近谷歌开源的BBR
![-w501](http://photograph.ximublog.cn/mweb/15730425770742.jpg)

#### 2.1、ZetaTCP原理：
[ZetaTCP单边加速技术白皮书](http://www.appexnetworks.com.cn/Assets/PDF/ZetaTCP%E5%8D%95%E8%BE%B9%E5%8A%A0%E9%80%9F%E6%8A%80%E6%9C%AF%E7%99%BD%E7%9A%AE%E4%B9%A6.pdf)

![-w548](http://photograph.ximublog.cn/mweb/15731138710121.jpg)


#### 2.2、BBR原理：
BBR 算法不将出现丢包或时延增加作为拥塞的信号，而是认为当网络上的数据包总量大于瓶颈链路带宽和时延的乘积时才出现了拥塞，所以 BBR 也称为基于拥塞的拥塞控制算法（Congestion-Based Congestion Control），其适用网络为高带宽、高时延、有一定丢包率的长肥网络，可以有效降低传输时延，并保证较高的吞吐量，与其他两个常见算法发包速率对比如下：

BBR 算法周期性地探测网络的容量，交替测量一段时间内的带宽极大值和时延极小值，将其乘积作为作为拥塞窗口大小，使得拥塞窗口始的值始终与网络的容量保持一致。

#### 标准 TCP 的这种做法有两个问题：

* 首先，假定网络中的丢包都是由于拥塞导致（网络设备的缓冲区放不下了，只好丢掉一些数据包）。事实上网络中有可能存在传输错误导致的丢包，基于丢包的拥塞控制算法并不能区分拥塞丢包和错误丢包。在数据中心内部，错误丢包率在十万分之一（1e-5）的量级；在广域网上，错误丢包率一般要高得多。
因此标准 TCP 在有一定错误丢包率的长肥管道（long-fat pipe，即延迟高、带宽大的链路）上只会收敛到一个很小的发送窗口。这就是很多时候客户端和服务器都有很大带宽，运营商核心网络也没占满，但下载速度很慢，甚至下载到一半就没速度了的一个原因。

* 其次，网络中会有一些 buffer，就像输液管里中间膨大的部分，用于吸收网络中的流量波动。由于标准 TCP 是通过 “灌满水管” 的方式来估算发送窗口的，在连接的开始阶段，buffer 会被倾向于占满。后续 buffer 的占用会逐渐减少，但是并不会完全消失。客户端估计的水管容积（发送窗口大小）总是略大于水管中除去膨大部分的容积。这个问题被称为 bufferbloat（缓冲区膨胀）。

##### TCP BBR 是怎样解决以上两个问题的呢？
既然不容易区分拥塞丢包和错误丢包，TCP BBR 就干脆不考虑丢包。

既然灌满水管的方式容易造成缓冲区膨胀，TCP BBR 就分别估计带宽和延迟，而不是直接估计水管的容积。

TCP BBR 解决带宽和延迟无法同时测准的方法是：
* 交替测量带宽和延迟；
* 用一段时间内的带宽极大值和延迟极小值作为估计值。

BBR 会在左右两侧的拐点之间停下，基于丢包的标准 TCP 会在右侧拐点停下

图中上半部分的过程可以描述为：随着数据包投递速率增加，如果没有超过最优带宽，则RTT不会变化，此时的RTT是物理链路延迟。随着投递速率继续增加，这时中间路由节点可能出现需要缓存数据包的情况，这会导致RTT变大。如果投递速率继续增加，超过路由缓存能力，则可能出现丢包。

图中下半部分的过程可以描述为：随着数据包投递速率增加，如果没有超过最优带宽，则发送方确认接收端收到的数据速率增加。随着投递速率继续增加，因为数据包缓存在中间路由，这些包并不能及时得到ACK，因此发送方得到的ACK速率，即发送发确认接收方收到数据的速率会维持不变。如果投递速率继续增加，超过路由缓存能力，则可能出现丢包。

![-w679](http://photograph.ximublog.cn/mweb/15731234795495.jpg)

BBR和经典TCP算法的网络抖动对比
![-w735](http://photograph.ximublog.cn/mweb/15731222771629.jpg)

##### BBR 解决了两个问题：

1、在有一定丢包率的网络链路上充分利用带宽。非常适合高延迟、高带宽的网络链路。
2、降低网络链路上的 buffer 占用率，从而降低延迟。非常适合慢速接入网络的用户。

#### PS:
Youtube 部署了 TCP BBR 之后，全球范围的中位数延迟降低了 53%（也就是快了一倍），发展中国家的中位数延迟降低了 80%（也就是快了 4 倍）。

[GOOGLE BBR拥塞控制算法原理](http://www.taohui.pub/2019/08/07/%E4%B8%80%E6%96%87%E8%A7%A3%E9%87%8A%E6%B8%85%E6%A5%9Agoogle-bbr%E6%8B%A5%E5%A1%9E%E6%8E%A7%E5%88%B6%E7%AE%97%E6%B3%95%E5%8E%9F%E7%90%86/)

[TCP BBR](https://github.com/feiskyer/sdn-handbook/blob/master/basic/tcp-bbr.md)

### 3、双边加速
相较于单边加速，双边加速是双端部署，如果是服务器对服务器，那么两边的服务器上都要进行部署，如果是服务器对客户端，那么除了服务器端部署外，客户端也要安装软件。

因为是双边，所以基本上可以说自己的天下了。可以采用各种优化加速技术，例如实现自己更高效的传输协议，数据缓存，流量压缩，多路径转发等。

常见算法：kcptun，finalspeed以及UDPspeeder，都是用udp转发流量。

#### 3.1、UDPSpeeder
UDPspeeder作用是给udp流量加冗余和纠错(RS code)，牺牲一定的流量(通常可小于0.5倍)，让网络达到接近零丢包。 可以单独加速udp，或配合V皮N加速全流量(tcp/udp/icmp)。 最佳的适用场景是加速游戏，也可加速在线视频和网页浏览。

udp2raw不是加速器，只是一个帮助你绕过UDP限制的工具，作用是把udp流量混淆成tcp流量，可以突破udp流量限制或Udp QOS，极大提升稳定性。可以配合kcptun加速tcp，或配合UDPspeeder加速udp，防止各种限速断流。
![-w883](http://photograph.ximublog.cn/mweb/15731163664920.jpg)

#### 3.2、KCP
KCP是一个快速可靠协议，能以比 TCP浪费10%-20%的带宽的代价，换取平均延迟降低 30%-40%，且最大延迟降低三倍的传输效果。纯算法实现，并不负责底层协议（如UDP）的收发，需要使用者自己定义下层数据包的发送方式，以 callback的方式提供给 KCP

TCP协议的可靠与无私让使用TCP开发更为简单，同时它的这种设计也导致了慢的特点。UDP协议简单，所以它更快。但是，UDP毕竟是不可靠的，应用层收到的数据可能是缺失、乱序的。KCP协议就是在保留UDP快的基础上，提供可靠的传输，应用层使用更加简单。
![-w838](http://photograph.ximublog.cn/mweb/15731827844101.jpg)

##### RTO翻倍vs不翻倍：
TCP超时计算是RTOx2，这样连续丢三次包就变成RTOx8了，十分恐怖，而KCP启动快速模式后不x2，只是x1.5（实验证明1.5这个值相对比较好），提高了传输速度。

#####选择性重传 vs 全部重传：
TCP丢包时会全部重传从丢的那个包开始以后的数据，KCP是选择性重传，只重传真正丢失的数据包。

##### 快速重传：
发送端发送了1,2,3,4,5几个包，然后收到远端的ACK: 1, 3, 4, 5，当收到ACK3时，KCP知道2被跳过1次，收到ACK4时，知道2被跳过了2次，此时可以认为2号丢失，不用等超时，直接重传2号包，大大改善了丢包时的传输速度。

##### 延迟ACK vs 非延迟ACK：
TCP为了充分利用带宽，延迟发送ACK（NODELAY都没用），这样超时计算会算出较大 RTT时间，延长了丢包时的判断过程。KCP的ACK是否延迟发送可以调节。

##### UNA vs ACK+UNA：
ARQ模型响应有两种，UNA（此编号前所有包已收到，如TCP）和ACK（该编号包已收到），光用UNA将导致全部重传，光用ACK则丢失成本太高，以往协议都是二选其一，而 KCP协议中，除去单独的 ACK包外，所有包都有UNA信息。

##### 非退让流控：
KCP正常模式同TCP一样使用公平退让法则，即发送窗口大小由：发送缓存大小、接收端剩余接收缓存大小、丢包退让及慢启动这四要素决定。但传送及时性要求很高的小数据时，可选择通过配置跳过后两步，仅用前两项来控制发送频率。以牺牲部分公平性及带宽利用率之代价，换取了开着BT都能流畅传输的效果。

[可靠UDP，KCP协议快在哪？](https://blog.csdn.net/wetest_tencent/article/details/80776204)

[KCP WIKI](https://github.com/skywind3000/kcp/wiki)

#### 3.3、测试对比图
![-w430](http://photograph.ximublog.cn/mweb/15731131762452.jpg)


## PAC路由技术
代理自动配置（英语：Proxy auto-config，简称PAC）是一种网页浏览器技术，用于定义浏览器该如何自动选择适当的代理服务器来访问一个网址。

一个PAC文件包含一个JavaScript形式的函数“FindProxyForURL(url, host)”。这个函数返回一个包含一个或多个访问规则的字符串。用户代理根据这些规则适用一个特定的代理器或者直接访问。当一个代理服务器无法响应的时候，多个访问规则提供了其他的后备访问方法。浏览器在访问其他页面以前，首先访问这个PAC文件

要使用PAC，应当在一个网页服务器上发布一个PAC文件，并且通过在浏览器的代理链接设置页面输入这个PAC文件的URL或者通过使用WPAD协议告知用户代理去使用这个文件。

一个PAC文件是一个至少定义了一个JavaScript函数的文本文件。这个函数FindProxyForURL(url, host)有2个参数：url是一个对象的URL，host是一个由这个URL所派生的主机名。按照惯例，这个文件名字一般是proxy.pac. 

```
   function FindProxyForURL(url, host) {
      // our local URLs from the domains below example.com don't need a proxy:
      if (shExpMatch(url,"*.example.com/*"))                  {return "DIRECT";}
      if (shExpMatch(url, "*.example.com:*/*"))               {return "DIRECT";}
      
      // URLs within this network are accessed through 
      // port 8080 on fastproxy.example.com:
      if (isInNet(host, "10.0.0.0",  "255.255.248.0"))    {
         return "PROXY fastproxy.example.com:8080";
      }
      
      // All other requests go through port 8080 of proxy.example.com.
      // should that fail to respond, go directly to the WWW:
      return "PROXY proxy.example.com:8080; DIRECT";
   }
```
![-w613](http://photograph.ximublog.cn/mweb/15728615689547.jpg)

[PAC配置文件](https://yun.doubibackup.com/Other/pac.txt)

## VMESS

### 1、简介

VMess 协议是由 V2Ray 原创并使用于 V2Ray 的加密传输协议，如同 Shadowsocks 一样为了对抗墙的深度包检测而研发的。在 V2Ray 上客户端与服务器的通信主要是通过 VMess 协议通信。

V2Ray 使用 inbound(传入) 和 outbound(传出) 的结构，形象地说，我们可以把 V2Ray 当作一个盒子，这个盒子有入口和出口(即 inbound 和 outbound)，我们将数据包通过某个入口放进这个盒子里，然后这个盒子以某种机制（这个机制其实就是路由，后面会讲到）决定这个数据包从哪个出口吐出来。

以这样的角度理解的话，V2Ray 做客户端，则 inbound 接收来自浏览器数据，由 outbound 发出去(通常是发到 V2Ray 服务器)；V2Ray 做服务器，则 inbound 接收来自 V2Ray 客户端的数据，由 outbound 发出去(通常是如 Google 等想要访问的目标网站)。

### 2、配置

#### 客户端配置

```
{
  "inbounds": [
    {
      "port": 1080, // 监听端口
      "protocol": "socks", // 入口协议为 SOCKS 5
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls"]
      },
      "settings": {
        "auth": "noauth"  //socks的认证设置，noauth 代表不认证，由于 socks 通常在客户端使用，所以这里不认证
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "vmess", // 出口协议
      "settings": {
        "vnext": [
          {
            "address": "serveraddr.com", // 服务器地址，请修改为你自己的服务器 IP 或域名
            "port": 16823,  // 服务器端口
            "users": [
              {
                "id": "b831381d-6324-4d53-ad4f-8cda48b30811",  // 用户 ID，必须与服务器端配置相同
                "alterId": 64 // 此处的值也应当与服务器相同, 这个参数主要是为了加强防探测能力。理论上 alterId 越大越好，但越大就约占内存(只针对服务器，客户端不占内存)
              }
            ]
          }
        ]
      }
    }
  ]
}
```

"sniffing" 字段，V2Ray 手册解释为“流量探测，根据指定的流量类型，重置所请求的目标”，这个配置是为了从流量中提取ip和domain信息，这样针对ip和domain的路由规则才能生效。这个 sniffing 有两个用处：

- 解决 DNS 污染；
- 对于 IP 流量可以应用后文提到的域名路由规则；
- 识别 BT 协议，根据自己的需要拦截或者直连 BT 流量

#### 服务端端配置

```
{
  "log": {
    "loglevel": "warning",
    "access": "D:\\v2ray\\access.log",
    "error": "D:\\v2ray\\error.log"
  },
  
  "inbounds": [
    {
      "port": 1080,
      "protocol": "socks",
      "settings": {
        "auth": "noauth"  
      }
    }
  ],
  
  "outbounds": [ 
    {
      "protocol": "vmess", // 出口协议
      "settings": {
        "vnext": [
          {
            "address": "serveraddr.com", // 服务器 IP 地址
            "port": 16823,  // 服务器端口
            "users": [
              {
                "id": "b831381d-6324-4d53-ad4f-8cda48b30811",  // 用户 ID，须与服务器端配置相同
                "alterId": 64
              }
            ]
          }
        ]
      }
    },
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {}
    }
  ]
}，

"routing": {
    "domainStrategy": "IPOnDemand",
    "rules": [
    //阻止广告
      {
        "domain": [
          "tanx.com",
          "googeadsserving.cn",
          "baidu.com"
        ],
        "type": "field",
        "outboundTag": "adblock"       
      },
      //具体的国内网站
      {
        "domain": [
          "amazon.com",
          "microsoft.com",
          "jd.com",
          "youku.com",
          "baidu.com"
        ],
        "type": "field",
        "outboundTag": "direct"
      },
      //大陆主流网站
      {
        "type": "field",
        "outboundTag": "direct"，
        "domain": ["geosite:cn"]
      },
      //私有地址
      {
        "type": "field",
        "outboundTag": "direct",
        "ip": [
          "geoip:cn",
          "geoip:private"
        ]
      }
    ]
  }
  }
  
```

``{浏览器} <--(socks)--> {V2Ray 客户端 inbound <-> V2Ray 客户端 outbound} <--(VMess)-->  {V2Ray 服务器 inbound <-> V2Ray 服务器 outbound} <--(Freedom)--> {目标网站}
``

[v2ray配置指南](http://www.zhuht.xyz/articles/2019/06/25/1561452909260.html)
## Wireguard

![-w1054](http://photograph.ximublog.cn/mweb/15732020025534.jpg)

![-w499](http://photograph.ximublog.cn/mweb/15732046260177.jpg)


### server配置

```
[Interface]
PrivateKey = EFkHNqKrLjjnVqeUfLd70extGCPHj7bsET1LNYjm51I=
Address = 10.10.10.1
ListenPort = 54321

[Peer]
PublicKey = 6ASrcQzy+hWVm1JEC/mz0AlyF2uASRE+SknTFqa4s1g=
AllowedIPs = 10.10.10.2/32

[Peer]
PublicKey = QEKrMGYh7VdGeuhdDR0VvSy2Gy+GESq1Y9SOXG2jShg=
AllowedIPs = 10.10.10.3/32
```

AllowedIPs 属性对于出口流量来说是路由表，对于入口流量来说则是访问控制列表

### client配置

```
[Interface]
PrivateKey = QJAWG0EVyt7DXfzK49KBniRm2XS698ptNr9wLfX4qG8=
Address = 10.10.10.3
DNS = 8.8.8.8

[Peer]
PublicKey = pJyCyGG5NAyqQte62JZ2d4tUDy1B06Y4kloQetAP/T0=
Endpoint = 149.28.171.194:54321
AllowedIPs = 0.0.0.0/0

```
AllowedIPs 配置为 0.0.0.0/0 用于将所有流量都路由到 VPS，相当于全局代理。


## 如何对抗GFW检测

### 1、反向代理
http/https方式打开域名，显示正常的网页。V2Ray客户端请求特定的路径，例如https://tlanyan.me/awesomepath，能科学上网；
浏览器直接请求https://tlanyan.me/awesomepath，返回”400 bad request”。即外部看起来完全是一个人畜无害的正规网站，特定手段请求特定网址才是科学上网的通道

### 2、websocket + CDN
CDN SERVER在中间负责中转，而客户端到CDN， CDN到VPS之间有两次HTTPS打包过程。 这里两次打包使用的加密证书是不同的.

防火墙就只知道你和 CDN 之间建立了连接，不知道你的 vps 实际的 IP 地址，这样就可以有效的防止你的 IP 被 ban，并且 CDN 会有很多 IP 地址，防火墙也不会随意去 ban 他们的 IP，毕竟也有很多正规的网站在使用，所以基本上可以确保你的 IP 的安全。


![-w787](http://photograph.ximublog.cn/mweb/15732702624170.jpg)

![-w732](http://photograph.ximublog.cn/mweb/15732701683563.jpg)

#### 优点
* 有效防止 IP 被 ban
* 已经被 ban 的 IP 也能通过这个方式继续使用
* 对于网络很糟糕的线路可以起到加速的效果

##### 缺点
* 延迟可能会增大
* 对于原本很好的线路会起到减速的效果
* 配置比较繁琐
