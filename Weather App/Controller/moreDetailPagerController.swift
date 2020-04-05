//
//  moreDetailPagerController.swift
//  Weather App
//
//  Created by Simo on 3/31/20.
//  Copyright © 2020 A. All rights reserved.
//

import UIKit

class moreDetailPagerController: UIPageViewController {
    
    // MARK: List of viewControllers
    lazy var subViewControllers : [UIViewController] = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vcDetail = sb.instantiateViewController(withIdentifier: VCIdendifier.idVCDetail)
        let vcHourly = sb.instantiateViewController(withIdentifier: VCIdendifier.idVCHourly)
        let vcDaily = sb.instantiateViewController(withIdentifier: VCIdendifier.idVCDaily)
        return [vcDetail,vcHourly,vcDaily]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectionSegementDelegate = self
        
    }
    

    
}

extension moreDetailPagerController:SegementControlSelectionDelegate{
    func didSegementTapped(index: Int) {
        setViewControllers([subViewControllers[index]], direction: .forward, animated: true, completion: nil)
    }
    
    
}


