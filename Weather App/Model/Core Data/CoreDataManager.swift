//
//  CoreDataManager.swift
//  Weather App
//
//  Created by Simo on 4/7/20.
//  Copyright © 2020 A. All rights reserved.
//

import Foundation
import CoreData


// MARK:- add and save City info into Offline Storage using Core Data
func addCity(_ cityName : String, _ cityLati : Double, _ cityLong : Double){
    // check City if Exist
    let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "name = %@", cityName)
    let result = try! context.fetch(fetchRequest)
    if result.count == 0 {
        // Add City
        let city = City(context: context)
        city.name = cityName
        city.long = cityLong
        city.lati = cityLati
        city.isCurrent = false
        ad.saveContext()
    }

}

// MARK: - Update City
func updateCity(name : String){
    let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
    let result = try! context.fetch(fetchRequest)
    if result.count > 0 {
        for city in result {
            city.name == name ? (city.setValue(true, forKey: "isCurrent")) : city.setValue(false, forKey: "isCurrent")
        }
    }
    ad.saveContext()
}

// MARK: - get current City
func getCurrentCity()->City?{
    var currentCity : City?
    let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "isCurrent == true")
    let result = try! context.fetch(fetchRequest)
    if result.count > 0 {
        let object = result[0]
        currentCity = object
    }
    return currentCity
}

// MARK:- fetch all cities from Offline Storage Core Data
func getCites()->[City]{
    var listCities = [City]()
    let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
    let cities = try! context.fetch(fetchRequest)
    if cities.count > 0 {
          listCities = cities
    }
    return listCities
}

// MARK: - delete City From Offline Storage Core Data
func deleteCity(name : String){
    let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "name = %@",name)
    let result = try! context.fetch(fetchRequest)
    if result.count > 0 {
        context.delete(result[0])
    }
    ad.saveContext()
}
