//
//  locationsVC.swift
//  Weather App
//
//  Created by Simo on 4/5/20.
//  Copyright © 2020 A. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData



class LocationsVC: UIViewController {
    @IBOutlet weak var citiesTableView: UITableView!
    
    let loacationManager = CLLocationManager()
    var listCities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loacationManager.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.listCities = getCites()
            self.citiesTableView.reloadData()
    }
    
    // MARK:- check Location permission to acces to user Location
      func checkLocationPermission(){
          if CLLocationManager.locationServicesEnabled() {
               switch CLLocationManager.authorizationStatus() {
                  case .notDetermined, .restricted, .denied:
                      print("No access")
                      errorAlert("Error Location", "Location services are not enabled", vc: self)
                      self.loacationManager.requestWhenInUseAuthorization()
                      self.loacationManager.desiredAccuracy = kCLLocationAccuracyBest
                      self.loacationManager.startMonitoringSignificantLocationChanges()
                  case .authorizedAlways, .authorizedWhenInUse:
                      print("Access")
                      self.loacationManager.startUpdatingLocation()
               @unknown default:
                  break
              }
          } else {
                    print("Location services are not enabled")
                    errorAlert("Error Location", "Location services are not enabled", vc: self)
                    self.loacationManager.requestWhenInUseAuthorization()
                    self.loacationManager.desiredAccuracy = kCLLocationAccuracyBest
                    self.loacationManager.startMonitoringSignificantLocationChanges()
              }
      }
     
    @IBAction func gpsButtonTapped(_ sender: UIBarButtonItem) {
        self.checkLocationPermission()
    }
    
}

extension LocationsVC:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let place = locations.last
        guard let latitude = place?.coordinate.latitude else {return}
        guard let longitude = place?.coordinate.longitude else {return}
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(place!) { (placemarks, eror) in
            if eror == nil {
                if let firstLocation = placemarks?[0], let cityName = firstLocation.locality { // get the city name
                    self.loacationManager.stopUpdatingLocation()
                    addCity(cityName, latitude, longitude)
                    self.listCities = getCites()
                    self.citiesTableView.reloadData()
                }
            }
        }
    }
}

extension LocationsVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesTableView.dequeueReusableCell(withIdentifier: "citiesCell")
        listCities[indexPath.row].isCurrent ? (cell?.accessoryType = .checkmark) : (cell?.accessoryType = .none)
        cell?.textLabel?.text = listCities[indexPath.row].name
        return cell!
    }
    
    
}

extension LocationsVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let name = listCities[indexPath.row].name else {return}
        updateCity(name: name)
        self.tabBarController?.selectedIndex = 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        guard let cityName = listCities[indexPath.row].name else {return}
        deleteCity(name: cityName)
        self.listCities.remove(at: indexPath.row)
        self.citiesTableView.deleteRows(at: [indexPath], with: .fade)
      }
    }
    
}

