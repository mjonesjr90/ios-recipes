//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

/**
By default, all top-level code is executed, and then execution is terminated. When working with asynchronous code, enable indefinite execution to allow execution to continue after the end of the playground’s top-level code is reached. This, in turn, gives threads and callbacks time to execute.
 */
PlaygroundPage.current.needsIndefiniteExecution = true

let url = URL(string: "http://malcomjonesjr.com/json/hairtypes-dict.json")
let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
    if( error != nil) {
        print(error!)
    } else {
        if let urlContent = data {
            do {
                
                //jsonResult will be a JSON Object in the form of a dictionary [String: Any] - Any will be an array
                print("DEBUG: pulling down jsonResult")
                let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:[]) as! [String: Any]
                
                //Extract array of Hair Types
                print("DEBUG: creating straightHair")
                
                // pull hair types from json object
                let straightHair = jsonResult["straight"] as! [AnyObject]
                let wavyHair = jsonResult["wavy"] as! [AnyObject]
                let curlyHair = jsonResult["curly"] as! [AnyObject]
                let kinkyHair = jsonResult["kinky"] as! [AnyObject]
                
                // pull dictionaries from arrays
                let straightHairDict = straightHair[0] as! [String: Any]
                let wavyHairDict = wavyHair[0] as! [String: Any]
                let curlyHairDict = curlyHair[0] as! [String: Any]
                let kinkyHairDict = kinkyHair[0] as! [String: Any]

                print("DEBUG: pulling names")
                print(straightHairDict["name"] as! String)
                print(straightHairDict["description"] as! String)
                print(wavyHairDict["name"] as! String)
                print(curlyHairDict["name"] as! String)
                print(kinkyHairDict["name"] as! String)
                
                
                let wavySub = wavyHairDict["subtype"] as! [AnyObject]
                let wavySubA = wavySub[0] as! [String: Any]
                
                print(wavySubA["name"] as! String)
            } catch {
                print("JSON processing failed")
            }
        }
    }
}
task.resume()
