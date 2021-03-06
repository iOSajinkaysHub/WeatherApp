//
//  WeatherListTableViewCell.swift
//  WeatherApp
//
//  Created by Ajinkay on 3/4/21.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {

    static let identifier = "WeatherListTableViewCell"

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(with weather: WeatherObject) {
        tempLabel.text = "Temp: " + String(weather.main?.temp ?? 0.0)
        if weather.weather?.count ?? 0 > 0 {
            if let weather = weather.weather?[0] {
                weatherLabel.text =   weather.main
            }
        }
    }
}
