//
//  Protocols.swift
//  Weather App
//
//  Created by Simo on 4/1/20.
//  Copyright © 2020 A. All rights reserved.
//

import Foundation

protocol SegementControlSelectionDelegate {
    func didSegementTapped(index : Int)
}

protocol currentWeatherDetailData {
    func currentWeatherData(current : Currently)
}

var selectionSegementDelegate : SegementControlSelectionDelegate?
var currentWeatherDetailDataDelegate : currentWeatherDetailData?

