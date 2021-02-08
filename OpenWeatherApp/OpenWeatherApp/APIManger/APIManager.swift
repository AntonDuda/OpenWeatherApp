//
//  APIManager.swift
//  OpenWeatherApp
//
//  Created by Anton on 06.02.2021.
//

import Alamofire

class APIManager {

     let daysCount = 16
     let apiKey = "e59abf156fb4a7bc7f0258d2f4d7041d"

func fetchWeather(for location: Coordinates, completion: @escaping (CommonResponce?) -> Void) {
    let parameters: [String: Any] = [
        "lat": location.latitude,
        "lon": location.longitude,
        "appid": apiKey,
        "cnt": daysCount
    ]
    let request = AF.request("https:/api.openweathermap.org/data/2.5/forecast/daily", parameters: parameters)
    request.responseDecodable(of: CommonResponce.self) {
        (responce) in DispatchQueue.main.async {
            completion(responce.value)
        }
    }
  }
}
