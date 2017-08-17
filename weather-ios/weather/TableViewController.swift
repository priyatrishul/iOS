//
//  TableViewController.swift
//  weather
//
//  Created by Padmapriya Trishul on 12/9/15.
//  Copyright © 2015 Padmapriya Trishul. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class TableViewController: UITableViewController,CLLocationManagerDelegate {
    var cityArray:[[String:AnyObject]] = []
    var switchvalue = true
    var passValue:[String:AnyObject] = [:]
    var locValue:[String:AnyObject] = ["name": "" as AnyObject, "lng": "" as AnyObject, "lat": "" as AnyObject,"tempF": "--" as AnyObject ,"tempC": "--" as AnyObject,"country":"" as AnyObject,"region":"" as AnyObject]
    var locationManager: CLLocationManager = CLLocationManager()
    var latitude:Double!
    var longitude:Double!
    @IBOutlet weak var switchButton: UIBarButtonItem!
    let key = "c8bb4dacbb1d1f801162fde9679ef"
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults().set(true, forKey: "Authorize")
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        switchButton.title = "\u{2109}"
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.delegate = self
        locationManager.distanceFilter = 3000
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        self.navigationController?.isToolbarHidden = false
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "img1.png")!)
   
         //when app starts for first time
        let first:Bool = UserDefaults().bool(forKey: "launch") 
            if first == false {
                cityArray.append(["name": "San Diego" as AnyObject, "lng": -117.156 as AnyObject, "lat": 32.715 as AnyObject,"tempF": "--" as AnyObject ,"tempC": "--" as AnyObject,"country":"United States of America" as AnyObject,"region":"California" as AnyObject])
                cityArray.append(["name": "Bangalore" as AnyObject, "lng": 77.583 as AnyObject, "lat": 12.983 as AnyObject,"tempF": "--" as AnyObject ,"tempC": "--" as AnyObject,"country":"India" as AnyObject,"region":"Karnataka" as AnyObject])
                cityArray.append(["name": "London" as AnyObject, "lng": -0.106 as AnyObject, "lat": 51.517 as AnyObject,"tempF": "--" as AnyObject ,"tempC":"--" as AnyObject ,"country":"United Kingdom" as AnyObject,"region":"City of London, Greater London" as AnyObject])
                
                UserDefaults().set(cityArray, forKey: "cities")
                UserDefaults().set(true, forKey: "launch")
                tableView.reloadData()
            }
            tableUpdate()
        
            if let switchOn:Bool = UserDefaults().bool(forKey: "switch"){
            if switchOn == true{
                switchButton.title = "Change To "+"\u{2109}"
                switchvalue = true
                UserDefaults().set(true, forKey: "switch")
                
            }else{
                switchButton.title = "Change To "+"\u{2103}"
                switchvalue = false
                UserDefaults().set(false, forKey: "switch")
            }
        }
    
    
    }
    
    //change to Fahrenheit to Celsius and viceversa
    @IBAction func degChange(_ sender: UIBarButtonItem) {
        if switchvalue == true{
            switchvalue = false
             switchButton.title = "Change To "+"\u{2103}"
             UserDefaults().set(false, forKey: "switch")
        }else{
            switchvalue = true
            switchButton.title = "Change To "+"\u{2109}"
             UserDefaults().set(true, forKey: "switch")
        }
        self.tableView.reloadData()
    }
    
    func sortArray() {
    print("called")
    tableUpdate()
    refreshControl?.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let loc:Bool = UserDefaults().bool(forKey: "Authorize"){
            if loc == true{
             return cityArray.count+1
            }
        }
        return cityArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.contentView.backgroundColor = UIColor.clear;
        
        cell.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        if let loc:Bool = UserDefaults().bool(forKey: "Authorize"){
            if loc == true{
                if indexPath.row == 0 {
               let result:NSDictionary = locValue as NSDictionary
                cell.name1.text = (result["name"] as! String)
                cell.name2.text = (result["country"] as! String)
                if switchvalue == true{
                    if connection.isConnectedToNetwork() == true {
                    cell.temperature.text = String(describing: result["tempC"]!) + "\u{2103}"
                    }else{
                      cell.temperature.text = "--" + "\u{2103}"
                    }
                }else{
                    if connection.isConnectedToNetwork() == true {
                    cell.temperature.text = String(describing: result["tempF"]!) + "\u{2109}"
                    }else{
                     cell.temperature.text = "--" + "\u{2109}"
                    }
                }
                }else{
                    
                    let result:NSDictionary = cityArray[indexPath.row-1] as NSDictionary
                    cell.name1.text = (result["name"] as! String)
                    cell.name2.text = (result["country"] as! String)
                    if switchvalue == true{
                       if connection.isConnectedToNetwork() == true {
                        cell.temperature.text = String(describing: result["tempC"]!) + "\u{2103}"
                       }else{
                         cell.temperature.text = "--" + "\u{2103}"
                        }
                    }else{
                        if connection.isConnectedToNetwork() == true {
                        cell.temperature.text = String(describing: result["tempF"]!) + "\u{2109}"
                        }else{
                            cell.temperature.text = "--" + "\u{2109}"
                        }
                    }
                    
                }
                
            }else{
                let result:NSDictionary = cityArray[indexPath.row] as NSDictionary
                cell.name1.text = (result["name"] as! String)
                cell.name2.text = (result["country"] as! String)
                if switchvalue == true{
                    if connection.isConnectedToNetwork() == true {
                    cell.temperature.text = String(describing: result["tempC"]!) + "\u{2103}"
                    }else{
                       cell.temperature.text = "--" + "\u{2103}"
                    }
                }else{
                    if connection.isConnectedToNetwork() == true {
                    cell.temperature.text = String(describing: result["tempF"]!) + "\u{2109}"
                    }else{
                    cell.temperature.text = "--" + "\u{2109}"
                    }
                }
                
            }
        }
        


        return cell
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //if let loc:Bool = NSUserDefaults().boolForKey("location"){
            if let loc:Bool = UserDefaults().bool(forKey: "Authorize"){
            if loc == true{
                if indexPath.row == 0{
                     return false
                }
               
            }
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let loc:Bool = UserDefaults().bool(forKey: "Authorize"){
                if loc == true{
                    self.cityArray.remove(at: indexPath.row-1)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    UserDefaults().set(self.cityArray, forKey: "cities")
                }else{
                    self.cityArray.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    UserDefaults().set(self.cityArray, forKey: "cities")
                }

            }
        } else if editingStyle == .insert {
           
        }    
    }
    


    @IBAction func locationChange(_ sender: UIBarButtonItem) {
        UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
        
    }
    
    //send data to  detail controller
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "detail"{
    let indexPath = tableView.indexPathForSelectedRow
        if let loc:Bool = UserDefaults().bool(forKey: "Authorize"){
            if loc == true{
                if indexPath?.row == 0{
                    let destination = segue.destination as! DetailViewController
                    destination.passValue = locValue
                    if switchvalue == true {
                        destination.switchValue = 1
                    }
                    
                }else{
                    let destination = segue.destination as! DetailViewController
                    destination.passValue = self.cityArray[indexPath!.row-1]
                    if switchvalue == true {
                        destination.switchValue = 1
                    }
                    
                    
                }
                
            }else{
                let destination = segue.destination as! DetailViewController
                destination.passValue = self.cityArray[indexPath!.row]
                if switchvalue == true {
                    destination.switchValue = 1
                }
            }
        }
    }
    }
    
    //get data from search controller
    @IBAction func back(_ segue:UIStoryboardSegue)
    {
        var itemPresent = 0
        for item in cityArray{
            if item["name"] as! String == passValue["name"] as! String && item["country"] as! String == passValue["country"] as! String {
                itemPresent = 1
            }
            
        }
        if itemPresent == 0{
        if connection.isConnectedToNetwork() == true {
        let url = "http://api.worldweatheronline.com/free/v2/weather.ashx?q=\(passValue["lat"]!),\(passValue["lng"]!)"
        let parameters = ["key":key,"format":"json","tp":"24","num_of_days":"1"]
        Alamofire.request(.GET, url, parameters: parameters)
            .responseJSON { response in
                let JSON:AnyObject? = response.result.value
                let search = JSON?["data"]
                if search != nil{
                let condition = search!!["current_condition"]
                self.passValue["tempF"] = condition!![0]["temp_F"]!!
                self.passValue["tempC"] = condition!![0]["temp_C"]!!
                self.cityArray.append(self.passValue)
                UserDefaults().set(self.cityArray, forKey: "cities")
                self.tableView.reloadData()
                }
                
        }
        }
    }
    }
    
    //access location
    func locationManager(_ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                latitude = location.coordinate.latitude
                longitude = location.coordinate.longitude
            }
             if connection.isConnectedToNetwork() == true {
            findLocation(latitude, lng: longitude, loc: true)
            }
    }

    //get location access is denied or authorized
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
                
                switch status {
                case .notDetermined:
                    print(".NotDetermined")
                    
                case .authorizedAlways:
                    print(".Authorized")
                    UserDefaults().set(true, forKey: "Authorize")
                    
                case .denied:
                    print(".Denied")
                            UserDefaults().set(false, forKey: "Authorize")
                            self.cityArray = (UserDefaults().array(forKey: "cities") as? [[String:AnyObject]])!
                            self.tableView.reloadData()
                    
                default:
                    print("Unhandled authorization status")
                    
                }
            }
    
    //get co-ordinates for the current location
    func findLocation(_ lat:Double,lng:Double,loc:Bool){
        
        if connection.isConnectedToNetwork() == true {
        let url = "http://api.worldweatheronline.com/free/v2/search.ashx?q=\(lat),\(lng)"
        let parameters = ["key":key,"format":"json"]
        
        Alamofire.request(.GET, url, parameters: parameters)
            .responseJSON { response in
                let JSON:AnyObject? = response.result.value
                let search = JSON?["search_api"]
                if (search!) != nil{
                    let array = search!!["result"] as! NSArray
                    
                    for i in 0..<1 {
                        let resultArea = array[i]["areaName"] as! NSArray
                        let area = resultArea[0]["value"]
                        let countryArea = array[i]["country"] as! NSArray
                        let country = countryArea[0]["value"]
                        let regionArea = array[i]["region"] as! NSArray
                        let region = regionArea[0]["value"]
                        let lng = array[i]["longitude"]
                        let lat = array[i]["latitude"]
                        self.locValue = ["name":area!!,"country":country!!,"lng":lng!!,"lat":lat!!,"tempF":0,"tempC":0,"region":region!!]
                        self.callUpdate((lat!! as! NSString).doubleValue , lng: (lng!! as! NSString).doubleValue )
                       
                    }
                    
                }
      }
    }
    
}
    
    //update current location
    func callUpdate(_ lat:Double,lng:Double){
         if connection.isConnectedToNetwork() == true {        
        let url1 = "http://api.worldweatheronline.com/free/v2/weather.ashx?q=\(lat),\(lng)"
        let parameters1 = ["key":key,"format":"json","tp":"24","num_of_days":"1"]
        
        Alamofire.request(.GET, url1, parameters: parameters1)
            .responseJSON { response in
                let JSON:AnyObject? = response.result.value
                let search = JSON?["data"]
                if search != nil{
                let condition = search!!["current_condition"]
                self.locValue["tempF"] = condition!![0]["temp_F"]!!
                self.locValue["tempC"] = condition!![0]["temp_C"]!!
                self.tableView.reloadData()
                }
                
        }
    }
    
    }
    
    //update table data
    func tableUpdate(){
        if let temp:Array = UserDefaults().array(forKey: "cities") as? [[String:AnyObject]] {
            self.cityArray = temp
            
        }
        
        for  i in 0..<cityArray.count {
            
            let lng = cityArray[i]["lng"]!
            let lat = cityArray[i]["lat"]!
            if i%4 == 0{
                sleep(1)
            }
            if connection.isConnectedToNetwork() == true {
                
                let url = "http://api.worldweatheronline.com/free/v2/weather.ashx?q=\(lat),\(lng)"
                let parameters = ["key":key,"format":"json","tp":"24","num_of_days":"1"]
                
                Alamofire.request(.GET, url, parameters: parameters)
                    .responseJSON { response in
                        let JSON:AnyObject? = response.result.value
                        let search = JSON?["data"]
                        if search != nil{
                            let condition = search!!["current_condition"]
                            self.cityArray[i]["tempF"] = condition!![0]["temp_F"]!!
                            self.cityArray[i]["tempC"] = condition!![0]["temp_C"]!!
                            self.tableView.reloadData()
                            UserDefaults().set(self.cityArray, forKey: "cities")
                        }
                        
                }
                
            }else {
                
                let alert = UIAlertController(title: "Alert", message: "Please Check For Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        

        
    }
}
