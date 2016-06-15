##lecture 8 


#### Demo

代码的安全系数非常高，然后有的时候可以不用强制optional unwrap 也可以尝试这个.
	
	return navcon.visibleViewController ?? self


然后代码里面有很多subtle的代码来解决问题，比如 如果view没有在屏幕上就不去fetchImage，因为这个比较好资源，然后viewWillAppear的时候确定image不是nil的时候再fetch，因为之前看到的ViewWillAppear可能出现多次


- Imgae View Controller
- Top Layout Guide
- Bottom Layout Guide
- View
	- ScrollView
	- Animation Indicator View
	
越在上方的View，越在后方.



#### Multithreading

asynchronism

n. 不同时, 异步


iOS的multithreading是通过queue来完成的，重点是需要把东西放到合适的queue去？

老师给的URL的例子感觉就是还是利用系统给的queue，然后采用如下的写法来更新UI，想起了关于pedometer如何读取系统API的queue.


其实什么时候可以多读再重写？
	//All UI stuff must be done on this queue!	//And all time-consuming (or, worse, potentially blocking) stuff must be done off this queue! Common code to write ...	dispatch_async(not the main queue) {	// do a non-UI that might block or otherwise takes a while	      dispatch_async(dispatch_get_main_queue()) {	// call UI functions with the results of the above	} }#### UIText Field
反复强调要读，读书，读Swift.
的确，又出现我不了解的keyword，的确需要读一读Programming Guide了.
