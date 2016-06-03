##lecture 6

大部分的APP都是Mutliple MVC吧.

#### Segues

- show (stack of cards,像settings)
- show detail
- modal（take over the entire screen while mvc is up ）
- popover

之前有点迷茫关于 show 和 modal，我觉得还是需要查一下，确定一下，虽然这里写的很清楚，但是我感觉之前都是在乱用的。


老师的🌰给的是show.



 
比如其实tableview应该用哪个？然后是该用master-detail view.


**Segues always create a new instance of an MVC,This is important to understand.**

↑
有待理解。


从code呼唤segue，sender是导致这个segue发生的sender，比如button.
code的话就是可以用任何object.

	func performSegueWithIdentifier(identifier: String, sender: AnyObject?)
	

不过要呼唤一个segue出来，一件重要的事是要把即将呼唤出来的segue准备好，所以还有方法：

	func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	
这两个sender都是一样，都是cause segue happen的button.

	
每个MVC都有其小世界，用public API来交流，所以MVC之间的数据传递就是难事么？


	  func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {	      if let identifier = segue.identifier {	          switch identifier {	              case “Show Graph”:	                  if let vc = segue.destinationViewController as? GraphController {	                      vc.property1 = ...	                      vc.callMethodToSetItUp(...)	 }	            default: break	        }	} }**It is crucial to understand that this preparation is happening BEFORE outlets get set!**
所以就是其实应该access API 和 property，通过他们来设定outlet，而不是直接prepare的时候来处理outlet.
#### Demo
##### TabBar Controller
##### Split View Controller

故意crash了一次，天啊 -> 学debug还是很有必要的。

一开始我还是很迷茫的，因为这个地方是property，为嘛为nil,但是注意这个property每次set的时候就要updateUI，updateUI就调用faceView，问题就出在这里。因为faceView作为outlet，这个时候还没有完全生成好.

其实左侧的console还是很有用的。


这个会有用是因为outlet和property set的时候都会updateUI.


SplitView 在 iPhone在不会自动split，所以这个时候考虑使用Navigation Controller.


##### Navigation Controller

Navigation Controller 是放在Stack的最底层. 所以其实比如Setting这个App，也只有一个Navigation Controller么？就放在最底层?


如此神奇，就好了.是因为这个 Navigation Controller到faceView segue依旧存在么.


老爷爷的说法： SplitView + Navigation Controller 简直就是标准配置，因为很多时候都是希望是一个universal App.




#### View Controller LifeCycle


- Preparation if being segued to.
- Outlet setting.
- Appearing and disappearing. 比如split View 
- Geometry changes.  (Rotation)
- Low-memory situations. 


```	
override func viewDidLoad() {	super.viewDidLoad() // always let super have a chance in lifecycle methods 
	// do some setup of my MVC}
```
But be careful because the geometry of your view (its bounds) is not set yet!
Just before your view appears on screen, you get notified
	func viewWillAppear(animated: Bool) // animated is whether you are appearing over time放expensive的东西，比如multi-threading.
Your view’s geometry is set here, but there are other places to react to geometry.



	func viewDidAppear(animated: Bool)
Animation
以前我都是把一切写在 viewDidLoad中的，直到一天，写一个UIPageView玩，scroll的时候不太对。
所以最终发现了这个lifecycle原来有这么多方法.