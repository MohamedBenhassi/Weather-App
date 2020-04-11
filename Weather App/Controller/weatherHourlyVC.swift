//
//  weatherHourlyVC.swift
//  Weather App
//
//  Created by Simo on 3/31/20.
//  Copyright © 2020 A. All rights reserved.
//

import UIKit

class WeatherHourlyVC: UIViewController {
    @IBOutlet weak var hourlyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibTableViewCell = UINib(nibName: "hourlyCell", bundle: nil)
        hourlyTableView.register(nibTableViewCell, forCellReuseIdentifier: "hourlyCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Load TableView before load of View
        self.hourlyTableView.reloadData()
    }
    
    // MARK: configuration of Cell
    func configCell(cell : HourlyCell, indexPath : IndexPath ){
        guard let hourtly = SharedData.weatherData?.hourly?.data?[indexPath.row] else {return}
        cell.configCell(hourly: hourtly)
    }
    
}

extension WeatherHourlyVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let hourlyCount = SharedData.weatherData?.hourly?.data?.count else {
        return 0
        }
        return hourlyCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hourlyTableView.dequeueReusableCell(withIdentifier: "hourlyCell", for: indexPath) as! HourlyCell
            configCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
}
