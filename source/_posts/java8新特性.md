---
title: java8新特性
date: 2016-11-04 14:00:08
tags: [Java8,Lambda,Stream,Optional]
keywords: java8新特性,lambda
categories: java
---
## 接口的默认方法和静态方法
在接口中定义默认方法和静态方法：
```
public interface DefaultInterface{

    default void defaultFun(){
        System.out.println("default function!");
    }
    static void staticFun(){
        System.out.println("static function!");
    }
}
```
特点：
**
1.这两种方法的定义必须要有具体实现。
2.默认方法可以被实现类直接使用，也可以被实现类重写。
3.静态方法只能通过接口名调用。
**
<!-- more -->

代码如下：
```
public class DefaultImpl implements DefaultInterface{
    @Override
    public void defaultFun(){
        System.out.println("override implementation");
    }
}
public class Index {
    public static void main(String[] args){
        DefaultInterface.staticFun();

        DefaultInterface defaultInterface = new DefaultInterface() {};
        defaultInterface.defaultFun();

        DefaultInterface defaultInterface2 = new DefaultImpl();
        defaultInterface2.defaultFun();
        //DefaultImpl.staticFun();//无法调用
    }
}
```
打印结果：
```
static function!
default function!
override implementation
```
## Lambda表达式

Lambda允许把函数作为一个方法的参数（函数作为参数传递进方法中），也就是我们所说的函数式编程。
**怎样将一个函数作为参数传递？**
其实就是利用一个只有一个方法的接口（也就是函数式接口），new一个匿名类调用其中的唯一方法。
看如下代码，`FunctionInterface`是一个函数式接口，里边有一个抽象方法`method`,`callMethod`方法定义是直接调用`FunctionInterface.method()`;所以在调用callMethod方法的时候，参数可以直接new一个`FunctionInterface`，写好`method`的实现。此时也就是相当于我们将`method`方法直接传递给`callMethod`方法了。
```
public interface FunctionInterface {
	void method();
}
public class Index {
  public static void callMethod(FunctionInterface functionInterface){
    functionInterface.method();
  }
  public static void main(String[] args) {

    callMethod(new FunctionInterface() {
        @Override
        public void method() {
          System.out.println("function interface");
        }
      });
    }

}
```
但是上边调用`callMethod`方法的代码看起来比较乱，比较难看，所以我们可以用Lambda表达式：
```
public class Index {
	public static void main(String[] args) {

		callMethod(() -> System.out.println("function interface"));
	}
}
```
现在我们来看一个例子,这是一个循环打印一个list的代码，利用forEach方法。
```
Arrays.asList( "p", "k", "u","f", "o", "r","k").forEach(new Consumer<String>() {
  @Override
  public void accept(String s) {
    System.out.println(s);
  }
});
```
如果用Lambda表达式
```
Arrays.asList( "p", "k", "u","f", "o", "r","k").forEach((String s) -> System.out.println(s) );
```
还可以更简洁
```
Arrays.asList( "p", "k", "u","f", "o", "r","k").forEach( s -> System.out.println(s) );
```
Java编译器能够自动识别参数的类型，所以你就可以省略掉类型不写。

## 函数式接口
函数式接口就是一个有且只有一个抽象方法的接口。也就是函数式接口也可以有默认方法和静态方法，如：
```
public interface FunctionInterface {
	void method();
}
```
任何只有一个抽象方法的接口都可以做成Lambda表达式，所以为了保证你的接口可以用Lambda表达式，你应该给接口添加一个`@FunctionalInterface`注解，这个注解加上去之后，如果接口中定义了第二个抽象方法的话，编译器就会抛异常。
```
@FunctionalInterface
public interface FunctionInterface {
	void method();
}
```
## 方法和构造函数引用
Java 8 允许你通过`::`关键字获取方法或者构造函数的的引用
静态方法：
如下，`DefaultInterface::staticFun`返回一个函数引用，相当于js中的闭包，由于`staticFun`是无参数也无返回值，而`Runnable`是一个无参数也无返回值的一个函数式接口，所以这里可以用`Runnable`来接收。当调用`staticFun.run();`的时候，才真正调用了`staticFun`方法。
```
public interface DefaultInterface{
    static void staticFun() {
        System.out.println("static function!");
    }
}
public class Index {
    public static void main(String[] args){
		Runnable staticFun = DefaultInterface::staticFun;
		staticFun.run();
    }
}
```
构造方法：
定义一个student类
```
public class Student {
	private String name;
	private String sex;

	public Student(String name, String sex) {
		this.name = name;
		this.sex = sex;
	}
        public String getName() {
            return name;
        }
}
```
`Student:new`会返回Student构造方法的引用，此方法需要有两个String参数，返回Student对象，所以我新建一个`StudentConstructor`函数式接口：
```
@FunctionalInterface
public interface StudentConstructor<P extends Student> {
	P create(String name,String sex);
}
```
现在可以这样调用
```
StudentConstructor<Student> constructor = Student::new;
Student student = constructor.create("a","男");
Supplier<String> getName = student::getName;
System.out.println(getName.get());
```

