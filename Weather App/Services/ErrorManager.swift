//
//  ErrorManager.swift
//  Weather App
//
//  Created by Simo on 4/7/20.
//  Copyright © 2020 A. All rights reserved.
//

import UIKit

// MARK: - Alert to display Error
func errorAlert(_ title : String, _ msg : String, vc : UIViewController){
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    vc.present(alert, animated: true, completion: nil)
}


