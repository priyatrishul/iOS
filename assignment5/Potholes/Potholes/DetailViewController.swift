//
//  DetailViewController.swift
//  Potholes
//
//  Created by Padmapriya Trishul on 11/13/15.
//  Copyright © 2015 Padmapriya Trishul. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {

    @IBOutlet weak var latitude: UITextField!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var longitude: UITextField!
    
    @IBOutlet weak var descriptionView: UITextView!
    var lat:String!
    var result:NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        longitude.userInteractionEnabled = false
        latitude.userInteractionEnabled = false
        descriptionView.userInteractionEnabled = false
        descriptionView.layer.borderWidth = 1
        imgView.layer.borderWidth = 1
        latitude.text = String(result["latitude"]!)
        longitude.text = String(result["longitude"]!)
        descriptionView.text = (result["description"] as! String)
        let id:Int = Int(result["id"]! as! NSNumber)
       
        
        if (result["imagetype"] as! String) != "none" && (result["imagetype"] as! String) != " "  {
            
           //requestImage(Int(result["id"]! as! NSNumber))
            Alamofire.request(.GET, "http://bismarck.sdsu.edu/city/image?id=\(id)")
                .response { (request, response, data, error) in
                    self.imgView.image = UIImage(data: data!, scale:1)
            }
           
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  /*  func requestImage(imageID:Int)
    {
        if let url = NSURL(string: "http://bismarck.sdsu.edu/city/image?id=\(imageID)") {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: downloadImage)
        task.resume()
    }
        else { print("Unable to create NSURL") }
    }
    
    func downloadImage(data:NSData?, response:NSURLResponse?, error:NSError?) -> Void { guard error == nil else {
            return }
            if data != nil {
            if let image = UIImage.init(data: data! ) {
            self.performSelectorOnMainThread("setImage:", withObject: image, waitUntilDone: false)
            } }
    }
    
    func setImage(image: NSObject) {
        let realImage = image as! UIImage
        imgView.image = realImage
    }
*/


}
