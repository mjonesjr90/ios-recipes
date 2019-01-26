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
    
    locationManager.startUpdatingLocation()
    //asynch method that works in background
    // sends message to Delegate - the current view controller - needs didUpdateLocations method
    
}

func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //Location is saved in array of CLLocation objects called locations
    let location = locations[locations.count - 1]
    if location.horizontalAccuracy > 0 { // once the location is accurate, stop trying to find it - to save battery
        locationManager.stopUpdatingLocation()
        // you can set locationManager.delegate = nil if you want it to stop recieving location messages
        
        print("lon = \(location.coordinate.longitude), lat = \(location.coordinate.latitude)")
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        let params: [String: String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
    }
}


func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
    // let the user know location is unavailable
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
