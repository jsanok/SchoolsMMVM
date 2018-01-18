//
//  SchoolsViewController.swift
//  20180117-JS-NYCSchools
//
//  Created by jeff sanok on 1/17/18.
//  Copyright © 2018 jeffsanok. All rights reserved.
//

import UIKit

class SchoolsViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)
    
    var schools = [SchoolInfo]()
    var filteredSchools = [SchoolInfo]()
    
    var restoredState = SearchControllerRestorableState()

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utils.insertGradientLayer(theView: self.view)
        
          // search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Schools"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.sizeToFit()
        
        if #available(iOS 11.0, *) {
            // For iOS 11 and later, we place the search bar in the navigation bar.
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            
        } else { 
            // For iOS 10 and earlier, we place the search bar in the table view's header.
            tableView.tableHeaderView = searchController.searchBar
        }
        
        //call back handler for the server data request
        SchoolData.getSchoolData { (data, error) in
            self.schools = data
            self.schools.sort {
                $0.school_name < $1.school_name
            }
            self.tableView.reloadData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Restore the searchController's active state.
        if restoredState.wasActive {
            searchController.isActive = restoredState.wasActive
            restoredState.wasActive = false
            
            if restoredState.wasFirstResponder {
                searchController.searchBar.becomeFirstResponder()
                restoredState.wasFirstResponder = false
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            if let idxPath = tableView.indexPathForSelectedRow?.row {
                if isFiltering() {
                    destination.dbn = self.filteredSchools[idxPath].dbn
                    destination.schoolNamePassed = self.filteredSchools[idxPath].school_name
                }else{
                    destination.dbn = self.schools[idxPath].dbn
                    destination.schoolNamePassed = self.schools[idxPath].school_name
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SchoolsViewController : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filteredSchools.count
        }
        return self.schools.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolsTableViewCell", for: indexPath) as! SchoolsTableViewCell
        
        if isFiltering() {
            cell.schoolName.text = self.filteredSchools[indexPath.row].school_name
        } else {
            cell.schoolName.text = self.schools[indexPath.row].school_name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: "segueDetails", sender: self)
    }

}
// I would like to refactor this and put into a view model to get it out of the VC
extension SchoolsViewController: UISearchResultsUpdating {
  
        // State restoration values.
    enum RestorationKeys: String {
        case viewControllerTitle
        case searchControllerIsActive
        case searchBarText
        case searchBarIsFirstResponder
    }

    struct SearchControllerRestorableState {
        var wasActive = false
        var wasFirstResponder = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text
        {
            filterContentForSearchText(searchText)
        }
    }

    func searchBarIsEmpty() -> Bool {
    
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredSchools = schools.filter({( school : SchoolInfo) -> Bool in
        return school.school_name.lowercased().contains(searchText.lowercased())
        })

        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

}


