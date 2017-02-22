---
title: linux部署项目常用命令
tags: linux
categories: linux
---


### 1.解压game.war

```
jar -xvf game.war
```
### 2.删除文件夹以及文件夹中所有文件，文件夹

```
rm -rf /var/log/httpd/test
```
<!-- more --> 
### 3.杀死tomcat进程。
#### 查看tomcat 进程

```
ps -ef |grep tomcat
```
#### 杀死进程 5144
```
kill -9 5144
```
### 4.查看日志

#### 显示文件 example.txt 的后十行内容并在文件内容增加后，自动显示新增的文件内容。
```
 tail -f example.txt
```
### 5.将 /aaa目录下的所有东西拷到/bbb/下而不拷贝aaa目录本身。
#### 即格式为：cp -Rf 原路径/ 目的路径/
```
cp -Rf /aaa/* /bbb/
```
