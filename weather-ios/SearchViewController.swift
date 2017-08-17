//
//  SearchViewController.swift
//  weather
//
//  Created by Padmapriya Trishul on 12/10/15.
//  Copyright © 2015 Padmapriya Trishul. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultsLabel: UILabel!
    var cityArray:[[String:AnyObject]] = []
    var passValue:NSDictionary = [:]
    let key = "c8bb4dacbb1d1f801162fde9679ef"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        searchBar.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "img1.png")!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(_ searchBar: UISearchBar,  textDidChange searchText: String) {
        let text = searchText.replacingOccurrences(of: " ", with: "%20", options: NSString.CompareOptions.literal, range: nil)
        if text == ""{
            cityArray = []
            
        }
         if connection.isConnectedToNetwork() == true {
        let url = "http://api.worldweatheronline.com/free/v2/search.ashx?q=\(text)"
        let parameters = ["key":key,"format":"json"]
        Alamofire.request(.GET, url, parameters: parameters)
            .responseJSON { response in
                let JSON:AnyObject? = response.result.value
                self.cityArray = []
                 self.resultsLabel.text = ""
                 self.tableView.reloadData()
                 let search = JSON?["search_api"]
                if search != nil{
                    if (search!) != nil{
                    let array = search!!["result"] as! NSArray
                    for i in 0..<array.count {
                     let resultArea = array[i]["areaName"] as! NSArray
                     let area = resultArea[0]["value"]
                     let countryArea = array[i]["country"] as! NSArray
                     let country = countryArea[0]["value"]
                     let regionArea = array[i]["region"] as! NSArray
                     let region = regionArea[0]["value"]
                     let lng = array[i]["longitude"]
                    let lat = array[i]["latitude"]
               self.cityArray.append(["name":area!!,"country":country!!,"lng":lng!!,"lat":lat!!,"tempF":"--","tempC":"--","region":region!!])
                                       }
                   self.tableView.reloadData()
                    
                    }else{
                        
                        self.resultsLabel.text = "No Results Found"
                }
            }
                
        }
    }
    
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cityArray.count
    }
    
    
    //display values returned from search
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
        cell.contentView.backgroundColor = UIColor.clear;
        cell.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        let result:NSDictionary = cityArray[indexPath.row] as NSDictionary
        cell.textLabel!.text = (result["name"] as! String)+","+(result["region"] as! String)+","+(result["country"] as! String);        
        return cell;
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            let indexPath = tableView.indexPathForSelectedRow
            let destination = segue.destination as! TableViewController
            destination.passValue = self.cityArray[indexPath!.row]
        
    }

}
