//
//  AddViewController.swift
//  Potholes
//
//  Created by Padmapriya Trishul on 11/14/15.
//  Copyright © 2015 Padmapriya Trishul. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class AddViewController: UIViewController ,UIImagePickerControllerDelegate,CLLocationManagerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate{

   
    @IBOutlet weak var latitude: UITextField!
    
    @IBOutlet weak var longitude: UITextField!
    
    @IBOutlet weak var descriptionView: UITextView!
    
    @IBOutlet weak var imgView: UIImageView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    var picker:UIImagePickerController? = UIImagePickerController()
    
    
    @IBOutlet weak var add: UIButton!
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: self.view.window)
        add.enabled = false
        latitude.userInteractionEnabled = false
        longitude.userInteractionEnabled = false
        picker?.delegate = self
        descriptionView.delegate = self
        descriptionView.layer.borderWidth = 1
        imgView.layer.borderWidth = 1
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }

    @IBAction func uploadPhoto(sender: UIButton) {  //upload photo from library
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(picker!, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
         let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgView.contentMode = .ScaleAspectFit
            imgView.image = chosenImage
        dismissViewControllerAnimated(true, completion: nil)
    
    
    }
    
    
    @IBAction func addButton(sender: UIButton) {
        
        
        let lat = Double(latitude.text!)
        let lng = Double(longitude.text!)
        let txt = String(descriptionView.text!)
        if imgView.image == nil && latitude.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "" &&  longitude.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "" {
            
            let url = "http://bismarck.sdsu.edu/city/report"
            let parameters :[String : AnyObject] = ["type":"street", "user":"abc469","imagetype":"none","description": txt,
                "latitude":lat!,"longitude":lng!]
            Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON) .responseJSON { response in
                if let data = response.result.value {
                    print(data)
                }
                }
                .responseString { response in
                    if let errorString = response.result.value {
                        print(errorString)
                    } }
            
        }else{
            let image:UIImage = imgView.image!
            let imageData = UIImageJPEGRepresentation(image,0.0)
            let base64:String = imageData!.base64EncodedStringWithOptions(
                NSDataBase64EncodingOptions.EncodingEndLineWithLineFeed)
        let url = "http://bismarck.sdsu.edu/city/report"
        let parameters :[String : AnyObject] = ["type":"street", "user":"abc469","imagetype":"jpg","description": txt,
            "latitude":lat!,"longitude":lng!,"image":base64]
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON) .responseJSON { response in
            if let data = response.result.value {
                print(data)
            }
            }
            .responseString { response in
                if let errorString = response.result.value {
                    print(errorString)
                } }
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textViewDidChange(textView: UITextView) {
        if textView.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "" && latitude.text != "" && longitude.text != ""{
            add.enabled = true
            
        }
        if textView.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" {
            add.enabled = false
            
        }

    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if(text == "\n") {  // hide keyboard on click of return
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        self.view.frame.origin.y += keyboardSize.height
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        
        if keyboardSize.height == offset.height {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y -= keyboardSize.height
            })
        } else {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height - offset.height
            })
        }
    }
    
    @IBAction func cameraButton(sender: UIButton) { // upload photo from camera
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerControllerSourceType.Camera
            picker!.cameraCaptureMode = .Photo
            presentViewController(picker!, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style:.Default, handler: nil)
            alert.addAction(ok)
            presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func locationManager(manager: CLLocationManager,
                        didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
        
        latitude.text = String(Double(location.coordinate.latitude))
        longitude.text = String(Double(location.coordinate.longitude))
        print(location.coordinate.latitude)
        
        }
    }
    
   

}
