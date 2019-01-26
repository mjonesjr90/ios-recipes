import UIKit
import CoreLocation


// add CLLocationManagerDelegate to class

// Instance varaibles
let locationManager = CLLocationManager()

override func viewDidLoad() {
    //super.viewDidLoad()
    
    
    //TODO:Set up the location manager here.
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    // determine accuracy, but note the more accurate, the more battery hungry
    
    //Ask for permission
    locationManager.requestWhenInUseAuthorization()
    
}


//In Info.plist add the following
//<key>NSLocationWhenInUseUsageDescription</key>
//<string>We need your location to determine current weather conditions</string>
//<key>NSLocationUsageDescription</key>
//<string>We need your location to determine current weather conditions</string>
//<key>NSAppTransportSecurity</key>
//<dict>
//    <key>NSExceptionDomains</key>
//    <dict>
//        <key>openweathermap.org</key>
//        <dict>
//            <key>NSIncludesSubdomains</key>
//            <true/>
//            <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
//            <true/>
//        </dict>
//    </dict>
//</dict>
