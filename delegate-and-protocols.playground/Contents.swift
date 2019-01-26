//Original ViewController
//Conform to the Delegate(protocol)
class ClassName: UIViewController, NameOfDelegate {
    //Implement required class
    func delegateMethod(param: String) {
        // do something
    }
    
    // ... do other stuff
    
    //Set the delegate for the destination to be this ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueIdentifier" {
            let destinationVC = segue.destination as! DestinationViewController
            destinationVC.delegate = self
        }
    }
    
}

//Destination ViewController

//Create  Delegate Protocol
protocol NameOfDelegate {
    func delegateMethod(param: String)
}

//Create a delegate property
var delegate: NameOfDelegate? //add ? as it may be nil

//Pass data back by calling delegate method
@IBAction func functionName(_ sender: AnyObject) {

    let data = textField.text!
    
    //2 If delegate exists, call the method with data
    delegate?.delegateMethod(param: data)
    
    //dismiss the DestinationViewController
    self.dismiss(animated: true, completion: nil)
    
}
