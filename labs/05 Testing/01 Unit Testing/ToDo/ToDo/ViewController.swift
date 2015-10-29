
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

