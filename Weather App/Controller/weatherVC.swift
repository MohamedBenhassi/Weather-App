//
//  weatherVC.swift
//  Weather App
//
//  Created by Simo on 3/30/20.
//  Copyright © 2020 A. All rights reserved.
//

import UIKit



class weatherVC: UIViewController {
    
    
    
    @IBOutlet weak var currentWeatherTempLabel: UILabel!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: get weather data from API
        getWeather(lati: 33.517736, long: 7.658283, success: { (weather) in
            self.updateUI(weather: weather)
            guard let currently = weather.currently else {return}
            currentWeatherDetailDataDelegate?.currentWeatherData(current: currently)
        }) { (error) in
            print("there is an error \(error)")
        }

    }
    
    // MARK: update UI when Data laoded
    func updateUI(weather : Weather){
        guard let icon = weather.currently?.icon else {return}
        guard let temperature = weather.currently?.temperature else {return}
        guard let weatherSummary = weather.currently?.summary else {return}
        self.currentWeatherIcon.image = UIImage(named: icon)
        self.currentWeatherTempLabel.text = "\(temperature)°F"
        self.currentSummaryLabel.text = weatherSummary
    }
    
    
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        selectionSegementDelegate?.didSegementTapped(index: sender.selectedSegmentIndex)
    }
    
    
    

}
