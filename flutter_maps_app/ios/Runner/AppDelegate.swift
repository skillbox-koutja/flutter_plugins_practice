import UIKit
import Flutter
import YandexMapsMobile

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if let YMKMapKitApiKey = ApiKeysManager().getValue(key: "yandex.map.apiKey") as? String {
            YMKMapKit.setApiKey(YMKMapKitApiKey)
        }
        YMKMapKit.setLocale("ru_RU")

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
