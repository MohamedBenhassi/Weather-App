//
//  Global.swift
//  Weather App
//
//  Created by Simo on 3/31/20.
//  Copyright © 2020 A. All rights reserved.
//

import Foundation
import Alamofire

// MARK: Dark Sky Api
class Config{
    static let baseLink = "https://api.darksky.net/forecast/"
    static let ApiKey = "09e8e244326837f3038ae2e78dcb88f1"
    static let GOOGLE_API_KEY = "AIzaSyB6gnpbKmaonbhC9bv4RFW56nZ3hrzzSHY"
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




