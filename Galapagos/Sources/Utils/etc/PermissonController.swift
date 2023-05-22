//
//  PermissonController.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//
import Foundation
import Photos
import UIKit
import UserNotifications



/// 한번 허용하거나 거부한 '권한'은 디바이스 자체에 내장되기 때문에,
/// 앱을 삭제했다가 다시 깔아도 계속 이전의 권한이 유지됨

final class PrivacyPermission {
    
    static let shared = PrivacyPermission()
    
    enum PermissionType {
        case gallery, notification, camera, none
    }
    
    
    enum PermissionState{
        case authorized, denied, notDetermined
    }
    
    init() {
    }
    
    /// 최초에 권한을 가져올 때
    func requestPermission(for permissionType: PermissionType, completion: @escaping (Bool) -> Void) {
        switch permissionType {
        case .gallery:
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized, .limited:
                    completion(true)
                case .denied:
                    completion(false)
                case .restricted, .notDetermined:
                    break
                @unknown default:
                    break
                }
            }
        case .camera:
            AVCaptureDevice.requestAccess(for: .video){ granted in
                if granted {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        case .notification:
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    completion(false)
                    return
                }
                if granted {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        default:
            completion(false)
            break
        }
    }
    
    
    /// 이후에 접근 시 권한을 확인 할 때
    func checkPermission(for permissionType: PermissionType, viewController: UIViewController, _ completion: @escaping (Bool, PermissionState)->()) {
        switch permissionType {
        case .camera:
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized{
                completion(true, .authorized)
            }else if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .denied{
                completion(false, .denied)
            }else if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .notDetermined{
                completion(false, .notDetermined)
            }
        case .gallery:
            switch PHPhotoLibrary.authorizationStatus() {
            case .authorized, .limited:
                completion(true, .authorized)
            case .denied:
                completion(false, .denied)
            case .notDetermined:
                completion(false, .notDetermined)
            case .restricted:
                break
            @unknown default:
                break
            }
        case .notification:
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                switch settings.authorizationStatus {
                case .authorized, .provisional:
                    completion(true, .authorized)
                case .denied:
                    completion(false, .denied)
                case .notDetermined:
                    completion(false, .notDetermined)
                case .ephemeral:
                    break
                @unknown default:
                    break
                }
            }
        default:
            break
        }
    }
    
    /// 권한을 허용하기 위해 setting 접근
    func goSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
}
