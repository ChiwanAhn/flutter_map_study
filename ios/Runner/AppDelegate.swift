import UIKit
import Flutter
import GoogleMaps
import Foundation


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    func getValue(forKey key :String) ->String? {
        return Bundle.main.infoDictionary?[key] as? String
    }
    
    let googleMapsApiKey = getValue(forKey:"Google maps api key") ?? ""

    GMSServices.provideAPIKey(googleMapsApiKey)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
