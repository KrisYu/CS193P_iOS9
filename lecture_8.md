##lecture 8 


#### Demo

代码的安全系数非常高，然后有的时候可以不用强制optional unwrap 也可以尝试这个.
	
	return navcon.visibleViewController ?? self


然后代码里面有很多subtle的代码来解决问题，比如 如果view没有在屏幕上就不去fetchImage，因为这个比较耗资源，然后viewWillAppear的时候确定image不是nil的时候再fetch，因为之前看到的ViewWillAppear可能出现多次


- Imgae View Controller
- Top Layout Guide
- Bottom Layout Guide
- View
	- ScrollView
	- Animation Indicator View
	
越在上方的View，越在后方.这个理解，因为View总是在最前面。这个view也就是我们平时任意调用的view，也是self.view的view.



#### Multithreading



asynchronism

n. 不同时, 异步

<https://www.raywenderlich.com/79149/grand-central-dispatch-tutorial-swift-part-1>


名词复习：

- serial vs concurrent
- tasks closure = blocks, 所以读文档，如果看到block就用closure替代
- synchronous vs asynchronous  同步 vs 异步，同步的函数只有运行完成才能return， 而异步函数，会立即return，asychronous function does not block the current thread of execution from proceeding on to the next function. 同步的function只是在block其自己而已.
- critical section
- race condition
- deadlock
- thread safe (为什么let/var也跟thread safe有关?)
- context switch
- concurrency vs parallelism



GCD给提供dispatch queue，这些queue本身是FIFO的，然后这些queue都是thread safe的。
iOS的multithreading是通过queue来完成的，重点是需要把东西放到合适的queue去？

> All dispatch queues are themselves thread-safe in that you can access them from multiple threads simultaneously. The benefits of GCD are apparent when you understand how dispatch queues provide thread-safety to parts of your own code. The key to this is to choose the right kind of dispatch queue and the right dispatching function to submit your work to the queue.


而所谓的concurrent queue是由CGD提供的，由GCD全权负责.

 - main queue, UI update的地方
 - 所有的time-consuming或者可能block的function都不能在mainQ中，要在别的地方
 
 典型写法：
 
 	dispatch_async(not the main queue) {	// do a non-UI that might block or otherwise takes a while	      dispatch_async(dispatch_get_main_queue()) {	// call UI functions with the results of the above	} }Most non-main-queue work will happen on a concurrent queue with a certain quality of service
- QOS_CLASS_USER_INTERACTIVE //quick and high priority- QOS_CLASS_USER_INITIATED // high priority, might take time- QOS_CLASS_UTILITY // long running- QOS_CLASS_BACKGROUND // user not concerned with this (prefetching, etc.)


看老师的例子：

    private func fetchImage(){
        if let url = imageURL {
            spinner?.startAnimating()
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
                let contentsOfURL = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()) {
                    if url == self.imageURL{
                    if let imageData = contentsOfURL {
                        self.image = UIImage(data:  imageData)
                    } else {
                        self.spinner?.stopAnimating()
                    }
                    } else {
                        print("ignored data returned from url \(url)")
                    }
                }
            }
        }
    }选的第二个QOS_CLASS_USER_INITIATED - high priority，might take time的选项,make sense.

瞄了一眼最新的WWDC，GCD也要变，变成OOP的.#### UIText Field
To be read more or watch previous session.


