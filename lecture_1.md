##lecture 1

话说Xcode，Swift, iOS 有时候的报错还真是蜜汁尴尬，有时候非常informative，有时候报错完全看不懂啊。


比如如果不初始化某变量报的错。

`Class 'ViewController' has no initializers` , 能想明白是其实其中一个变量没有给初始值么,所以这也是为嘛正常的Swift代码中到处可见？，因为nil很特殊，不给值也棒棒的.


首先对于touchDigit这个函数，因为digit是一定有值的，所以unwrap合理.

学到了一个有关label的小技巧，自动调大小。