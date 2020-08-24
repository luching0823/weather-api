//
//  ViewController.swift
//  weather
//
//  Created by 廖昱晴 on 2020/8/24.
//  Copyright © 2020 廖昱晴. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempertureLabel: UILabel!
    
    //apiKey
    let apiKey = "lkvC5F0DxmnLR5Gv3Nvg1DvwRrjmaMuT"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //呼叫api
        callAPI()
        // Do any additional setup after loading the view.
    }
    
    //建立api函數
    private func callAPI() {
        //根據網站拼出請求的網址
        let url = URL(string: "http://dataservice.accuweather.com/currentconditions/v1/315078?apikey=\(apiKey)&language=zh-TW")!
        
        //將網址組成一個URLRequest
        var request = URLRequest(url:url)
        
        //設置請求方法為GET
        request.httpMethod = "GET"
        
        //建立URLSession
        let session = URLSession.shared
        
        //使用session + request組成一個 task
        //並設置好收到回應時需要處理的動作
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            //收到回應會執行的Code
            //因為data是optional，有可能請求失敗導致data是空的
            //如果是空的直接 return
            guard let data = data else {
                return
            }
            do {
                //使用JSONDecoder解開data
                let weatherModel = try JSONDecoder().decode([WeatherModel].self, from: data)
                print(weatherModel)
                DispatchQueue.main.async {
                    self.locationLabel.text = "台北市"
                    let tmp = weatherModel.first?.temperature.metric.value ?? -1
                    self.tempertureLabel.text = "\(tmp)"
                }
            } catch {
                print(error)
            }
        })
        //啟動Task
        dataTask.resume()
    }


}

