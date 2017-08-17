//
//  ReportTableViewController.swift
//  Potholes
//
//  Created by Padmapriya Trishul on 11/13/15.
//  Copyright © 2015 Padmapriya Trishul. All rights reserved.
//

import UIKit
import Alamofire

class ReportTableViewController: UITableViewController {

    @IBOutlet var reportTable: UITableView!
     var tableValues:NSArray = []
     var imageValues:NSMutableArray = []
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "http://bismarck.sdsu.edu/city/fromDate"
        
        let parameters = ["type":"street","user":"abc469"]  // fetch data with user=abc
        let fromDateRequest:Request = Alamofire.request(.GET, url, parameters: parameters)
        fromDateRequest.responseJSON { response in
            if response.result.isSuccess {
                let JSON:AnyObject? = response.result.value
                self.tableValues = JSON as! NSArray
                
            } else {
                fromDateRequest.responseString { response in
                    let errorMessage:AnyObject? = response.result.value
                    print(errorMessage)
                }
            }
            if(self.tableValues.count>0){
                self.reportTable.reloadData()
                
            }
        }
        
            }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
               return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableValues.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        let result:NSDictionary = tableValues[indexPath.row] as! NSDictionary
        
        cell.textLabel?.text = (result["description"] as! String)
        //cell.imageView?.image = UIImage(named: "p1.jpg")
        cell.detailTextLabel?.text = String(result["id"]!)
        cell.detailTextLabel?.hidden = true
        cell.imageView?.image = UIImage(named: "no-image")
        let id:Int = Int(result["id"]! as! NSNumber)
        
        if (result["imagetype"] as! String) != "none" && (result["imagetype"] as! String) != " " && (result["imagetype"] as! String) != "" {
            
           //cell.imageView?.image = (self.imageValues[indexPath.row] as! UIImage)
            
       Alamofire.request(.GET, "http://bismarck.sdsu.edu/city/image?id=\(id)")
            .response { (request, response, data, error) in
            cell.imageView?.image = UIImage(data: data!, scale:1)
                
        }

        }
        
        return cell
    }

    override func viewDidAppear(animated: Bool) {

        super.viewDidAppear(animated)
        reloadData()
        
    }

  
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "detail" {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!

        let destination = segue.destinationViewController as! DetailViewController
        destination.lat = currentCell.detailTextLabel?.text
        
        for each in tableValues{
            
           let passValues:NSDictionary = each as! NSDictionary
            let num:Int = Int((currentCell.detailTextLabel?.text!)!)!
            let id:Int = Int(String(passValues["id"]!))!
            
            if(num == id)
            {
                destination.result = each as! NSDictionary
            }
            
        }
    
    }
    
    }
  
    func reloadData()
    {
        
        let url = "http://bismarck.sdsu.edu/city/fromDate"
        
        let parameters = ["type":"street","user":"abc469"]
        let fromDateRequest:Request = Alamofire.request(.GET, url, parameters: parameters)
        fromDateRequest.responseJSON { response in
            if response.result.isSuccess {
                let JSON:AnyObject? = response.result.value
                self.tableValues = JSON as! NSArray
                
            } else {
                fromDateRequest.responseString { response in
                    let errorMessage:AnyObject? = response.result.value
                    print(errorMessage)
                }
            }
            if(self.tableValues.count>0){
                self.reportTable.reloadData()
            }
        }
        self.tableView.reloadData()
    }
    

    @IBAction func back(segue:UIStoryboardSegue)
    {
        let destination = segue.destinationViewController as! ReportTableViewController
        destination.viewDidLoad()//reload view after coming back from AddViewController

        
    }
}
