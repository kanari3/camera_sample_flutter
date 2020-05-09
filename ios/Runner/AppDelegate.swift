import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {


    /// main.dartでMethodChannelのコンストラクタで指定した文字列です
    private let methodChannelName = "package.name/sample"
    /// main.dartでinvokeMethodの第一引数に指定したmethodの文字列です
    private let methodTest = "test"

    // MethodChnnelの結果通知に使います
    private var result: FlutterResult?

    private var flutterViewController: FlutterViewController {
        return self.window.rootViewController as! FlutterViewController
    }

    override func application(
        _
        application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?

    ) -> Bool {


        GeneratedPluginRegistrant.register(with: self)

        // MethodChannelはAndroidと同様、名前とFlutterViewControllerから生成します
        let methdoChannel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: flutterViewController)
        // MethodChannelからのメッセージを受け取ります
        methdoChannel.setMethodCallHandler { [weak self] methodCall, result in
            if methodChannel.method == methodTest {
                // invokeMethodの第二引数で指定したパラメータを受け取れます
                let parameters = methodCall.arguments as? String
                self?.launchIOSScreen(parameters)
            } else {
                // 任意のオブジェクトを返却できます。ここでは明示的にFlutterErrorというオブジェクトを返却しています
                result?(FlutterError(code: "ErrorCode", message: "ErrorMessage",details: nil))
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func launchIOSScreen(_ parameters: String?) {
        let next: NextScreenViewController = NextScreenViewController()
        next.delegate = self
        flutterViewController.present(next, animated: true, completion: nil)
    }





}

class NextScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
