//
//  WeatherManager.swift
//  Weather App
//
//  Created by Simo on 4/7/20.
//  Copyright © 2020 A. All rights reserved.
//

import Foundation
import Alamofire


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
