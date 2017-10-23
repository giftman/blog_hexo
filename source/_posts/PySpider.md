---
title: PySpider
date: 2017/10/23 20:46:25
banner: http://www.filebuzz.com/software_screenshot/full/pyspider-454418.jpeg
tags:
- crawl
- python
- pyspider
categories:
- crawl
---
## PySpider

官网：http://www.pyspider.cn/book/pyspider/pyspider-Quickstart-2.html

Web页面说明：http://www.pyspider.cn/jiaocheng/pyspider-webui-12.html

### 选择元素

PyQuery 使用 https://xuanwo.org/2015/10/23/pyquery-intro/

PyQuery Api：http://pyquery.readthedocs.io/en/latest/api.html

```
m = '<p><span><em>Whoah!</em></span></p><p><em> there</em></p>'
d = PyQuery(m)
d('p').eq(1) #取第一个元素
```



urldecode

script can use PhantomJS & selenium
