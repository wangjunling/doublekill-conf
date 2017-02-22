---
title: maven 多环境打包
tag: maven
categories: java
keywords: maven 多环境打包
---
### 1.在项目的pom中添加
```
<build>
    <resources>
        <!-- Resource Filter -->
        <resource>
            <directory>src/main/resources</directory>
            <filtering>true</filtering>
        </resource>
    </resources>
</build>
    <profiles>
        <profile>
        <!--开发环境 -->
            <id>dev</id>
            <activation>
                <activeByDefault>true</activeByDefault>
                <-- 可以指定jdk的版本-->
                <jdk>1.6</jdk>
            </activation>
            <properties>
                <maven.jdbc.host>localhost</maven.jdbc.host>
                <maven.jdbc.port>3306</maven.jdbc.port>
                <maven.jdbc.db>dev</maven.jdbc.db>
                <maven.jdbc.username>root</maven.jdbc.username>
                <maven.jdbc.password>root</maven.jdbc.password>
            </properties>
        </profile>
        <profile>
            <id>test</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <properties>
                <maven.jdbc.host>test.host</maven.jdbc.host>
                <maven.jdbc.port>3306</maven.jdbc.port>
                <maven.jdbc.db>test</maven.jdbc.db>
                <maven.jdbc.username>root</maven.jdbc.username>
                <maven.jdbc.password>root</maven.jdbc.password>
            </properties>
        </profile>
    </profiles>
```
<!-- more -->
### 2.在上边的resource节点指定的路径创建config.properties

```
jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://${maven.jdbc.host}:${maven.jdbc.port}/${maven.jdbc.db}
jdbc.username=${maven.jdbc.username}
jdbc.password=${maven.jdbc.password}
```
### 3.运行命令 编译项目，环境指定为dev
```
mvn compile -P dev
```

然后打开编译后的config.properties    如下
```
jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/dev
jdbc.username=root
jdbc.password=root
```
已经把值赋进去了。
同样用
```
mvn compile -P test
```
然后打开编译后的config.properties    如下
```
jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://test.host:3306/test
jdbc.username=root
jdbc.password=root
```
### 4.或者可以用idea 打开maven projects 选择Profiles 下边的dev或者test来打包不同的环境包
![idea](/uploads/article/201610201.png)
