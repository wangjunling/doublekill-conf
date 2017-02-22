---
title: Intellij IDEA Lambda提示 Can be replaced with method reference
date: 2016-11-10 14:12:53
tags: [IDEA,Lambda,Java8]
keywords: Intellij,IDEA,Lambda提示,Can,be,replaced,with,method,reference
categories: 开发工具
---
### 问题
在IDEA中使用lambda表达式有时会有这样的提示：Can be replaced with method reference...
![提示](/uploads/article/IntellijIDEALambda20161110151454.png)
### 解决方法
出现这种提示一般可以将表达式改为用`::`关键字

|方法引用	| 等价的lambda表达式|
| ------------- |:-------------:|
| `String::valueOf`	 | `x -> String.valueOf(x)` |
| `Object::toString`	| `x -> x.toString()`|
| `x::toString`	       | `() -> x.toString()`|
| `ArrayList::new`	 | `() -> new ArrayList<>()`|

<!--more -->
###  示例
#### 示例1
静态方法：
```
List<String> tags = Arrays.asList("ac", "ccc", "c", "dd", "axx", "f");
tags.stream().forEach(s -> System.out.println(s));//System.out.println(s)会有提示
```
替换为：
```
tags.stream().sorted().forEach(System.out::println);
```
#### 示例2
如果调用有一个参数的普通方法：
```
List<Tag> tagList = Arrays.asList(new Tag("map"),new Tag("java8"),new Tag("filter"));
tagList.stream().map(tag -> tag.getName());//tag.getName()会有提示
```
可以替换为：
```
tagList.stream().map(Tag::getName);
```
#### 示例3
还有两个参数的普通方法：
```
List<String> tags = Arrays.asList("ac", "ccc", "c", "dd", "axx", "f");
tags.stream().sorted((o1, o2) -> o1.compareTo(o2));//o1.compareTo(o2)会有提示
```
可以替换为：
```
tags.stream().sorted(String::compareTo);
```
