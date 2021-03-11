//
//  Weather.swift
//  OpenWeatherApp
//
//  Created by Anton on 11.03.2021.
//

import Moya

struct Weather {
    
    static let shared = Weather()
    
    let network: APIManagerNetwork
    
    private init() {
        let config = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let loggerPlugin = NetworkLoggerPlugin(configuration: config)
        let converter = JSONDataConverterService()
        
        network = APIManagerNetwork(converter: converter,
                                    plugins: [loggerPlugin])
    }
}
