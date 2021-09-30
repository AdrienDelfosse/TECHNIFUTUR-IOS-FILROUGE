//
//  BusinessService.swift
//  FilRouge
//
//  Created by Student08 on 30/09/2021.
//

import Foundation
import Alamofire
import CoreLocation
import Foundation

typealias BusinessesCompletionHandler = ([Business]?) -> Void

class BusinessService {

    static let shared = BusinessService()
    
    private let APIToken = "Nrgvh55Q0RpCwJ2FRc5vt3O098EGSWNgi99bSrbKAaw5KWLKD6fzbbsIS2xLqLWG4xjps_2Iw5uaCqU5Eo8ByNJKiKBI7PlWn8wUApfObqGfXj57ARF9fgYjtCwvYXYx"

    func businesses(at location: CLLocation, completionHandler: @escaping BusinessesCompletionHandler) {
        
        let parameters: Parameters = [
            "term": "food",
            "latitude": location.coordinate.latitude,
            "longitude": location.coordinate.longitude,
            "limit": 20,
            "locale": "fr_BE"
        ]
        let headers: HTTPHeaders = [.authorization(bearerToken: APIToken)]
        
        AF.request("https://api.yelp.com/v3/businesses/search",
                   parameters: parameters,
                   headers: headers)
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success:
                    if let data = dataResponse.data {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let businessJSON = try! jsonDecoder.decode(BusinessJSON.self, from: data)
                        let businesses = businessJSON.businesses
                        completionHandler(businesses)
                    } else {
                        completionHandler(nil)
                    }
                case .failure(let error):
                    print("ERROR DETECTED: \(error)")
                    completionHandler(nil)
                }
        }
    }
}
