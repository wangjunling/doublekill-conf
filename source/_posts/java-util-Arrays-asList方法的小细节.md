---
title: java.util.Arrays.asList方法的小细节
date: 2017-02-22 09:31:05
tags: java
categories: java
---
## 问题
先看这段代码,使用Arrays.asList返回一个List,然后在list中增加一个对象，抛出java.lang.UnsupportedOperationException，意思是不支持这个操作。
```
List<String> list = Arrays.asList("a","b","c","d","e");
System.out.println(list);
list.add("f");
System.out.println(list);
输出：
[a, b, c, d, e]
Exception in thread "main" java.lang.UnsupportedOperationException
....
```

<!-- more -->
## 分析
下面是java.Arrays.asList的源码,返回一个ArrayList，好像没有什么不对的。
```
public static <T> List<T> asList(T... a) {
return new ArrayList<T>(a);
}
```
但是方法注释写着：`Returns a fixed-size list backed by the specified array...`返回由指定数组支持的固定大小的列表.


**仔细观察的话，就会发现此时返回的ArrayList并不是我们熟悉的java.util.ArrayList，而是Arrays类中的一个静态内部类：**
` private static class ArrayList<E> extends AbstractList<E> implements RandomAccess, java.io.Serializable`
**此内部类继承与java.util.AbstractList，但是并没有实现add,remove方法**


在java.util.AbstractList中的add和remove源码：
```
public void add(int index, E element) {
    throw new UnsupportedOperationException();
}

public E remove(int index) {
    throw new UnsupportedOperationException();
}
```
可以看到这两个方法直接就抛出异常，因为这两个方法是需要子类重写的。所以当我们使用asList时应注意返回的list大小是不能变的，如果想改变list的大小，可以这样：
```
List<String> list =new ArrayList<>(Arrays.asList("a","b","c","d","e"));
```
或者使用其他工具类。
