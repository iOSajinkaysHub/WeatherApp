//
//  WeatherDetailsVC.swift
//  WeatherApp
//
//  Created by Ajinkay on 3/4/21.
//

import UIKit

class WeatherDetailsVC: UIViewController {

    var weatherObject: WeatherObject?
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    var cityName : String = "" {
        didSet {
            self.title = cityName
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tempLabel.text =  String(weatherObject?.main?.temp ?? 0.0)
        feelsLikeLabel.text =  "Feels like: " + String(weatherObject?.main?.feels_like ?? 0.0)

        if weatherObject?.weather?.count ?? 0 > 0 {
            if let weather = weatherObject?.weather?[0] {
                weatherLabel.text =   weather.main
                weatherDescriptionLabel.text =   weather.description

            }
        }
        
    }

}
