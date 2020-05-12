//
//  AndpadCameraViewController.swift
//  Runner
//
//  Created by admin on 2020/05/11.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import UIKit
//import andpad_camera
import Photos

class AndpadCameraViewController: UIViewController {

//    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

//    var blackboard: BlackBoard = BlackBoard(constractionName: "Example Name",
//                                            constractionPlace: "Example Place",
//                                            constractionPlayer: "Example Player",
//                                            memo: "Example Memo",
//                                            constractionCategory: "Example Category",
//                                            constractionState: "EXample State",
//                                            constractionPhotoClass: "Example Photo Class",
//                                            photoTitle: "Example Photo Title",
//                                            detail: "Example Detail",
//                                            inspectionReportTitle: "Example Inspection Report Title",
//                                            inspectionItem: "Example Inspection Item",
//                                            inspectionTitle: "Example Inspection Title",
//                                            inspectionPoint: "Example Inspection Point",
//                                            inspector: "Example Inspector",
//                                            client: "Example Client",
//                                            type: BlackBoardType.case0)
//
//    @IBAction func openCamera(_ sender: Any) {
//        let camera =
//            TakeCameraViewController.makeNavigationInstance(
//                data: blackboard,
//                blackBoardFlg: true,
//                allowMultiplePhotos: true,
//                inspectionTemplateEnabled: true,
//                cancelHandler: { [weak self] vc in },
//                completedHandler: { [weak self] vc, photos in
//                    if let asset = photos.last?.asset {
//                        let manager = PHImageManager.default()
//                        let targetSize = self?.imageView.frame.size ?? CGSize(width: 0, height: 0)
//                        manager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: nil,
//                            resultHandler: { [weak self] (image, info) in
//                            self?.imageView.image = image
//                        })
//                    }
//
//                    if let cvc = vc as? TakeCameraViewController {
//                        self?.blackboard = cvc.viewModel.toModel()
//                    }
//                }
//            )
//        self.present(camera, animated: true, completion: nil)
//    }


}

