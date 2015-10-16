
import UIKit

class AddViewController: UIViewController, UIGestureRecognizerDelegate, UITextViewDelegate {
    /* this outlet links connects to the thin blue progress bar running across the screen under the navigation bar */
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var textView: UITextView!
    /* this outlet links to the constraint that controls the space between the bottom of the text view and its parent */
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    /* this outlet links to the UIGestureRecogniser. This can be seen as the small blue icon at the top of the view controller. */
    @IBOutlet var swipeDown: UISwipeGestureRecognizer!
    
    /* a value representing the maximum number of characters allowed in the note. */
    private let maxChars = 140
    
    /* this action is triggered by the **close** button in the navigation bar. It grabs the text from the text view, gets an instance of the Notes model and calls the addNote method. */
    @IBAction func closeView(sender: UIBarButtonItem) {
        if let content:String = self.textView.text {
            Notes.getInstance.addNote(withContent: content)
            print("note added")
        }
        /* finally we dismiss the current view, taking us back to the list. */
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /* this action was created by ctrl-dragging from the gesture recogniser to this controller. */
    @IBAction func swipe(sender: UISwipeGestureRecognizer) {
        print("swipe")
        /* the first responder is the control that currently has focus. calling resignFirstResponder() removes the focus from the textview which will hide the keyboard. */
        self.textView.resignFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear:    AddViewController")
    }
    override func viewDidAppear(animated: Bool) {
        print("viewDidAppear:     AddViewController")
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisappear: AddViewController")
    }
    
    override func viewDidDisappear(animated: Bool) {
        print("viewDidDisappear:  AddViewController")
    }
    
    override func viewDidLoad() {
        print("viewDidLoad:       AddViewController")
        super.viewDidLoad()
        /* here we add an observer to trigger when the keyboard appears */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        /* and a second observer to be triggered when the keyboard hides. */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
        /* we add our gesture recogniser (via its outlet) to the view. This means the gesture will work anywhere in the view. */
        self.view.addGestureRecognizer(self.swipeDown)
        /* Since this class implements the **UITextViewDelegate** protocol it can act as the delegate for the textView */
        self.textView.delegate = self
        /* interactive mode means the gesture up/down controls the keyboard position. */
        self.textView.keyboardDismissMode = .Interactive
        /* finally we reset the blue bar in the progress view to 0. */
        self.progressView.setProgress(0.0, animated: true)
    }
    /* This is one of the **UITextView** delegate methods. It gets triggered every time the contents of the textView changes. */
    func textViewDidChange(textView: UITextView) {
        print("textViewDidChange")
        /* We need to calculate the position of the blue progress bar based in the current number of characters entered in the textView and the maximum allowed. The result must be a floating point number between 0 and 1. */
        if let progress:Float = Float(self.textView.text.characters.count)/Float(self.maxChars) {
            /* we use this calculated value to change the length of the blue bar. */
            self.progressView.setProgress(progress, animated: true)
        }
    }
    
    /* this function is triggered by the observer we set up in viewDidLoad */
    func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        /* Each view displayed on screen is contained within a bounding frame. Here we get the size of the frame around the keyboard. A CGRect is a struct containing the position (x and y) plus the width and height of the frame. */
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            //print(keyboardSize)
            /* we are only interested in the height of the frame. We change the bottom textView constraint to this value which reduces the size of the textView to prevent it from being hidden behind the keyboard. */
            self.bottomConstraint.constant = keyboardSize.height
        }
    }
    
    /* this function is triggered by the second observer created in viewDidLoad */
    func keyboardWillHide(notification: NSNotification) {
        print("keyboardWillHide")
        /* we change the bottom textView constraint to its original value. */
        self.bottomConstraint.constant = 20
    }
    
    /*  */
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

