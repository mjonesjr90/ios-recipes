import UIKit
import Alamofire
import SwiftyJSON

let baseAPIURL = " ... "
//make constants or dictionaries to hold possible parameters for the API call
var finalAPIURL = " " //This gets created

//Networking
func getData(url: String) {
    
    Alamofire.request(url, method: .get)
        .responseJSON { response in
            if response.result.isSuccess {
                
                print("Sucess! Got data")
                let dataJSON : JSON = JSON(response.result.value!)
                
                self.updateData(json: dataJSON)
                
            } else {
                print("Error: \(String(describing: response.result.error))")
//                self.bitcoinPriceLabel.text = "Connection Issues"
                // Alert user to issue
            }
    }
    
}

//JSON Parsing
func updateData(json : JSON) {
    
    if let result = json["outerobject"]["inner"].double {
//        bitcoinPriceLabel.text = currenySymbols[currencyPicker.selectedRow(inComponent: 0)] + " " + String(priceResult)
        //do something with the result
    }
    else {
//        bitcoinPriceLabel.text = "Data Unavailable"
        //alert the user to issue
    }
    
}
