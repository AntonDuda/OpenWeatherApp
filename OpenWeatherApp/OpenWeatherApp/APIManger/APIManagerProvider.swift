//
//  APIManagerProvider.swift
//  OpenWeatherApp
//
//  Created by Anton on 11.03.2021.
//

import Moya

enum APIManagerProvider {
    
    case createRequest(longitude: Double,
                       latitude: Double,
                       countOfDays: Int,
                       apiKey: String)
}

extension APIManagerProvider: TargetType {
    
    var baseURL: URL {
        return URL(string: "https:/api.openweathermap.org/data/2.5/forecast/daily")!
    }
    
    var path: String {
        switch self {
        case .createRequest:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .createRequest(longitude, latitude, countOfDays, apiKey):
            let parameters: [String: Any] = [
                "lon": longitude,
                "lat": latitude,
                "cnt": countOfDays,
                "appid": apiKey
            ]
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let parameters: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "*/*"
        ]
        return parameters
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
