##lecture 9

#### Table View

其实对于UITableView之前已经了解了一些，许多教iOS的教程感觉都是从UITableView开始的。不过感觉Table View可能要被CollectionView取代了？


- DataSource 数据源
- Delegate 更多是展示和控制tableview的


然后对于UITableViewController也是小争议，因为之前看的很多人不建议用因为总的来说，它可能限制太多，现在流行的App，比如Airbnb，就明显是TabarView + TableView 来组合的.

一切取决想做怎样的App.


值得mark的地方有：

prepareForSegue


	func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {	      if let identifier = segue.identifier {	          switch identifier {	          case “XyzSegue”: // handle XyzSegue here	          case “AbcSegue”:	              if let cell = sender as? MyTableViewCell,	                 let indexPath = tableView.indexPathForCell(cell),	                 let seguedToMVC = segue.destinationViewController as? MyVC {	                     seguedToMVC.publicAPI = data[indexPath.section][indexPath.row]	              }	          default: break	} }	}This is sort of like “table view target/action” (only needed if you’re not segueing, of course) 
Example: if the master in a split view wants to update the detail without segueing to a new one 
	func tableView(sender: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {	// go do something based on information about my Model	// corresponding to indexPath.row in indexPath.section	// maybe directly update the Detail if I’m the Master in a split view?	}#### Demo
一旦有ViewController，就先想其model是怎么回事.
见识到了array of array of tweets， 如Java 一样， array of array of string.
model这里用了didSet，就是一旦更改model里的数据，就reloadData，这个蛮好，就是只在didSet此处更改.
Workspace 

异步：

- memory cycle
- take time， things may not be the same

	

hugging priority ?