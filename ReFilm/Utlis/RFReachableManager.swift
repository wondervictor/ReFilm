//
//  RFReachableManager.swift
//  ReFilm
//
//  Created by VicChan on 5/26/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

import UIKit
import SystemConfiguration

// MARK: 用于检测网络状况

public class RFReachableManager: NSObject {
    
    
    override init() {
        super.init()
    }
    
    public func checkNetWorkCondition() {
        let scRef: SCNetworkReachabilityRef = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, "www.baidu.com")!
        var flags = SCNetworkReachabilityFlags()
        let reach = SCNetworkReachabilityGetFlags(scRef, &flags)
        if reach {
            switch flags {
            case SCNetworkReachabilityFlags.Reachable : print("reachable")
            case SCNetworkReachabilityFlags.IsWWAN: print("WWAN")
            default: print("unreachable")
                
            }
            
        }
        
        
    }
    
}




extension RFReachableManager {
    
}

