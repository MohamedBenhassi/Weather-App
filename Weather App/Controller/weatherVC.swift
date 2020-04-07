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
        
       

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.weatherSetup()
        
    }
    
    // MARK: - get weather data from API and update UI
    func weatherSetup(){
        guard let currentCity = getCurrentCity() else {return}
        getWeather(lati: currentCity.lati, long: currentCity.long, success: { (weather) in
            SharedData.weatherData = weather
            self.updateUI(weather: weather, cityName: currentCity.name ?? "--")
        }) { (error) in
            print("Error \(error.localizedDescription)")
        }
    }
    
    // MARK: update UI when Data laoded
    func updateUI(weather : Weather, cityName : String){
        guard let icon = weather.currently?.icon else {return}
        guard let temperature = weather.currently?.temperature else {return}
        guard let weatherSummary = weather.currently?.summary else {return}
        self.currentWeatherIcon.image = UIImage(named: icon)
        self.currentWeatherTempLabel.text = "\(Int(temperature))°"
        self.currentSummaryLabel.text = weatherSummary
        self.locationNameLabel.text = cityName
        selectionSegementDelegate?.didSegementTapped(index: 0)
    }
    
    
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        selectionSegementDelegate?.didSegementTapped(index: sender.selectedSegmentIndex)
    }
    
}
