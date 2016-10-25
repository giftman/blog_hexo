---
title: 30Day's react native way
date: 2016/10/19 20:46:25
thumbnail: http://oeyxehw3i.bkt.clouddn.com/16-10-21/94798663.jpg
tags:
- react native
- tutorial
categories:
- ReactNative
---
# 30Day's react native way

A study note based on [@Wei Fang](https://github.com/fangwei716)'s awesome [project](https://github.com/fangwei716/30-days-of-react-native).

[github地址](https://github.com/giftman/ThirtyDaysOfReactNative)

### Day1 Timer

* 布局 文字 fontWeight
* 状态一控制
* 组件分开写最后组合
* 小的标志图可用position
* 计时逻辑

### Day2 Weather
* 布局 scrolview vector-icon 
* swiper 一次map了各城市数据
* 内嵌scrollview

### Day3 Twitter
* 动画 变形及透明  动画constructor时设初值 组件style时设为属性，动作或者ComponentDidMount 时启动动画。动画有几种，我喜欢的牛读翻页效果是Flip <https://github.com/kevinstumpf/react-native-flip-view>
* 下拉刷新 scrollview-->refreshControl 
* tab tab为了兼容android用了react-native-tab-navigator，简洁可定制，如果要可以左右切换效果可以用react-native-scrollable-tab-view。因为这里需要下拉刷新，如果直接用scrollable的tab会下拉不了。而且初始化时load完所有页面数据过大，还是简洁的用第一个较可定制。
* 现在层的实现都是通过用position:'absolute'，后一层叠在前一层上，试了zIndex再看下效果。

###Day6 Spotify
* 介面实在动人 react-native-video + react-native-swiper 
* swiper 为了全屏可触用了position:'absolute',它本身可以设置height/width,页面的点在靠下方位置。
* spotify FontAwesome


### Day9 TwitterUi

* 先实现静态布局
* 找出几个关键的位置点
* icon的变化：以自我位置为中心点，向上负数缩小，向下正数／上移过程有因素值使icon位置同时上向下移，速度稍慢于整体图片上下移
* bannerImg ：bannerTop 一直为0,直到上移到-62.5,然后再上移一步，_bannerTop就要相应高度下移一步
* 透明度的计算：math.pow() 现在的高度/最终高度
* 手势：需要设置panResponder 将触摸权限交给scrollView  才有可能实现类似的上移一部分后scrollView 或者ListView 继续上移，这里不展开
* (tag:todo) stick header 效果



### Day10 TumblrAnimation

* 位移动画
* 设置state和执行Animate顺序有讲究，先让看到再执行动画，后面则相反，延迟一点让动画执行完再不显示 
* Touchable控件的子件默认是占满整个父件空间，可以参考NeverMind
* 现在支持zIndex写可以更方便
* 先用Sketch实现了布局再去写快好多--



### Day13 Twitter Input Ui

* TextInput
* CameraRoll.getPhotos

### Day 14 SwiperCard

* 注意细节，在拖动时可以看到下一张图
* 现在的tinder改变了，直接运行实例无法重现gift图效果,实现了布局
* tag:todo 实现**react-native-tinder-swipe-cards** 这个代码不长，效果酷炫，是尝试animate的绝佳材料...

### Day16 Unlock with gesture

* 父子控件之间数据传递
* 实际写会遇到自己忽略的问题

### Day17 不兼容android暂时跳过(tag:todo)

### Day18 
> 看似复杂的坎，越过才会发现是那回事。
* 这个例子用到的还是最初的原理，View 随着state 的变化而更新。两个View变化之间的补间动画由LayoutAnimation帮我们去完成。
* 过程:触摸时获取到方块 index给它加效果阴影,每次移动更新位置，移动到其它块位置时将它在数组的位置更新LayouAnimation动画更新。触摸结束后让被触摸到的块回到它新index应该去的地方。
* 难点:判断触摸到的index,最后移动到哪里去了。
* 判断边界条件，不在范围内的index处理。
* 细节许多可以借鉴

### Day20 Single Reminder
* 先想好布局分层，多层易乱
* LayoutAnimation 选中完成的动作是由无到有底色，只是更换背景没有这种效果，要从无到有。
* 阴影的使用

### Day21 MultiReminder
* 单页面到多页面的转变，适用于很多类似的情况，也是对状态的改变所render的页面随之变化，效果出众，代码简洁。
*  LayoutAnimation

### Day22 GoogleNow
* 看似简单的页面有大智慧呀
* 动画可以用Animated量不用LayoutAnimation(我猜的)
* 第一坑：动画效果是Touch->AnimateView->View->Icon/Touch->AnimateView->Icon,AnimateView放大占满屏幕，View(Icon)缩小相反倍数。
* 第二坑:输入框外面总包了层View，一为了阴影效果，一个是为了输入的文字在框四周有padding.
* Animated's easing: Easing.elastic(1)
