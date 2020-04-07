//
//  hourlyCell.swift
//  Weather App
//
//  Created by Simo on 4/4/20.
//  Copyright © 2020 A. All rights reserved.
//

import UIKit

class hourlyCell: UITableViewCell {
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var tempLabel: UILabel!
    
    // MARK: configuration of cell in tableView
    func configCell(hourly : Currently){
        guard let currentTime = hourly.time else {return}
        guard let temperature = hourly.temperature else {return}
        // check Time Format
        if WeatherSettings.timeFormat.value(forKey: "timeFormatKey") as? Bool == true{
            let hour = getHour24FormatFromTime(time:  Double((currentTime)))
            self.timeLabel.text = hour
        }else{
            let hour = getHour12FormatFromTime(time: Double((currentTime)))
            self.timeLabel.text = hour
        }
        // check Temperature Degree Type
        if WeatherSettings.temperatureType.value(forKey: "tempTypeKey") as? String == "C"{
            let tempCelsius = convertToCelsius(fahrenheit: temperature)
            self.tempLabel.text = "\(Int((tempCelsius)))°"
        }else{
            self.tempLabel.text = "\(Int((temperature)))°"
        }
        self.roundedLabel()
    }
    
    // MARK: make temp label Rounded 
    func roundedLabel(){
        self.tempLabel.layer.masksToBounds = true
        let labelHeight = self.tempLabel.layer.bounds.height
        self.tempLabel.layer.cornerRadius = labelHeight / 2
    }
    
   
    
}
