//
//  searchPlaceVC.swift
//  Weather App
//
//  Created by Simo on 4/5/20.
//  Copyright © 2020 A. All rights reserved.
//

import UIKit
import MapKit

class SearchPlaceVC: UIViewController {
    @IBOutlet weak var placesTableView: UITableView!
    
    let searchBar = UISearchBar()
    var matchingItems:[ MKLocalSearchCompletion] = []
    let searchCompleter = MKLocalSearchCompleter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.placeholder = "Search places"
        self.searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        searchCompleter.delegate = self
        
    }
    
    
    func searchForPlaceWithMapKit(searchedText: String) {
        searchCompleter.queryFragment = searchedText
    }
    
    @IBAction func closeButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SearchPlaceVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = placesTableView.dequeueReusableCell(withIdentifier: "placesTableViewCell")
        cell?.textLabel?.text = matchingItems[indexPath.row].title
        return cell!
    }
    
}

extension SearchPlaceVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let completion = matchingItems[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else {return}
            addCity(completion.title, coordinate.latitude, coordinate.longitude)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension SearchPlaceVC:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchForPlaceWithMapKit(searchedText: searchText)
    }
    
}

extension SearchPlaceVC:MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let searchResults = completer.results
        self.matchingItems = searchResults
        self.placesTableView.reloadData()
        
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
        errorAlert("Error", error.localizedDescription, vc: self)

    }
    
}
