//
//  Permission.swift
//  Boomerang
//
//  Created by Egor Laba on 28.06.22.
//

import UIKit
import AVFoundation

class Permission {
    
    private let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func checkCameraAvailability() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            requestCameraPermission()
            
        case .restricted, .denied:
            alertCameraAccessNeeded()
            
        case .authorized:
            break
        @unknown default:
            break
        }
    }
    
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(
            for: .video, completionHandler: { accessGranted in
                guard accessGranted == true else { return }
            }
        )
    }
    
    private func alertCameraAccessNeeded() {
        guard let settingsAppURL = URL(string: UIApplication.openSettingsURLString) else { return }
        
        let alert = UIAlertController(
            title: "Need Permission",
            message: "Please enable Photos access from settings in order to use the app.",
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .cancel,
                handler: nil
            )
        )
        alert.addAction(
            UIAlertAction(
                title: "Enable Photos Access",
                style: .default,
                handler: { _ -> Void in
                    UIApplication.shared.open(
                        settingsAppURL,
                        options: [:],
                        completionHandler: nil
                    )
                }
            )
        )
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
