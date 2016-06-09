###Search

##### UISearchController


Interface Builder暂时不支持，只能从代码创建，如同一般的View Controller一样，主要的还是让支持的View Controller符合这个 UISearchController 的protocol.


<https://www.raywenderlich.com/113772/uisearchcontroller-tutorial>


这篇raywenderlich的文章是用extension的方式来实现search的，说实话，我也比较疑惑Swift到处用extension，而可以不来遵循protocol.是否这样更好这个还有待考究.



<http://stackoverflow.com/questions/29664315/how-to-implement-uisearchcontroller-in-uitableview-swift>


还有这里我用的一个Struct来定义movie，而非class.模仿他人，也算取巧.



##### UISearchBar
谷歌了一下关于 UISearchController 和 UISearchBar ：

在iOS 8.0以上版本中, 我们可以使用UISearchController来非常方便地在UITableView中添加搜索框. 而在之前版本中, 我们还是必须使用UISearchBar + UISearchDisplayController的组合方式.