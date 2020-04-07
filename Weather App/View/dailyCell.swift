//
//  dailyCell.swift
//  Weather App
//
//  Created by Simo on 4/5/20.
//  Copyright © 2020 A. All rights reserved.
//

import UIKit

class dailyCell: UITableViewCell {

    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var tempIcon: UIImageView!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    // MARK: configuration of cell in tableView
    func configCell(daily : Datum){
        guard let dailyTime = daily.time else {return}
        guard let tempLow = daily.temperatureMin else {return}
        guard let tempMax = daily.temperatureHigh else {return}
        guard let iconOfTemp = daily.icon else {return}
        let dayName = getDayFromTime(time: Double(dailyTime))
        // check Temperature Degree Type
        if WeatherSettings.temperatureType.value(forKey: "tempTypeKey") as? String == "C"{
            let tempLowCelsius = convertToCelsius(fahrenheit: tempLow)
            let tempMaxCelsius = convertToCelsius(fahrenheit: tempMax)
            self.lowTempLabel.text = "\(Int(tempLowCelsius))°"
            self.maxTempLabel.text = "\(Int(tempMaxCelsius))°"
        }else{
            self.lowTempLabel.text = "\(Int(tempLow))°"
            self.maxTempLabel.text = "\(Int(tempMax))°"
        }
        self.tempIcon.image = UIImage(named: iconOfTemp)
        self.tempIcon.tintColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        let isToday = checkToday(sysDate: Date(), dateInTime: Double(dailyTime))
        isToday ? self.dayNameLabel.text = "Today" : (self.dayNameLabel.text = dayName)
        isToday ? (self.dayNameLabel.textColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)) : (self.dayNameLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1))
    }
    
}
