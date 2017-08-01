//
//  AppDelegate.swift
//  GotUProject
//
//  Created by Ping-Ying Yen on 2016/12/28.
//  Copyright © 2016年 Ping-Ying Yen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    override init(){
        FIRApp.configure()
    }
    
}
