//
//  DataManager.swift
//  WeatherApp
//
//  Created by Ajinkay on 3/4/21.
//

import Foundation

import Foundation

enum ParsingError: Error {
    case invaidUrlError
    case invalidDataError
    case parsingFailedError(error: String)
    
    var errorMsg: String {
        
        switch self {
        case .invaidUrlError:
            return "Invalid URL"
        case .invalidDataError:
            return "Invalid Data"
        case let .parsingFailedError(error: error):
            return "\(error)"
        }
    }
}

class DataManager {
    

    private func getURLEndPath(city : String) -> String {
        return "https://api.openweathermap.org/data/2.5/forecast?q=" + city + "&appid=65d00499677e59496ca2f318eb68c049"
    }
    
    func fetchWeatherInfo(cityName : String,  completionHandler: @escaping (Weather?, ParsingError?) -> Void) {
        
        let urlString = getURLEndPath(city: cityName)
        print(urlString)
        guard let addressURL = URL(string: urlString) else {
            completionHandler(nil, .invaidUrlError)
            return
        }
        URLSession.shared.dataTask(with: addressURL) {(data, response, error) in
            guard error == nil  || data != nil else {
                completionHandler(nil, .invalidDataError)
                return
            }
            guard let data = data else {
                completionHandler(nil, .invalidDataError)
                return
            }
            do {
                let addressObj = try JSONDecoder().decode(Weather.self, from: data)
                completionHandler(addressObj, nil)
            } catch let error {
                print(error)
                completionHandler(nil, .parsingFailedError(error: error.localizedDescription))
            }
        }.resume()
    }
}

