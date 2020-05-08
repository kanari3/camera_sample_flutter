import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    /// main.dartでMethodChannelのコンストラクタで指定した文字列です
    private let methodChannelName = "package.name/sample"
    /// main.dartでinvokeMethodの第一引数に指定したmethodの文字列です
    private let methodTest = "test"

    private var flutterViewController: FlutterViewController {
        return self.window.rootViewController as! FlutterViewController
    }

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        // MethodChannelはAndroidと同様、名前とFlutterViewControllerから生成します
        let methdoChannel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: flutterViewController.binaryMessenger)
        // MethodChannelからのメッセージを受け取ります
        methdoChannel.setMethodCallHandler { [weak self] methodCall, result in
            if methodCall.method == self?.methodTest {
                // invokeMethodの第二引数で指定したパラメータを受け取れます
                let parameters = methodCall.arguments as? String
                self?.launchiOSScreen(parameters)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func launchiOSScreen(_ parameters: String?) {

    }

}

