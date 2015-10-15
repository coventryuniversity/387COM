
import UIKit

class AddViewController: UIViewController, UIGestureRecognizerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var swipeDown: UISwipeGestureRecognizer!
    
    @IBAction func closeView(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {() -> Void in
            print("closeView")
            if let content:String = self.textView.text {
                Notes.getInstance.addNote(withContent: content)
                print("note added")
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
        self.view.addGestureRecognizer(self.swipeDown)
        self.textView.delegate = self
        self.textView.keyboardDismissMode = .Interactive
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            print(keyboardSize)
            self.bottomConstraint.constant = keyboardSize.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        print("keyboardWillHide")
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            print(keyboardSize)
            self.bottomConstraint.constant = 20
        }
    }
    
    @IBAction func swipe(sender: UISwipeGestureRecognizer) {
        print("swipe")
        self.textView.resignFirstResponder()
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

