//
//  WeatherModel.swift
//  weather
//
//  Created by 廖昱晴 on 2020/8/24.
//  Copyright © 2020 廖昱晴. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
    let localObservationDateTime: String
    let epochTime: TimeInterval
    let weatherText: String
    let isDayTime: Bool
    
    struct Temperature: Decodable {
        struct Metric: Decodable {
            let value: Double
            let unit: String
            let unitType: Int
            private enum CodingKeys: String, CodingKey {
                case value = "Value"
                case unit = "Unit"
                case unitType = "UnitType"
            }
        }
        let metric: Metric
        private enum CodingKeys: String, CodingKey {
            case metric = "Metric"
        }
    }
    let temperature: Temperature
    let mobileLink: URL
    let link: URL
    private enum CodingKeys: String, CodingKey {
        case localObservationDateTime = "LocalObservationDateTime"
        case epochTime = "EpochTime"
        case weatherText = "WeatherText"
        case isDayTime = "IsDayTime"
        case temperature = "Temperature"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}
