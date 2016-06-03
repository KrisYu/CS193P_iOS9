##lecture 5


#### @IBDesignable , @IBInspectable

- 利用 @IBDesignable 把 drawRect 显示在 View 上面
- 利用 @IBInspectable 让 这些可以设置的可爱的东西显示在Interface Builder中.


#### Redraw

利用 didSet 来redraw

```
    var scale : CGFloat = 0.90 { didSet { setNeedsDisplay() } }

```
这里是一旦这个参数改变，然后就需要重新调用drawRect，但是之前已经讲过，从来不直接调用，而是使用setNeedsDisplay()，所以就是一旦这个参数被更改，didSet，然后就setNeedsDisplay了.

####FacialExpression

这个是Model, Controller是用来interpret model给view的，比如这里的model里面虽然也有eyes，eyebrows，mouth，但是明显她就代表的是当前的状态，实际上是需要view待会画出来的，而controller就是作为这个媒介，告诉view要怎么画.

同时controller晚一点也会interpret in puts the view for the model，比如之后会讲到的gesture。

这一整个FacialExpression是struct，所以eyes，mouth，eyeBrows可以没有初始值，简直了。



Struct有三个变量，变量都是enum格式，而enum还有自己的函数.


#### Controller

现在controller要开始做的事就是把facialexpression变成它所代表的view.

    var expression = FacialExpression(eyes:.Open, eyeBrows: .Normal, mouth: .Smile) {
        didSet{
            updateUI()
        }
    }
    
 这里老师讲了要感谢是struct （value type），否则如果是class，可能就无法调动updateUI? 
 
didSet


#### Update UI

Update UI 当value changes 和 当view hook up之时：

	@IBOutlet weak var faceView: FaceView! {
        didSet {
            updateUI()
        }
    }
    
这里要体会一下，感觉问题是出在，我们的view生成的时候，faceView就已经生成了，只有当其生成之后，expression的didSet才起作用.


#### Gestures

1. Adding a gesture recognizer to a UIView (asking the UIView to “recognize” that gesture)2. Providing a method to “handle” that gesture (not necessarily handled by the UIView)

我之前看到的的Gesture Recognizer都是直接拖拽加到View之上，然后再跟某方法联系起来。

	
```	
@IBOutlet weak var pannableView: UIView {      didSet {          let recognizer = UIPanGestureRecognizer(              target: self, action: #selector(ViewController.pan(_:)))          pannableView.addGestureRecognizer(recognizer)      }}
```
#### Demo
###### pinch
这里有劲的是添加gesture的方法不同于我之前见到的：
 - 在didSet添加gesture
 - 还比较有劲的是这里的gesture只会涉及到View的变化，所以干脆就把changeScale这个事情放到faceView，让这个View本身来控制自己的变化
 因为是跟model无关的.
##### swipe
Swipe是改变这个model开心程度的，相关的变量是model里面的，所以这个target就是self，然后用的action也是这个ViewController class里面的method.
controller 来 handle gesture recognizer， 然后modify model，model被modify之后，来update UI，从而导致UI的变化.
整个过程就是这样：
View来读取Gesture -> Controller来handle -> 改变Model -> Mode通过didSet来updateUI -> 改变View.


##### tap

终于用了我常见的方法。

drag放上去其实就是addGestureRecognizer，然后再link到@IBAction上.



#### MUltiple MVCs

MVC -> Views are other MVCs.

iOS provides some Controllers whose View is “other MVCs” :
- UITabBarController  : Unrelated MVC
- UISplitViewController  : Master / Detail
- UINavigationController : Stack of Cards


神奇的

You can get the sub-MVCs via the viewControllers property

var viewControllers: [UIViewController]? { get set }
 
- // can be optional (e.g. for tab bar)
- // for a tab bar, they are in order, left to right, in the array- // for a split view, [0] is the master and [1] is the detail- // for a navigation controller, [0] is the root and the rest are in order on the stack- // even though this is settable, usually setting happens via storyboard, segues, or other- // for example, navigation controller’s push and pop methods等待Demo，表示略迷茫，所以又给我了问题，正确的UITableView的segue方式应该是怎样.
