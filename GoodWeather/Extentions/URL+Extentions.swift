//
//  URL+Extentions.swift
//  GoodWeather
//
//  Created by 山本響 on 2022/07/23.
//

import Foundation

extension URL {
    
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=c9e473c1fce00214552e3e50e0c67f5b&units=imperial")
    }
}
