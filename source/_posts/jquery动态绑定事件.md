---
title: jquery动态绑定事件
date: 2016-10-20 11:26:14
tags: jquery
categories: js
keywords: jquery动态绑定事件
---

 - 例如在下面div中,我们想给input绑定点击事件，但是这个input是后续动态加进去的，比如是异步加载过来的，所以我们如果直接用 $("#test input:first").click();jquery是找不到这个input的。

```
<div id="test"><input type="button" value="提交" /></div>
```

 - 所以我们可以用on方法
<!-- more -->

```
$("#test").on("click","input:first",function(){
    console.log('点击');
});
```

>on() 方法在被选元素及子元素上添加一个或多个事件处理程序。
自 jQuery 版本 1.7 起，on() 方法是 bind()、live() 和 delegate() 方法的新的替代品。该方法给 API 带来很多便利，我们推荐使用该方法，它简化了 jQuery 代码库。
**注意**：使用 on() 方法添加的事件处理程序适用于当前及未来的元素（比如由脚本创建的新元素）。
**提示**：如需移除事件处理程序，请使用 off() 方法。
**提示**：如需添加只运行一次的事件然后移除，请使用 one() 方法。

> *事件冒泡：在一个对象上触发某类事件（比如单击onclick事件），如果此对象定义了此事件的处理程序，那么此事件就会调用这个处理程序，如果没有定义此事件处理程序或者事件返回true，那么这个事件会向这个对象的父级对象传播，从里到外，直至它被处理（父级对象所有同类事件都将被激活），或者它到达了对象层次的最顶层，即document对象（有些浏览器是window）。*
