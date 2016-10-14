---
title: Appstore证书
date: 2016/10/13 20:46:25
banner: http://oeyxehw3i.bkt.clouddn.com/Certificate_for_Kid_Template.jpg
tags:
- appstore
- publish
- xcode
---
## Appstore certificates


### 开发者需要

* 证书p12
* 描述文件


证书在本机生成csr然后生成即可。（dev/dis)

描述文件是本地测试机和bundleId绑定的文件。要增加测试机直接导入文件，bundleId也可以直接创建，然后直接生成对应的描述文件。




#### others

* bundleId 可以生成一份*号的方便测试（不包括充值那些功能）
* 证书一年期，如果过期了要重新生成证书及描述文件
* 需要发布的机器必须装上**第一台机器**导出的p12证书


#### not confirm?

* 删掉bundleId，包含它的profile会失效，删掉证书对线上或在用证书影响（待证)