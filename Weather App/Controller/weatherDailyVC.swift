//
//  weatherDailtVC.swift
//  Weather App
//
//  Created by Simo on 3/31/20.
//  Copyright © 2020 A. All rights reserved.
//

import UIKit

class weatherDailyVC: UIViewController {
    @IBOutlet weak var dailyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibTableViewCell = UINib(nibName: "dailyCell", bundle: nil)
        dailyTableView.register(nibTableViewCell, forCellReuseIdentifier: "dailyCell")

    }
    
    
    // MARK: configuration of Cell
    func configCell(cell : dailyCell, indexPath : IndexPath ){
        guard let daily = SharedData.weatherData?.daily?.data?[indexPath.row] else {return}
        cell.configCell(daily: daily)
    }
    
}

extension weatherDailyVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dailtyCount = SharedData.weatherData?.daily?.data?.count else {
            return 0
        }
        return dailtyCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dailyTableView.dequeueReusableCell(withIdentifier: "dailyCell", for: indexPath) as! dailyCell
        configCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    
}
