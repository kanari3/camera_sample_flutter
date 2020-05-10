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

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let methdoChannel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: controller.binaryMessenger)
        methdoChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // Note: this method is invoked on the UI thread.
            // Handle battery messages.

            if call.method == self.methodTest {
                // invokeMethodの第二引数で指定したパラメータを受け取れます
                let parameters = call.arguments as? String
                self.launchiOSScreen(parameters)
            }


        })

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }


    func launchiOSScreen(_ parameters: String?) {


        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let next = storyboard.instantiateViewController(withIdentifier: "NextScreenViewController") as! NextScreenViewController


//        let next = NextScreenViewController()
        next.delegate = self
        flutterViewController.present(next, animated: true, completion: nil)
    }

}

extension AppDelegate: NextScreenViewControllerDelegate {
    func nextScreenViewControllerSendMessage(_ viewController: NextScreenViewController, message: String) {
       // 任意のオブジェクトを通知できます
       result?(message)
    }
}

class NextScreenViewController: UIViewController {

    var delegate: NextScreenViewControllerDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate?.nextScreenViewControllerSendMessage(self, message: "ほげほげ")

    }


    
}

protocol NextScreenViewControllerDelegate {
    func nextScreenViewControllerSendMessage(_ viewController: NextScreenViewController, message: String)
}

