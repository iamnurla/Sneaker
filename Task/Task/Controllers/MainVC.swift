//
//  ViewController.swift
//  Task
//
//  Created by Yersultan Nalikhan on 22.05.2021.
//

import UIKit

class MainVC: UIViewController {

    //MARK: - Properties
    
    private let tableView = UITableView()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    let sneakers = Sneaker.GetAllSneakers()
    
    var filteredSneakers = [Sneaker]()
    
    
    //MARK: -  Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.performWithoutAnimation {
            searchController.isActive = true
            searchController.isActive = false
        }
    }


    //MARK: - Helpers
    
    func configureUI() {
        configureTableView()
        configureSearchController()
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SneakerCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.frame = view.frame
        
    }
    
    func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search.."
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.sizeToFit()
        searchController.searchBar.scopeButtonTitles = ["All", "Men", "Women", "Child" ]
    }
    
    
    //MARK: - Functions
    
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredSneakers = sneakers.filter({ (sneaker: Sneaker) -> Bool in
            let doesCategoryMatch = (scope == "All") || (scope == sneaker.gender)
            if isSearchBarEmpty() {
                return doesCategoryMatch
            }else {
                return doesCategoryMatch && sneaker.brand.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        let isScopeFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty() || isScopeFiltering)
    }
    
    
    
}


    //MARK: - UITableViewDataSource

extension MainVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredSneakers.count
        }
        return sneakers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SneakerCell else {return UITableViewCell()}
        
        let currentSneaker : Sneaker
        
        if isFiltering() {
            currentSneaker = filteredSneakers[indexPath.row]
        }else {
            currentSneaker = sneakers[indexPath.row]
        }
        
        cell.brandLbl.text = currentSneaker.brand
        cell.genderLbl.text = currentSneaker.gender
        cell.priceLbl.text = currentSneaker.price
        return cell
    }
    
    func showSelected(showSelected sneaker: Sneaker) {
        let controller = SneakerInfo()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
}

    //MARK: - UITableViewDelegate

extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = sneakers[indexPath.row]
        showSelected(showSelected: selectedRow)
    }

}


    //MARK: - UISearchBarDelegate

extension MainVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

    //MARK: - UISearchResultsUpdating

extension MainVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
        
    }

}
