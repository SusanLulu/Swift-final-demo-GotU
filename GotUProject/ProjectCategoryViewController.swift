//
//  ProjectCategoryViewController.swift
//  GotUProject
//
//  Created by Ping-Ying Yen on 2016/12/29.
//  Copyright © 2016年 Ping-Ying Yen. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProjectCategoryViewController: UITableViewController {
    // MARK: Properties
    var discoverCategories : [Project] = []
    var interestedCategories : [Project] = []
    var joinedCategories : [Project] = []
    var mineCategories : [Project] = []
    var projectDisplayed : [Bool?] = []
    
    // MARK: Life Circle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var ref : FIRDatabaseReference?
        // Set the firebase reference
        ref = FIRDatabase.database().reference()
        
        
        // Retrieve the projects and get the value
        ref?.child("Projects").observe(FIRDataEventType.value, with: { (snapshot) in
            
            let projectArray = snapshot.value as? NSMutableArray ?? nil
            projectArray?.removeObject(at: 0)
            let temp = projectArray! as NSArray
            let projects = temp as! Array< Dictionary< String, String>>

            for (index, _) in projects.enumerated()
            {
                if(index >= self.projectDisplayed.count){
                    self.projectDisplayed.append(false)
                }
            }
            for (index, project) in projects.enumerated() {
                if(self.projectDisplayed[index] == false)
                {
                if (
                    project["projectName"] != nil &&
                    project["tags"] != nil &&
                    project["projectTime"] != nil &&
                    project["deadLine"] != nil &&
                    project["subject"] != nil &&
                    project["organizer"] != nil &&
                    project["numOfPeople"] != nil &&
                    project["abstract"] != nil &&
                    project["links"] != nil &&
                    project["contact"] != nil &&
                    project["telephone"] != nil &&
                    project["email"] != nil &&
                    project["otherInformation"] != nil &&
                    project["categories"] != nil
                    ) {
                
                        self.projectDisplayed[index] = true

                        let projectStruct = Project.init(projectName: project["projectName"]!, tags: project["tags"]!, projectTime: project["projectTime"]!, deadLine: project["deadLine"]!, subject: project["subject"]!, organizer: project["organizer"]!, numOfPeople: project["numOfPeople"]!, abstract: project["abstract"]!, links: project["links"]!, contact: project["contact"]!, telephone: project["telephone"]!, email: project["email"]!, otherInformation: project["otherInformation"]!, categories: project["categories"]!)
                        switch projectStruct.categories {
                            case "Discover" :
                                self.discoverCategories.append(projectStruct)
                            case "Interested" :
                                self.interestedCategories.append(projectStruct)
                            case "Joined" :
                                self.joinedCategories.append(projectStruct)
                            case "Mine" :
                                self.mineCategories.append(projectStruct)
                            default :
                                self.discoverCategories.append(projectStruct)
                        }
                    }
                }
            }
            self.tableView.reloadData()
        })
    }

    
    // MARK: - Segue Handling
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DiscoverSegue" {
            guard let destination = segue.destination as? ProjectListViewController else {
                return
            }
            let category = self.discoverCategories
            destination.category = category
        }
        if segue.identifier == "InterestedSegue" {
            guard let destination = segue.destination as? ProjectListViewController else {
                return
            }
            let category = self.interestedCategories
            destination.category = category
        }
        if segue.identifier == "JoinedSegue" {
            guard let destination = segue.destination as? ProjectListViewController else {
                return
            }
            let category = self.joinedCategories
            destination.category = category
        }
        if segue.identifier == "MineSegue" {
            guard let destination = segue.destination as? ProjectListViewController else {
                return
            }
            let category = self.mineCategories
            destination.category = category
        }
        else {
            super.prepare(for: segue, sender: sender)
        }
    }
}
