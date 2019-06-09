//
//  AirportService.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/05/31.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation
import RxSwift
import RxRetroSwift

class AirportServiceImplementation {
    
    private let requestCaller = RequestCaller.init(config: URLSessionConfiguration.default)
    
    private init() {
        // TODO: Change from mock to actual before submission
        RequestModel.defaults.baseUrl = BaseUrl.Mock.rawValue
    }

    
    private enum QueryKey : String {
        case ApiKey = "key"
        case Lat = "lat"
        case Lng = "lng"
        case Distance = "distance"
        case IataCode = "iataCode"
        case TimetableType = "type"
    }
    
    private enum QueryValue : String {
        case ApiKey = "53c042-ce0265"
        case Distance = "100"
        case TimetableType = "departure"
    }
    
    private enum BaseUrl : String {
        case Default = "http://aviation-edge.com/v2/public"
        case Mock = "https://a76dec81-f9d5-4933-851a-9a817a82b1e0.mock.pstmn.io"
    }
    
    private enum CallPath : String {
        case GetAirports = "/nearby"
        case GetSchedule = "/timetable"
    }
    
}

// MARK: - AirportService

extension AirportServiceImplementation : AirportService {
    
    static var shared: AirportService = AirportServiceImplementation()
    
    func getAirports(nearbyLat: String, long: String) -> Observable<Result<[NearbyAirport], ErrorInformation>> {
        return getAirports(nearbyLat: nearbyLat, long: long, distance: QueryValue.Distance.rawValue)
    }
    
    func getAirports(nearbyLat: String, long: String, distance: String) -> Observable<Result<[NearbyAirport], ErrorInformation>> {
        let getAirportsQueryDictionary = [
            QueryKey.ApiKey.rawValue : QueryValue.ApiKey.rawValue,
            QueryKey.Lat.rawValue : nearbyLat,
            QueryKey.Lng.rawValue : long,
            QueryKey.Distance.rawValue : distance
        ]
        
        let request = RequestModel(httpMethod: .get,
                                   path: CallPath.GetAirports.rawValue,
                                   query: getAirportsQueryDictionary)
            .asURLRequest()
        
        return requestCaller.call(request)
    }
    
    func getDepartureSchedule(forAirportWithIATACode: String) -> Observable<Result<[AirportSchedule], ErrorInformation>> {
        let getDepartureScheduleQueryDictionary = [
            QueryKey.ApiKey.rawValue : QueryValue.ApiKey.rawValue,
            QueryKey.IataCode.rawValue : forAirportWithIATACode,
            QueryKey.TimetableType.rawValue : QueryValue.TimetableType.rawValue
        ]
        
        let request = RequestModel(httpMethod: .get,
                                   path: CallPath.GetSchedule.rawValue,
                                   query: getDepartureScheduleQueryDictionary)
            .asURLRequest()
        
        return requestCaller.call(request)
    }
    
}
