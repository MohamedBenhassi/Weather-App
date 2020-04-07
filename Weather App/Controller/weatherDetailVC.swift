//
//  weatherDetailVC.swift
//  Weather App
//
//  Created by Simo on 3/31/20.
//  Copyright © 2020 A. All rights reserved.
//

import UIKit

class weatherDetailVC: UIViewController {
    @IBOutlet weak var detailTableView: UITableView!
    
    var listDetailWeather = [DetailWeather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibTableViewCell = UINib(nibName: "detailCell", bundle: nil)
        detailTableView.register(nibTableViewCell, forCellReuseIdentifier: "detailCell")

        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let current = SharedData.weatherData?.currently  else {return}
        loadDetailWeatherData(current: current)
        self.detailTableView.reloadData()
    }
    
    
    // MARK: Load List of Detail weather into listDetailWeather
    func loadDetailWeatherData(current : Currently){
        guard let wind = current.windSpeed else {return}
        guard let humidty = current.humidity else {return}
        let humidtyPercent = humidty * 100
        guard let dewPoint = current.dewPoint else {return}
        guard let pressure = current.pressure else {return}
        guard let visibility = current.visibility else {return}
        if listDetailWeather.count > 0 {
            listDetailWeather.removeAll()
        }
        listDetailWeather.append(DetailWeather(title: labelsCell.wind, icon: localImagesNames.wind, result: "\(wind) mph"))
        listDetailWeather.append(DetailWeather(title: labelsCell.humidity, icon: localImagesNames.humidity, result: "\(humidtyPercent)%"))
        if WeatherSettings.temperatureType.value(forKey: "tempTypeKey") as? String == "C"{
            let tempCelsius = convertToCelsius(fahrenheit: dewPoint)
            listDetailWeather.append(DetailWeather(title: labelsCell.dewPoint, icon: localImagesNames.dewPoint, result: "\(tempCelsius)°"))
        }else{
            listDetailWeather.append(DetailWeather(title: labelsCell.dewPoint, icon: localImagesNames.dewPoint, result: "\(Int(dewPoint))°"))
        }
        listDetailWeather.append(DetailWeather(title: labelsCell.pressure, icon: localImagesNames.pressure, result: "\(Int(pressure)) mb"))
        listDetailWeather.append(DetailWeather(title: labelsCell.visibility, icon: localImagesNames.visibility, result: "\(Int(visibility)) mph"))
        self.detailTableView.reloadData()
    }
    
    // MARK: configuration of Cell
    func configCell(cell : detailCell, indexPath : IndexPath ){
        let current = listDetailWeather[indexPath.row]
        cell.configurationCell(current: current)
    }
 
    

}


extension weatherDetailVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDetailWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! detailCell
            configCell(cell: cell, indexPath: indexPath)
        return cell
        
        
    }
    
    
}



