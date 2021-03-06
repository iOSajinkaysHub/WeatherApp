//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ajinkay on 3/4/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var cityNameTF: UITextField!
    
    lazy var dataManager = DataManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Weather"
    }


    @IBAction func lookupButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        
        if cityNameTF.text?.count ?? 0 > 0 {
            dataManager.fetchWeatherInfo(cityName: cityNameTF.text ?? "") { (weatherInfo, error) in
                guard let weahterInfo = weatherInfo , error == nil else {
                    self.disaplayAlertWithMessage(message: "Something went wrong and please try again")
                    return
                }
                DispatchQueue.main.async {
                    
                    if weahterInfo.list?.count ?? 0 > 0 {
                        let listVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherListVC") as? WeatherListVC
                        listVC?.cityName = self.cityNameTF.text ?? ""
                        listVC?.dataArray = weahterInfo.list ?? []
                        self.navigationController?.pushViewController(listVC ?? UIViewController(), animated: true)
                    }else{
                        self.disaplayAlertWithMessage(message: "No results found and please try again")
                    }
                }
            }
          
        }else{
            disaplayAlertWithMessage(message: "Please enter city name and try again")
        }
        
    }
    
    func disaplayAlertWithMessage(message : String) {
        
        let alertVC = UIAlertController.init(title: "Weather", message: message, preferredStyle: .alert)
       
        let action = UIAlertAction.init(title: "Ok", style: .default) { _ in
        }
        alertVC.addAction(action)
        self.present(alertVC, animated: true) {
            
        }
    }
    
}

extension ViewController : UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

