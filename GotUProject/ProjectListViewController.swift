import UIKit
import FirebaseDatabase

class ProjectListViewController: UITableViewController,UISearchBarDelegate{
    
    @IBOutlet weak var searchBar:UISearchBar!
    
    // MARK: Property
    var category : [Project] = []
    var inSearchMode = false
    var filteredprojects = [Project] ()
    
    
    // MARK: Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
//        let rootVC = self.navigationController?.viewControllers[0] as! ProjectCategoryViewController
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if inSearchMode {
            if filteredprojects.count == 0 {
                return filteredprojects.count
            } else {
                return self.filteredprojects.count
            }
        } else {
            return category.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath)
        
        var project: Project!        
        if inSearchMode {
            if filteredprojects.count == 0 {
                let project = category[indexPath.row]
                cell.textLabel?.text = project.projectName

            } else {
                project = filteredprojects[indexPath.row]
                cell.textLabel?.text = project.projectName
            }
        } else {
            let project = category[indexPath.row]
            cell.textLabel?.text = project.projectName
        }
        return cell
    }
    
    
    //MARK: Search Function
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            tableView.reloadData()
        } else {
            inSearchMode = true
            let lower = searchBar.text?.lowercased()
            filteredprojects = category.filter({$0.projectName.range(of:lower!) != nil})
            tableView.reloadData()
        }
    }
    
    
    // MARK: - Segue Handling
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProject" {
            
            guard let destination = segue.destination as? ProjectDetailViewController else {
                return
            }
            guard let cell = sender as? UITableViewCell else {
                return
            }
            guard let indexPath = self.tableView.indexPath(for: cell) else {
                return
            }
            
            let project = category[indexPath.row]
            destination.project = project
            
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
}
