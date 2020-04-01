//
//  detailCell.swift
//  Weather App
//
//  Created by Simo on 4/1/20.
//  Copyright © 2020 A. All rights reserved.
//

import UIKit

class detailCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultInfoLabel: UILabel!
    
    // MARK: configuration of cell in tableView
    func configurationCell(current : DetailWeather) {
        self.iconImageView.image = UIImage(named: current.icon)
        self.iconImageView.tintColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        self.titleLabel.text = current.title
        self.resultInfoLabel.text = "\(current.result)"
    }
    
    
    
}
