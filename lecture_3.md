##lecture 3

#### Optional

Optional is an enum,这个之前已经讲过了：


```
enum Optional<T>{
	case None
	case Some(T)
} 
```

	let x: String? = ....
	if let y = x：
		如果unwrap成功，就用那个值
		unwrap失败，则break
		
		
新鲜点的有 ：
 
Optional can be "chained",两个optional连接起来unwrap:

```
if let x = display?.text?.hashValue {...}
```

??提供default value, 如果s是nil，default value 为 " "

```
let s : String? = ...

if s != nil {
	display.text = s
} else {
	display.text = " "
}

//用一句话

display.text = s ?? " "

```

#### Tuple

跟一般的tuple类似，只是命名的时候可以给tuple里面的每个变量一个名字。

之所以介绍tuple是因为这样function可以return多个值。

#### Range

two end points

```
struct Range<T>{
	var startIndex ; T
	var endIndex : T
}
```
一个Array的range是 Range<Int>， String的subrange则是Range<String.Index>...



```

let array = ["a","b","c","d"]
let subArray1 = array[2...3] // ["c","d"]
let subArray2 = array[2..<3] //["c"]

for i in 27...104 { }

```

#### Data  Structures

- 定义类似
- 可以properties & functions
- Initializers（not enum）

```
class CalculatorBrain {
}

struct Vertex { 
}

enum Op {
}
```

区别：

- 继承（class）
- value type（struct， enum） vs reference type(class)

mutate func 这样才可以改变 struct/ enum

基本一般class prefer than struct，因为是OOP。Struct用于更基础的type，比如string, double ,int ,arrays, dictionarys , 同样还用于drawing， points, rectangles.

#### methods

首先，我觉得不太理解的是，为什么要有external name 和 internal name，存疑？

- override
- final subclass没法override
- types/instances 可以有methods/properties 

For this example, lets consider using the struct Double (yes, Double is a struct)  
```  var d: Double = ...  if d.isSignMinus {      d = Double.abs(d)}
```isSignMinus is an instance property of a Double (you send it to a particular Double)
abs is a type method of Double (you send it to the type itself, not to a particular Double)
You declare a type method or property with a static prefix ...
static func abs(d: Double) -> Double
这里其实跟Java的Character Class有点类似,Math.abs(-3)

#### properties

Property Observers 是非常神奇的存在.

willSet 和 didSet 用来update UI


#### Lazy Initalization

someProperty 不会被初始化直到被使用。


一节课的内容也太充实了吧，简直感人。


#### Array

	var a = [String]()

几个有意思的method:
	
	filter
	let bigNumbers = [2,47,118,5,9].filter({$0 > 20}) // bigNumbers = [47,118]
	
	map
	let stringified: [String] = [1,2,3].map {String($0)}
	
	reduce
	let sum: Int = [1,2,3].reduce(0){ $0 + $1 }


#### Dictionary

	var pac10teamRankings = [String:Int]()
	
	for (key, value) in pac10teamRankings {
		print("\(key) = \(value)")
	}


#### String 

	var characters: String.CharacterView { get }
	

Methods熟悉起来是为了用

```
	startIndex -> String.Index	endIndex -> String.Index	hasPrefix(String) -> Bool	hasSuffix(String) -> Bool	capitalizedString -> String	lowercaseString -> String	uppercaseString -> String	componentsSeparatedByString(String) -> [String] // “1,2,3”.csbs(“,”) = [“1”,”2”,”3”]
```


#### NSObject

OC用
用的时候讲

#### NSNumber

	let n = NSNumber(35.5)
	let intversion: Int  = n.intValue

#### NSDate

必熟

#### NSData

a bag of bits


#### Initialization

init是有免费的，但是一旦自己提供init，则免费的init就没有了.

听起来好复杂的样子，晕了要

#### AnyObject 

貌似OC id的Swift版本，然后好处是当不知道是啥的时候拿来用，然后用as转化成我们想要的格式.


#### Property List

大杂炖，大混杂

#### NSUserDefaults

small database

用来存plist，就是一些简单的用户设置

	
	 let defaults = NSUserDefaults.standardUserDefaults()
	 	  let plist = defaults.objectForKey(“foo”)	  defaults.setObject(plist, forKey: “foo”)



#### Cast

Type Cast，还算常见 Int啥的


更常见的Cast比如Cast ViewController 

#### Assertion






	
