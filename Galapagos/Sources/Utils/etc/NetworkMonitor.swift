//
//  NetworkMonitor.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//
import Foundation
import UIKit
import Network

final class NetworkMonitor{
    static let shared = NetworkMonitor()
    private let monitor: NWPathMonitor  /// 현재 인터넷 연결상태의 종류를 파악하는 라이브러리
    
    private init(){
        monitor = NWPathMonitor()
    }
    
    final func isNetworkConneted(_ complition : @escaping(Bool)->()) ->Void {
        monitor.start(queue: .global())
        monitor.pathUpdateHandler = { path in   /// 현재 연결중인 path를 다룸
            if path.status == .satisfied{   /// if path.status == .satisfied 로 변경
                self.monitor.cancel()
                complition(true)
            }else{
                complition(false)
            }
        }
    }
    
    final func stopMonitoring() {
        monitor.cancel()
    }
}
