//
//  ResponceModel.swift
//  OpenWeatherApp
//
//  Created by Anton on 06.02.2021.
//

import Foundation

struct CommonResponce: Codable {
    let city: City
    let cod: String
    let message: Double
    let cnt: Int
    let list: [List]
}

struct City: Codable {
    let id: Int
    let name: String
    let country: String
    let population, timezone: Int
}

struct List: Codable {
    let dt, sunrise, sunset: Int
    let temp: Temp
    let pressure, humidity: Int
    let speed: Double
    let deg, clouds: Int
    let pop: Double
    let snow, rain: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case pressure, humidity, speed, deg, clouds, pop, snow, rain
    }
}

struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}
