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
    
    var viewModel = SchoolsViewModel()
    
    var restoredState = SearchControllerRestorableState()

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utils.insertGradientLayer(theView: self.view)
        
        // search controller
        setUpSearhBar()
        
        //call back handler for the server data request
        SchoolData.getSchoolData { (data, error) in
            self.viewModel.schools = data
            self.viewModel.schools.sort {
                $0.school_name < $1.school_name
            }
            self.tableView.reloadData()
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        restoreSearchBarState()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            if let idxPath = tableView.indexPathForSelectedRow?.row {
                if isFiltering() {
                    destination.viewModel.dbn = self.viewModel.filteredSchools[idxPath].dbn
                    destination.viewModel.schoolNamePassed = self.viewModel.filteredSchools[idxPath].school_name
                }else{
                    destination.viewModel.dbn = self.viewModel.schools[idxPath].dbn
                    destination.viewModel.schoolNamePassed = self.viewModel.schools[idxPath].school_name
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
            return viewModel.filteredSchools.count
        }
        return self.viewModel.schools.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolsTableViewCell", for: indexPath) as! SchoolsTableViewCell
        
        if isFiltering() {
            cell.schoolName.text = self.viewModel.filteredSchools[indexPath.row].school_name
        } else {
            cell.schoolName.text = self.viewModel.schools[indexPath.row].school_name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: "segueDetails", sender: self)
    }

}

extension SchoolsViewController: UISearchResultsUpdating {
  
    func setUpSearhBar() {
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
    }
    
    func restoreSearchBarState() {
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
    
    struct SearchControllerRestorableState {
        var wasActive = false
        var wasFirstResponder = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text
        {
            viewModel.filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }

    func searchBarIsEmpty() -> Bool {
    
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

}


