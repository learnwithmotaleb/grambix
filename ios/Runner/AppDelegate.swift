import UIKit
import Flutter
import RevenueCat
import StoreKit

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?
  ) -> Bool {

    // 🚀 RevenueCat Initialization (iOS Public API Key)
    Purchases.configure(withAPIKey: "appl_ILLaDoanqUTpIrVJxLoVOPjhXkt")

    // 🔄 Flutter Plugins Registration
    GeneratedPluginRegistrant.register(with: self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
