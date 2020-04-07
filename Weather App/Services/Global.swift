//
//  Global.swift
//  Weather App
//
//  Created by Simo on 3/31/20.
//  Copyright © 2020 A. All rights reserved.
//

import Foundation
import Alamofire
import CoreData



// MARK: Dark Sky Api
struct Config{
    static let baseLink = "https://api.darksky.net/forecast/"
    static let ApiKey = "09e8e244326837f3038ae2e78dcb88f1"
}

// MARK: viewControllers identifiers
enum VCIdendifier {
    static let idVCDetail = "detailVC"
    static let idVCHourly = "hourlyVC"
    static let idVCDaily = "dailyVC"
}

// MARK: detail Weather TableView Cell Labels
enum labelsCell {
    static let wind = "Wind"
    static let humidity = "Humidity"
    static let dewPoint = "Dew Point"
    static let pressure = "Pressure"
    static let visibility = "Visibility"
}

// MARK: detail Weather TableView Cell Labels
enum localImagesNames {
    static let wind = "windy"
    static let humidity = "Humidity"
    static let dewPoint = "DewPoint"
    static let pressure = "Pressure"
    static let visibility = "Visibility"
}



// MARK: -- Detail Weather Struct 
struct DetailWeather {
    let title : String
    let icon : String
    let result : String
    
}

// MARK: share Weather data between viewControllers
struct SharedData {
    static var weatherData : Weather?
}


// MARK: convert Time to 12 Fortmat
func getHour12FormatFromTime(time : Double)-> String{
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "h a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
      return dateFormatter.string(from: date)
}

// MARK: convert Time to 24 Fortmat
func getHour24FormatFromTime(time : Double)-> String{
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
}
// MARK: get day from Time
func getDayFromTime(time : Double)->String{
    let date = Date(timeIntervalSince1970: time)
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: date)
}

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



// MARK: check today 
func checkToday(sysDate : Date, dateInTime : Double)->Bool{
    let dateFromTime = Date(timeIntervalSince1970: dateInTime)
    let order = Calendar.current.compare(sysDate, to: dateFromTime, toGranularity: .day) == .orderedSame
    return order
}

typealias success = (Weather) -> ()
typealias error = (Error) -> ()


// MARK: get weather from API
func getWeather(lati : Double, long : Double, success :  @escaping success, error : @escaping error){
   
    let forecastUrl = "\(Config.baseLink)\(Config.ApiKey)/\(lati),\(long)?lang=en"
    AF.request(forecastUrl).responseJSON { (response) in
        let result = response.result
        switch result {
        case .success(let data):
            if  let jsonData = try? JSONSerialization.data(withJSONObject:data){
                do {
                let weather = try JSONDecoder().decode(Weather.self, from: jsonData)
                        ///TODO :
                        success(weather)
                    
                }catch let eror {
                    print("errooor \(eror)")
                }
                
            }
        case .failure( let err):
            print("failure \(err)")
            error(err)
        }
    }
    
}




