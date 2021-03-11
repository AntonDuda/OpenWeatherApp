//
//  JSONDataConverterService.swift
//  OpenWeatherApp
//
//  Created by Anton on 11.03.2021.
//

import Foundation

typealias ConverterType<T> = (Data) -> T?

class JSONDataConverterService {
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let formater = DateFormatter()
        formater.calendar = Calendar(identifier: .iso8601)
        formater.locale = Locale(identifier: "en_US_POSIX")
        formater.timeZone = TimeZone(secondsFromGMT: 0)
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        decoder.dateDecodingStrategy = .formatted(formater)
        return decoder
    }()
    
    func getParser<T: Decodable>() -> ConverterType<T> {
        return { data in
            return try? self.decoder.decode(T.self, from: data)
        }
    }
}