## 内置函数式接口
JDK 1.8 API中包含了很多内置的函数式接口。有些是在以前版本的Java中大家耳熟能详的，例如`Comparator`接口，或者`Runnable`接口。对这些现成的接口进行实现，可以通过`@FunctionalInterface` 标注来启用Lambda功能支持。

此外，Java 8 API 还提供了很多新的函数式接口，来降低程序员的工作负担。有些新的接口已经在Google Guava库中很有名了。如果你对这些库很熟的话，你甚至闭上眼睛都能够想到，这些接口在类库的实现过程中起了多么大的作用。
1.Runnable
无参数，无返回值
例如
```
public interface DefaultInterface{
    static void staticFun() {
        System.out.println("static function!");
    }
}
public class Index {
    public static void main(String[] args){
		Runnable staticFun = DefaultInterface::staticFun;
		staticFun.run();
    }
}
```
结果：
`static function!`
2.Consumer
有一个参数，无返回值
```
Consumer<String> greeter = (p) -> System.out.println("Hello, " + p);
greeter.accept("DoubleKill");
```
3.Predicate
有一个参数，返回布尔类型
```
Predicate<String> predicate = (s) -> s.length() > 0;
predicate.test("foo");              // true
```
像一些判断的方法都属于这种类型如
```
Predicate<Boolean> nonNull = Objects::nonNull;
Predicate<Boolean> isNull = Objects::isNull;

Predicate<String> isEmpty = String::isEmpty;
Predicate<String> isNotEmpty = isEmpty.negate();
```
4.类似的还有：
Supplier：无参数，有返回值
Function：有一个参数，有返回值
UnaryOperator：无参数，有返回值，返回值还是一个UnaryOperator

## Optional
`Optional`类的Javadoc描述如下:
> 这是一个值可以为null的容器对象。如果值存在则`isPresent()`方法会返回true，调用`get()`方法会返回该对象。

例如有这样一个需求，从一个service的方法获取一个有可能为`null`的list，如果这个list不为`null`，就给list添加一个字符串：
```
List<String> list = service.findAll();
  if(list!=null){
    list.add("more");
  }
```
此时我们如果使用`Optional`：
```
Optional<List<String>> optional = service.findAll();
		if(optional.isPresent()){
			List<String> studentList1 = optional.get();
			studentList1.add("more");
		}
```
如果我们使用`Optional`中的`ifPresent`方法：
```
Optional<List<String>> optional = service.findAll();
optional.ifPresent(stringList -> stringList.add("more"));
```
但我们发现代码变的优雅了但其实逻辑并没有简洁多少，那么用`Optional`的意义是什么？
**`Optional`是一个简单的值容器，也是一个精巧的工具类，当某些方法返回`Optional`的时候，也就是告诉我们这个方法返回的值有可能为`null`，也有可能不为`null`，需要我们来进行判断,以此来防止`NullPointerEception`产生。**

## Stream
`java.util.Stream`接口的javadoc描述：
> 一种支持顺序和并行聚合操作的元素序列。

