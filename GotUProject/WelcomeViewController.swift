//
//  WelcomeViewController.swift
//  GotUProject
//
//  Created by Ping-Ying Yen on 2017/1/3.
//  Copyright © 2017年 Ping-Ying Yen. All rights reserved.
//

import UIKit
import FirebaseDatabase

class WelcomeViewController: UIViewController {
    
    var ref : FIRDatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:-Timer
        _ = Timer.scheduledTimer(timeInterval: 1.0,target:self,selector:#selector(WelcomeViewController.timerTimeUp(_:)),userInfo:nil,repeats:false)
    }
    
    func timerTimeUp(_ timer: Timer) {
        self.performSegue(withIdentifier: "goProjectCategory", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
