//
//  AddProjectViewController.swift
//  GotUProject
//
//  Created by Ping-Ying Yen on 2017/1/2.
//  Copyright © 2017年 Ping-Ying Yen. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddProjectViewController: UITableViewController,UITextFieldDelegate {
    
    var ref : FIRDatabaseReference!
    var projectID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        let rootVC = self.navigationController?.viewControllers[0] as! ProjectCategoryViewController
        projectID = rootVC.discoverCategories.count + rootVC.interestedCategories.count + rootVC.joinedCategories.count + rootVC.mineCategories.count
        
        // Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddProjectViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //datePickerView delegate
        text_deadLine.delegate = self
    }
    
    // MARK : - Text field for the new project
    @IBOutlet weak var text_projectName: UITextField!
    @IBOutlet weak var text_tag: UITextField!
    @IBOutlet weak var text_projectTime: UITextField!
    @IBOutlet weak var text_deadLine: UITextField!
    @IBOutlet weak var text_subject: UITextField!
    @IBOutlet weak var text_organizer: UITextField!
    @IBOutlet weak var text_numOfPeople: UITextField!
    @IBOutlet weak var text_abstract: UITextField!
    @IBOutlet weak var text_links: UITextField!
    @IBOutlet weak var text_contact: UITextField!
    @IBOutlet weak var text_telephone: UITextField!
    @IBOutlet weak var text_email: UITextField!
    @IBOutlet weak var text_otherInformation: UITextField!

    //MARK: - TextField Delegate  for beginDatePickerTextField
    func textFieldDidEndEditing(_ textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.isHidden = false
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
    }
    
    func datePickerChanged(sender:UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        text_deadLine.text = formatter.string(from: sender.date)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        text_deadLine.resignFirstResponder()
        return true
    }
    
    @IBAction func button_saveNewProject(_ sender: UIBarButtonItem) {
        // Post the data to firebase
        projectID = projectID + 1
        let project = ref.child("Projects").child("\(projectID)")
        project.child("projectName").setValue(text_projectName.text!)
        project.child("tags").setValue(text_tag.text!)
        project.child("projectTime").setValue(text_projectTime.text!)
        project.child("deadLine").setValue(text_deadLine.text!)
        project.child("subject").setValue(text_subject.text!)
        project.child("organizer").setValue(text_organizer.text!)
        project.child("numOfPeople").setValue(text_numOfPeople.text!)
        project.child("abstract").setValue(text_abstract.text!)
        project.child("links").setValue(text_links.text!)
        project.child("contact").setValue(text_contact.text!)
        project.child("telephone").setValue(text_telephone.text!)
        project.child("email").setValue(text_email.text!)
        project.child("otherInformation").setValue(text_otherInformation.text!)
        project.child("categories").setValue("Mine")
         _ = navigationController?.popToRootViewController(animated: true)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
   }