`Stream`操作可以是中间操作，也可以是完结操作。完结操作会返回一个某种类型的值，而中间操作会返回流对象本身，并且你可以通过多次调用同一个流操作方法来将操作结果串起来。`Stream`是在一个源的基础上创建出来的，例如`java.util.Collection`中的list或者set（map不能作为`Stream`的源）。`Stream`操作往往可以通过顺序或者并行两种方式来执行。
### filter
Filter接受一个`predicate`接口类型的变量，并将所有流对象中的元素进行过滤。该操作是一个中间操作，因此它允许我们在返回结果的基础上再进行其他的流操作（forEach）。`ForEach`接受一个`Function`接口类型的变量，用来执行对每一个元素的操作。`ForEach`是一个中止操作。它不返回流，所以我们不能再调用其他的流操作。
```
List<String> tags = Arrays.asList("ac", "ccc", "c", "dd", "axx", "f");
tags.stream().filter(s -> s.startsWith("a")).forEach(System.out::println);
// ac
// axx
```
### sorted
sorted返回`Stream`对象，所以它是一个中间操作，能够返回一个排过序的流对象的视图。默认按照自然顺序对视图进行排序，当然你也可以指定一个`Comparator`来改变排序规则。
```
tags.stream().sorted().forEach(System.out::println);
//ac
//axx
//c
//ccc
//dd
//f
```
sorted只是创建一个流对象的排序视图，而原来的集合中元素是不变的
```
System.out.println(tags);
// [ac, ccc, c, dd, axx, f]
```

### map
map接受一个`Function`接口类型的变量，返回一个`Stream`对象，也是中间操作，但需要注意的是，map返回的`Stream`指定的泛型是根据传入的`Function`来指定的。源码如下：
```
 <R> Stream<R> map(Function<? super T, ? extends R> mapper);
```
也就是说我们可以用map来变换Stream的泛型类型。
比如我们有一个文章的list,我想打印每个文章的title，利用map很容易就可以做到，为了看的更清楚，我把每一步都分开写了，可以看到，用map将`Stream<Article>`变换为`Stream<String>`
```
Stream<Article> stream = articleList.stream();

Stream<String> stringStream = stream.map(article -> article.getTitle());
stringStream.forEach(System.out::println);
```
如果将上述代码串联起来：
```
articleList
  .stream()
  .map(article -> article.getTitle())
  .forEach(System.out::println);
```
### flatMap
`flatMap`接受一个`Function`接口类型的变量，返回一个`Stream`对象，属于中间操作，用来做变换操作。源码如下：
```
<R> Stream<R> flatMap(Function<? super T, ? extends Stream<? extends R>> mapper);
```
跟map不同的是，`flatMap`传入的`Function`的返回类型也是一个`Stream`。
比如我们有这样一个需求，打印所有文章的标签，每个文章有多个标签。我们可以这样写：
```
articleList
  .stream()
  .forEach(
          article -> article.getTags()
                                .stream()
                                .map(tag -> tag.getName())
                                .forEach(System.out::println)
          );
```
代码做了两次`forEach`，很明显代码阅读性很差，下面我们用`flatMap`来写：
```
articleList
  .stream()
  .flatMap(article -> article.getTags().stream())
  .map(tag -> tag.getName())
  .forEach(System.out::println);
```
flat单词意思有：vt:使变平，adj. 平的
一篇文章下有多个标签，但是用`flatMap`转换后，可以直接顺序操作其中每个标签，相当于把所有文章的标签平铺到一个list中来操作了。
### Parallel Streams
像上面所说的，流操作可以是顺序的，也可以是并行的。顺序操作通过单线程执行，而并行操作则通过多线程执行。

下面的例子就演示了如何使用并行流进行操作来提高运行效率，代码非常简单。

首先我们创建一个大的list，里面的元素都是唯一的：

```
int max = 1000000;
List<String> values = new ArrayList<>(max);
for (int i = 0; i < max; i++) {
    UUID uuid = UUID.randomUUID();
    values.add(uuid.toString());
}
```
现在，我们测量一下对这个集合进行排序所使用的时间。

顺序排序

```
long t0 = System.nanoTime();

long count = values.stream().sorted().count();
System.out.println(count);

long t1 = System.nanoTime();

long millis = TimeUnit.NANOSECONDS.toMillis(t1 - t0);
System.out.println(String.format("sequential sort took: %d ms", millis));

// sequential sort took: 899 ms
```
并行排序

```
long t0 = System.nanoTime();

long count = values.parallelStream().sorted().count();
System.out.println(count);

long t1 = System.nanoTime();

long millis = TimeUnit.NANOSECONDS.toMillis(t1 - t0);
System.out.println(String.format("parallel sort took: %d ms", millis));

// parallel sort took: 472 ms
```
如你所见，所有的代码段几乎都相同，唯一的不同就是把`stream()`改成了`parallelStream()`, 结果并行排序快了50%。
