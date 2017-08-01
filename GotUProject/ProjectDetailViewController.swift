//
//  ProjectDetailViewController.swift
//  GotUProject
//
//  Created by Ping-Ying Yen on 2017/1/2.
//  Copyright © 2017年 Ping-Ying Yen. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProjectDetailViewController: UITableViewController {
    
    @IBOutlet weak var lbl_ProjectName: UILabel!
    @IBOutlet weak var lbl_Tag: UILabel!
    @IBOutlet weak var lbl_ProjectTime: UILabel!
    @IBOutlet weak var lbl_DeadLine: UILabel!
    @IBOutlet weak var lbl_Subject: UILabel!
    @IBOutlet weak var lbl_Organizer: UILabel!
    @IBOutlet weak var lbl_NumOfPeople: UILabel!
    @IBOutlet weak var lbl_Abstract: UITextView!
    @IBOutlet weak var lbl_Links: UILabel!
    @IBOutlet weak var lbl_Contact: UILabel!
    @IBOutlet weak var lbl_Telephone: UILabel!
    @IBOutlet weak var lbl_Email: UILabel!
    @IBOutlet weak var lbl_OtherInformation: UILabel!
    
    var project: Project? {
        didSet {
            self.updateLables()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Update when the view is loaded.
        self.updateLables()
    }
    
    func updateLables() {
        // If the view is not loaded yet, don't update
        guard self.isViewLoaded else {
            return
        }
        
        // Update labels
        self.lbl_ProjectName.text = project?.projectName
        self.lbl_Tag.text = project?.tags
        self.lbl_ProjectTime.text = project?.projectTime
        self.lbl_DeadLine.text = project?.deadLine
        self.lbl_Subject.text = project?.subject
        self.lbl_Organizer.text = project?.organizer
        self.lbl_NumOfPeople.text = project?.numOfPeople
        self.lbl_Abstract.text = project?.abstract
        self.lbl_Links.text = project?.links
        self.lbl_Contact.text = project?.contact
        self.lbl_Telephone.text = project?.telephone
        self.lbl_Email.text = project?.email
        self.lbl_OtherInformation.text = project?.otherInformation
        
    }

}
