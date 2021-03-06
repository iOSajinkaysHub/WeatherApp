//
//  WeatherListView.swift
//  WeatherApp
//
//  Created by Ajinkay on 3/4/21.
//

import UIKit

class WeatherListVC: UIViewController {

    @IBOutlet weak var  weatherTableView: UITableView!

    var dataArray: [WeatherObject] = []
    
    var cityName : String = "" {
        didSet {
            self.title = cityName
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
        
        weatherTableView.tableFooterView = UIView.init()
    }

    private func  registerNib() {
        weatherTableView.register(UINib(nibName: WeatherListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: WeatherListTableViewCell.identifier)
    }

}

//MARK:-> Table view data source and delgates
extension WeatherListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard dataArray.count > indexPath.row else { return UITableViewCell() }
        guard let searchCell = tableView.dequeueReusableCell(withIdentifier: WeatherListTableViewCell.identifier, for: indexPath) as? WeatherListTableViewCell else { return UITableViewCell() }
        searchCell.setUpCell(with: dataArray[indexPath.row])
        return searchCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let listVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherDetailsVC") as? WeatherDetailsVC
        listVC?.cityName = self.cityName
        listVC?.weatherObject = dataArray[indexPath.row]

        navigationController?.pushViewController(listVC ?? UIViewController(), animated: true)
    }
}

