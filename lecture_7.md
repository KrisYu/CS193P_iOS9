##lecture 7

中级のSwift技巧来了.


#### Memory Management

终于肯说出来了 -> heap.

Reference types (classes) are stored in the heap. 其实一般来说应该不用管的吧，因为有ARC.

- strong
- weak
- unowned


#### Closures

stored in heap, a reference type.

Closure 的一个特别大的特点是它可以access local variable，并且可以read write.并且把东西存在heap.


这里形成memory cycle的原因是：


```
addUnaryOperation("🔴√") { [ unowned me = self ] in 
	me.display.textColor = UIColor.redColor()




```



```








本身也是一种类型，closure.


然后这里报的错真是清晰，感觉难得的，少见的Swift清晰报错.
Reference to property 'display' in closure requires explicit 'self.' to make capture semantics explicit

突然明白了这个closure跟之前的closure的不同之处：

- 第一，写在ViewController里面，而并非CalculatorBrain这个类里面
- 第二，它不像别的closure，只是简单的实现比如一般的函数做的事情，它的不同之处也跟其原因有关，写在ViewController里面，因为她要去改变display的颜色
- 第三，也就是这里报的错，那么就是这个display因为本身是ViewController指向的weak，所以要reference要self.
- 至此，memory cycle形成，预估：倘若不用特殊修饰词，calculatorCount会一直增加，传说的memory leakage出现

看run的结果:

```
Loaded up a new Calculator (count = 1)
Loaded up a new Calculator (count = 2)
Loaded up a new Calculator (count = 3)
Loaded up a new Calculator (count = 4)

```

again，重申，哪个菜鸟看到这样的代码不害怕!!

```
 brain.addUnaryOperation("Z"){ [unowned me = self] in
     me.display.textColor = UIColor.redColor()
     return sqrt($0)
 }
```
不过老爷子也讲了，他allow在assignment 3里面有这样的memory loop.

不过真的好可怕，那就是如果有memory leakage出现，leak的是calculator还好，不过如果有video或者image leak....

不过再想一想，是不是只有出现closure才会有memory leakage出现捏.反正对于这种cycle敏感一点吧.

#### Extension

Extension 到处用的状况也不是也没见过.

老师都说be careful with abuse, use them in OOP fashion, use them wisely.

是的，因为我看到很多用extension的方式匪夷所思.


add methods/properties to other classes even if you don't have source code.


	extension UIViewController {



- You can add methods/properties to a class/struct/enum (even if you don’t have the source). 
- You can’t re-implement methods or properties that are already there (only add new ones).
- The properties you add can have no storage associated with them (computed only).
- Best used (at least for beginners) for very small, well-contained helper functions.


#### Protocol

extension a good way to implement protocol.

比如我就看到一个人写UITableViewController，不让它其符合TableViewController的API，而是让之有extension来实现方法，真是好神奇。


Protocol - express API more concisely, 所以感觉很像Java等的interface，需要实现的.



Type：
- classes
- enums
- structs
- functions
- protocols

是一种type.

恐怖之处😱，因为是一种type，所以任何可以用type的，都可以用protocol.


A Protocol is simply a collection of method and property declarations.

遵循protocol，就是实现其所定义的方法，比如UITableViewController的protocol.



Extension 结合 protocol，更让人感到可怕了.

用Protocol的：

1. the protocol declaration (what properties and methods are in the protocol)


Protocol 可以multiple inheritance.










#### Delegation

注意尝试区分这些神奇的东西， protocol， extension， delegation....

看了一下stackoverflow，有非常好的解释关于protocol和delegation的区别.

protocol 已经讲的很清楚了 - 类似interface，This is a great way of avoiding the inheritance design pattern, and avoids tight coupling.

delegate则是我代表你，比如一个ViewController代表一个View来接收改变。

而他们经常被一起提到的原因，包括老爷爷的slides上写的： A very important use of protocols - It’s a way to implement “blind communication” between a View and its Controller

感觉是这样吧:

1. ViewController要代表这个View，是它的delegate
2. 但是我又想知道这个view比如有哪些变化，比如scroll了啥的
3. 所以这个ViewController需要遵循一些方法比如viewdidscroll啥的，这些方法就是protocol里面的方法，这个protocol就是制造出来满足被遵循的需要，被知道，被了解的

还是那个，想想UITableViewController


<http://stackoverflow.com/questions/6361958/delegate-vs-protocol>

<http://stackoverflow.com/questions/5431413/difference-between-protocol-and-delegates>



1. A View declares a delegation protocol (i.e. what the View wants the Controller to do for it) 
2.  The View’s API has a weak delegate property whose type is that delegation protocol



	

注意做的set content Size.

	let image = UIImage(named: “bigimage.jpg”)
	scrollView.contentSize = imageView.bounds.size


简直有进步，这里老师讲完之后我自己就开始做demo了，因为没有预计到这节课还有demo.


可爱不：不过没有用到zoom,待看完老师做的demo再更新.

- navigation Controller
- Scroll to scroll and hide navigation bar
- tap to show navigation bar


![](ScrollView.gif =200x)



#### Demo Cassini

    var imageURL: NSURL?

这一句就是model了,因为系统要求很简单，就是创建一个imageView，然后用image来填。

对于`private var image: UIImage?` 老师也说了，是kill two birds with one stone.

还真是，因为一方面set的时候就把imageView的image给改变了,同时改变imageView的size，老师说这事一个computed var，因为它把自己的变量存在了imageVIew的image里.


    private var image : UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
        }
        
    }
    
    
所以整个过程就是，一旦imageURL被设定，我们就尝试fetchImage，一旦url和imageData有效，那么我们使用`image = UIImage(data: imageData)` 就会导致image的set开始生效，那么就会相应的更改imageView.
 


        imageURL = NSURL(string: DemoURL.Stanford)

URL是classes，所以这里的方法是，这个把string转成NSURL

(http://) 原来是不可以随意调用的啊.
	
	App Transport Security Settings
	App AllowsArbitraryLoads -> YES




scrollView讲解的时候又是故意没有设置size，犯错来提醒大家。

然后非常期待lecture 8.