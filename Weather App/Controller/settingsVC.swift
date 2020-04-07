//
//  settingsVC.swift
//  Weather App
//
//  Created by Simo on 4/7/20.
//  Copyright © 2020 A. All rights reserved.
//

import UIKit

class settingsVC: UITableViewController {
    @IBOutlet weak var tempSegement: UISegmentedControl!
    @IBOutlet weak var timeSwitcher: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let tempType = WeatherSettings.temperatureType.value(forKey: "tempTypeKey") as? String else {return}
        guard let timeFormat = WeatherSettings.temperatureType.value(forKey: "timeFormatKey") as? Bool else {return}
        print(timeFormat)
        tempType == "C" ? (tempSegement.selectedSegmentIndex = 1) : (tempSegement.selectedSegmentIndex = 0)
        timeSwitcher.isOn = timeFormat
    }


    @IBAction func timeSwitcherTapped(_ sender: UISwitch) {
        WeatherSettings.timeFormat.setValue(sender.isOn, forKey: "timeFormatKey")
    }
    
    @IBAction func tempTypeSegementTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            WeatherSettings.temperatureType.set("F", forKey: "tempTypeKey")
        case 1:
            WeatherSettings.temperatureType.set("C", forKey: "tempTypeKey")
        default:
            break
        }
    }
    
    
}
