//
//  Converter.swift
//  Weather App
//
//  Created by Simo on 4/7/20.
//  Copyright © 2020 A. All rights reserved.
//

import Foundation

// MARK: - Convert Temperature to Celsius
func convertToCelsius(fahrenheit: Double) -> Int {
    return Int(5.0 / 9.0 * (fahrenheit - 32.0))
}

