import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    let methodChannelName = "package.name/sample"
    let methodTest = "test"

    var globalResult: FlutterResult?

    var flutterViewController: FlutterViewController {
        return self.window.rootViewController as! FlutterViewController
    }

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let methdoChannel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: controller.binaryMessenger)

        methdoChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

            if call.method == "test" {
                // invokeMethodの第二引数で指定したパラメータを受け取れる
                let parameters = call.arguments as? String
                self?.launchiOSScreen(parameters)

                self?.globalResult = result
//                result("appdelegateからはok、ここでresult返すと終わっちゃう")
            } else {
                result(FlutterError(code: "ErrorCode", message: "ErrorMessage",details: nil))
            }

        })

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }


    func launchiOSScreen(_ parameters: String?) {

        print("dartからiosへのmessage")
        print(parameters!)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let next = storyboard.instantiateViewController(withIdentifier: "NextScreenViewController") as! NextScreenViewController
        next.delegate = self
        flutterViewController.present(next, animated: true, completion: nil)
    }

}

extension AppDelegate: NextScreenViewControllerDelegate {
    func nextScreenViewControllerSendMessage(_ viewController: NextScreenViewController, message: String) {
       // 任意のオブジェクトを通知できます
        print("iosから通知する")

        if let r = globalResult {
            print("ok")
            r("ぐろーばる: \(message)")
        }else{
            print("だめっぽい")
        }

    }
}

class NextScreenViewController: UIViewController {

    var delegate: NextScreenViewControllerDelegate? = nil

    @IBAction func buttonAction(_ sender: Any) {

        delegate?.nextScreenViewControllerSendMessage(self, message: "ぼたんおした")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ねくすと表示")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            self.delegate?.nextScreenViewControllerSendMessage(self, message: "didloadだと実行されないので注意")
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.nextScreenViewControllerSendMessage(self, message: "とじた")
    }
}

protocol NextScreenViewControllerDelegate {
    func nextScreenViewControllerSendMessage(_ viewController: NextScreenViewController, message: String)
}

