//
//  DetailViewController.swift
//  weather
//
//  Created by Padmapriya Trishul on 12/11/15.
//  Copyright © 2015 Padmapriya Trishul. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{

    
    @IBOutlet weak var tableview: UITableView!
     var passValue:[String:AnyObject] = [:]
     var switchValue:Int = 0
    var tableArray:[[String:AnyObject]] = []
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var rainChance: UILabel!
    @IBOutlet weak var snowChance: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var feels: UILabel!
    @IBOutlet weak var descImg: UIImageView!
    let key = "c8bb4dacbb1d1f801162fde9679ef"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        tableview.tableFooterView = UIView(frame: CGRect.zero)
        name.text = (passValue["name"] as! String)
        name.textAlignment = NSTextAlignment.center
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "img1.png")!)
         if connection.isConnectedToNetwork() == true {
        
        let url = "http://api.worldweatheronline.com/free/v2/weather.ashx?q=\(passValue["lat"]!),\(passValue["lng"]!)"
        
        let parameters = ["key":key,"format":"json","tp":"24","num_of_days":"5"]
        Alamofire.request(.GET, url, parameters: parameters)
            .responseJSON { response in
                let JSON:AnyObject? = response.result.value
                let search = JSON?["data"]
                if search != nil{
                let condition = search!!["current_condition"]
                if self.switchValue == 1{
                    self.temp.text = (condition!![0]["temp_C"]!! as! String) + "\u{2103}"
                    self.feels.text = (condition!![0]["FeelsLikeC"]!! as! String) + "\u{2103}"
                    
                }else
                {
                    self.temp.text = (condition!![0]["temp_F"]!! as! String) + "\u{2109}"
                    self.feels.text = (condition!![0]["FeelsLikeF"]!! as! String) + "\u{2109}"
                }
                self.humidity.text = (condition!![0]["humidity"]!! as! String)+"%"
                let code = condition!![0]["weatherDesc"]
                self.desc.text = (code!![0]["value"] as! String)
                self.desc.textAlignment = NSTextAlignment.center
                let link = condition!![0]["weatherIconUrl"]
                let imglink:String = (link!![0]["value"] as! String)
                let newlink = imglink.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
              
                Alamofire.request(.GET, newlink)
                    .response { (request, response, data, error) in
                        self.descImg.image = UIImage(data: data!, scale:1)
                }
                
                let weather = search!!["weather"] as! NSArray
                
                for i in 0..<weather.count{
                    if i == 0{
                        
                        let time = weather[i]["astronomy"]
                        self.sunrise.text = (time!![0]["sunrise"] as! String)
                        self.sunset.text = (time!![0]["sunset"] as! String)
                        let hourly = weather[i]["hourly"]
                        self.snowChance.text = (hourly!![0]["chanceofsnow"] as! String)+"%"
                        self.rainChance.text = (hourly!![0]["chanceofrain"] as! String)+"%"
                        
                        if self.switchValue == 1{
                            self.maxTemp.text = "\u{2191}"+(weather[i]["maxtempC"] as! String)+"\u{2103}"
                            self.minTemp.text = "\u{2193}"+(weather[i]["mintempC"] as! String)+"\u{2103}"
                        }
                        else{
                            self.maxTemp.text = "\u{2191}"+(weather[i]["maxtempF"] as! String)+"\u{2109}"
                            self.minTemp.text = "\u{2193}"+(weather[i]["mintempF"] as! String)+"\u{2109}"
                        }
                        
                    }
                    else{
                        let day = self.convertDate(weather[i]["date"] as! String)
                        let hourly = weather[i]["hourly"]
                        let link = hourly!![0]["weatherIconUrl"]
                        let imglink:String = (link!![0]["value"] as! String)
                        let newlink = imglink.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
                        let maxF = weather[i]["maxtempF"]
                        let minF = weather[i]["mintempF"]
                        let maxC = weather[i]["maxtempC"]
                        let minC = weather[i]["mintempC"]               
                  self.tableArray.append(["day":day,"link":newlink,"minC":minC!!,"maxC":maxC!!,"minF":minF!!,"maxF":maxF!!])
                      self.tableview.reloadData()
                        
                    }
                }
            }
        }
    }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")! as! DetailTableViewCell
        
        cell.contentView.backgroundColor = UIColor.clear;
        cell.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        let result:NSDictionary = tableArray[indexPath.row] as NSDictionary
        cell.day.text = (result["day"] as! String)
        Alamofire.request(.GET, result["link"] as! String)
            .response { (request, response, data, error) in
                cell.imgView.image = UIImage(data: data!, scale:1)
        }
        if self.switchValue == 1{
            cell.maxtemp.text = "\u{2191}"+(result["maxC"] as! String)+"\u{2103}"
            cell.mintemp.text = "\u{2193}"+(result["minC"] as! String)+"\u{2103}"
        }
        else{
            cell.maxtemp.text = "\u{2191}"+(result["maxF"] as! String)+"\u{2109}"
            cell.mintemp.text = "\u{2193}"+(result["minF"] as! String)+"\u{2109}"
        }

    
        
        return cell;
    }

    
    func convertDate(_ input:String)->String{
        
        let dateString = input // change to your date format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateStyle = DateFormatter.Style.full
        let convertedDate = dateFormatter.string(from: date!)
        let day = convertedDate.components(separatedBy: ",")
        return day[0]
        
    }

}
