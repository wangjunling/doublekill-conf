---
title: IntelliJ IDEA导入eclipse web项目
date: 2016-10-28 11:12:47
tags: [IDEA,eclipse]
keywords: IntelliJ IDEA导入eclipse web项目
categories: 开发工具
---

1. 首先这是我从`svn checkout`的一个eclipse web项目
{% img /uploads/article/20161028111657.png 500 600 %}
<!-- more -->
2.  在IDEA中依次打开`File->New->Project from Existing Sources`
{% img /uploads/article/20161028111854.png 500 400 %}
3.  选中项目,在弹出框中选择`Import project` 然后选中`eclipse`，剩下的可以一直`next`,最后`finish`
{% img /uploads/article/20161028112044.png 300 600 %} {% img /uploads/article/20161028112139.png 300 600 %}
4.  按`ctrl+shift+alt+s`打开`Project Structure`,点击侧边栏的`Libraries`,然后点击绿色`'+'`,弹出框中选中`java`
{% img /uploads/article/20161028112816.png 300 600 %}
5.  在弹出框中选中项目中`WebRoot/WEB-INF/lib`目录，点击ok,加载完成会提示用户选择模块，选中当前项目，点ok.
{% img /uploads/article/20161028113018.png 300 400 %}
6.  在`Project Structure`中选则左侧栏中的Facets点击绿色`'+'`，然后在弹出的框中选中Web选项，点击确定。
{% img /uploads/article/20161028113244.png 300 600 %}
7.  在右侧选择`web.xml`和`WebRoot`的正确目录,点击右侧绿色铅笔修改。
{% img /uploads/article/20161028113707.png 500 600 %}
8.  最后点击右下角的`Create Artifact`按钮 然后再点击右下角`Fix...`，选中`Add lib to the artifacts`,添加好后，点击确定就好了。
{% img /uploads/article/20161028113749.png 500 600 %}
