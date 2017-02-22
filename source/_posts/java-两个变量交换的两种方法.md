---
title: java 两个变量交换的两种方法
date: 2016-10-20 13:04:09
tags: java
categories: java
keywords: 两个变量交换
---


#### 1. 两个变量求和然后相减


```
    public static void main(String[] args)
    {
        int a = 12;
        int b = 22;
        a = a + b;
        b = a - b;
        a = a - b;
        System.out.println("a=" + a + ";b=" + b);
    }
```
<!-- more -->
#### 2. 利用位运算的方式 原理是：**一个数异或同一个数两次，结果还是那个数**

```
    private static void test()
    {
        int c = 5;
		int d = 10;
        c = c ^ d;
        d = d ^ c;
        c = d ^ c;
        System.out.println("c=" + c + ";d=" + d);
    }
```
