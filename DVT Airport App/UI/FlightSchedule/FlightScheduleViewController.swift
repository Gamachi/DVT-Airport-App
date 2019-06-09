//
//  FlightScheduleViewController.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/06/09.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import UIKit

class FlightScheduleViewController: UIViewController {
    
    var airport: NearbyAirport? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Showing flight schedules for \(airport?.nameAirport ?? "")")
    }

}
