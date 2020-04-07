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


// MARK: share Weather data between viewControllers
struct SharedData {
    static var weatherData : Weather?
}






