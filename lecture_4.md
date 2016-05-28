##lecture 4

####View 

UIWindow -> 除非有external screen，否则就一直就只有一个UIView，感觉只要是用Storyboard的就不用管这些。



	addSubview(aView: UIView) // sent to aView's superview
	removeFromSuperView //sent to the view you want to remove
	

#### CG
CGFloat draw的时候用，CG（core graphics）Float

CGPoint   x，y

CGSize    width, height

CGRect    相对的methods要多一些

#### Coordinate System 

Coordinate System : 跟一般的Coordinate System差不多，画的时候用Point，而不是pixel，感觉是pixel independent的变体.

contentScaleFactor -> how many pixels per point

bounds : CGRect
  

center : 同样是superview

frame : superview's coordinate system 

感觉这两个方法还是非常make sense的，因为确定其在其superview中的位置，再用bounds.


frame 和 bounds不同之处还有比如rotate 一个view具有的bounds和frame 就不一样


####Create View via code:

	let newView = UIView(frame: myViewFrame)
	let newView = UIView()
	

用代码的方法来创建一个UILabel

	let labelRect = CGRect(x:20, y:20, width: 100, height:  50)
	let label = UILabel(frame:labelRect)
	label.text = "Hello"
	view.addSubview(label)

	

#### Draw

	override func drawRect(regionThatNeedsToBeDrawn: CGRect)
	
never call drawRect！ 

call

	setNeedsDisplay()
	setNeedsDisplayInRect(regionThatNeedsToBeDrawn: CGRect)


画一个三角形的典型code

	let path = UIBezierPath()
	
	path.moveToPoint(CGPoint(x: 80,y: 50))
	path.addLineToPoint(CGPoint(x: 140,y: 150))
	path.addLineToPoint(CGPoint(x: 10,y: 150))
	
	path.closePath()
	
	UIColor.greenColor().setFill()
	UIColor.redColor().setStroke()
	path.lineWidth = 3.0
	path.fill()
	path.stroke()

别的方法

	let roundRect = UIBezierPath(roundedRect: aCGRect, cornerRadius: aCGFloat) 
	let oval = UIBezierPath(ovalInRect: aCGRect)
	
addClip()
For example, you could clip to a rounded rect to enforce the edges of a playing card

待读，比如做cards游戏


Hit detection
func containsPoint(CGPoint) -> Bool // returns whether the point is inside the path 
The path must be closed. The winding rule can be set with usesEvenOddFillRule property.
#### UIColor
You can also create them from RGB, HSB or even a pattern (using UIImage)
用pattern，听起来好🐂的样子。
greenColor() 是type method，用它来取得instance，所以colorWith...就是instance method.


#### 透明度
	let transparentYellow = UIColor.yellowColor().colorWithAlphaComponent(0.5) 	var opaque = false	//Alpha is between 0.0 (fully transparent) and 1.0 (fully opaque)
	整个view都可以是transparent的.

不过transparency比较昂贵，使用可注意
fade out/ fade in 用alpha
var hidden : Bool
当点击某个button的时候
#### Draw Text
	let text = NSAttributedString(“hello”)	text.drawAtPoint(aCGPoint)	let textSize: CGSize = text.size注意是upper left开始.
NSAttributedString 感觉老是都有点不知道如何待ta.
#### Font

user内容-> 选preferredFont 
	class func preferredFontForTextStyle(UIFontTextStyle) -> UIFont
	UIFontTextStyle.Headline  	UIFontTextStyle.Body 	UIFontTextStyle.Footnote
 	
#### Draw Image
这个就是UIImageView的使用.
	let image: UIImage = ...	image.drawAtPoint(aCGPoint) // the upper left corner of the image put at 	aCGPoint image.drawInRect(aCGRect) // scales the image to fit aCGRect 	image.drawAsPatternInRect(aCGRect) // tiles the image into aCGRect

可以试试patten

#### Redraw on bounds change


#### Demo

在demo过程有很有意思的做法，就是在init阶段尝试调用自己的bounds失败，是因为这个时候这个UIView自身并没有初始化完成，所以调用bounds会报错，UIView doesn't have instance variable bounds，所以这个时候的做法是把这个skullRadius改成computed property，而是是read only的，只有return.


  
  