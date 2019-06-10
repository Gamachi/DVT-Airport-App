//
//  FlightScheduleViewController.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/06/09.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import UIKit

class FlightScheduleViewController: UIViewController {
    
    @IBOutlet weak var progressOverlay: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var airport: NearbyAirport?
    var flightsSchedule: [FlightSchedule]?
    
    private var viewModel: FlightScheduleViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FlightScheduleViewModel(view: self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveFlights()
    }

}

// MARK: - FlightScheduleView

extension FlightScheduleViewController : FlightScheduleView {
    
    func presentFlights(_ flights: [FlightSchedule]) {
        progressOverlay.isHidden = true
        
        print("Presenting flights schedule")
        flightsSchedule = flights
        tableView.reloadData()
    }
    
    func failedToRetrieveFlights() {
        progressOverlay.isHidden = true
        
        let notice = UIAlertController(title: "Whoops!", message: "Retrying to retrieve flights", preferredStyle: .alert)
        notice.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(notice, animated: true, completion: nil)
    }
    
}

// MARK: - FlightScheduleCell

class FlightScheduleCell : UITableViewCell {
    
    @IBOutlet weak var departureTime: UILabel!
    @IBOutlet weak var statusIndicator: UIImageView!
    @IBOutlet weak var flightType: UILabel!
    @IBOutlet weak var airlineName: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var flightIataNr: UILabel!
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FlightScheduleViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return flightsSchedule?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(integerLiteral: 8)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flightScheduleCell = tableView.dequeueReusableCell(withIdentifier: "FlightScheduleCell") as! FlightScheduleCell
        
        if let flightSchedule = flightsSchedule?[indexPath.section] {
            flightScheduleCell.departureTime.text = formatFlightTime(flightSchedule.departure?.scheduledTime)
            let showGreenIndicator = flightSchedule.status == "active"
            flightScheduleCell.statusIndicator.image = showGreenIndicator ? UIImage(named: "green_dot") : UIImage(named: "red_dot")
            flightScheduleCell.flightType.text = flightSchedule.status ?? "?????"
            flightScheduleCell.airlineName.text = flightSchedule.airline?.name ?? "?????"
            flightScheduleCell.destination.text = flightSchedule.arrival?.iataCode ?? "?????"
            flightScheduleCell.flightIataNr.text = flightSchedule.flight?.iataNumber ?? "?????"
        }
        
        return flightScheduleCell
    }
    
}

// MARK: - Private

extension FlightScheduleViewController {
    
    private func retrieveFlights() {
        print("Attempting to show flight schedules for \(airport?.nameAirport ?? "")")
        guard let airportIataCode = airport?.codeIataAirport else {
            print("Invalid airport IATA code; Unable to retrieve flight schedule")
            return
        }
        
        progressOverlay.isHidden = false
        
        viewModel.getAirportSchedule(airportIataCode)
    }
    
    private func formatFlightTime(_ dateTimeString: String?) -> String {
        guard let inputTimeString = dateTimeString else {
            return "??:??"
        }
        
        let inputFormatter = DateFormatter()
        inputFormatter.calendar = Calendar(identifier: .iso8601)
        inputFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSS"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "hh:mm"
        if let date = inputFormatter.date(from: inputTimeString) {
            return outputFormatter.string(from: date)
        } else {
            return "??:??"
        }
    }
    
}
