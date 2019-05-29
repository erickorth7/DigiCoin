//
//  ViewController.swift
//  DigiCoin Ticker
//
//  Created by Eric Korth on 5/29/19.
//  Copyright © 2019 AppStrudel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    let symbolsArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    
    var finalURL = ""
    
    var finalLabel = ""
    
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
 
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(symbolsArray[row])
        print(currencyArray[row])
        
        finalURL = baseURL + currencyArray[row]
        
        finalLabel = symbolsArray[row]
        
        print(finalURL)
        
        getCurrencyData(url: finalURL)
        
    
    }
    
    //Networking:
    
    func getCurrencyData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON {response in
                if response.result.isSuccess {
                    print("Success! Got the Data!")
                    let bitCoinJSON : JSON = JSON(response.result.value!)
                    
                    self.updatebitCoinData(json: bitCoinJSON)
                
                } else {
                    print("Error \(String(describing: response.result.error))")
                    self.valueLabel.text = "Connection Issues"
                }
            
        }
    }
    
    func updatebitCoinData(json : JSON) {
        
        if let dataResult = json["open"]["hour"].double {
            
            
            valueLabel.text = ("\(finalLabel)" + " \(dataResult)")
            
            
        } else {
            
            valueLabel.text = "Data Unavailable"
            
        }
        
    }

}

