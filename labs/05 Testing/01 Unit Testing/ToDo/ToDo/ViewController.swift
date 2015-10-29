
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.testModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }

    func testModel() {
        
        let newList = Todo()

        newList.addItem("Cheese")
        newList.addItem("Milk")
 
        do {
            let item = try newList.getItem(atIndex: 0)
            print(item)
        } catch TodoError.indexOutOfRange {
            print("index was out of range")
        } catch {
            //
        }
    }

}

