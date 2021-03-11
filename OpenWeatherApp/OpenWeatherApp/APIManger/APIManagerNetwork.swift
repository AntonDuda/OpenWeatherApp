//
//  APIManagerNetwork.swift
//  OpenWeatherApp
//
//  Created by Anton on 06.02.2021.
//

import Foundation
import Moya

class APIManagerNetwork: Networkable {
    
    let provider: MoyaProvider<APIManagerProvider>
    let dataConverter: JSONDataConverterService
    
    init(converter: JSONDataConverterService,
         plugins: [PluginType]) {
        self.dataConverter = converter
        let session = Session(startRequestsImmediately: false)
        let provider = MoyaProvider<APIManagerProvider>(session: session,
                                                        plugins: plugins)
        self.provider = provider
    }
    
    func fetchWeather(longitude: Double,
                      latitude: Double,
                      countOfDays: Int,
                      apiKey: String) -> WeatherPromise<Data> {
        return executeAndMap(request: .createRequest(longitude: longitude,
                                                     latitude: latitude,
                                                     countOfDays: countOfDays,
                                                     apiKey: apiKey))
    }
//     let apiKey = "e59abf156fb4a7bc7f0258d2f4d7041d"
}
