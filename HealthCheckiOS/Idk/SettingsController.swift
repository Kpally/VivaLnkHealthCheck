//
//  SettingsController.swift
//  VivaLnk HealthCheck
//
//  Created by Kunal Palwankar on 5/9/16.
//  Copyright © 2016 Kunal Palwankar. All rights reserved.
//

import UIKit

class SettingsController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var testlabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    
    var idk = "";
    var idk2 = "";
    
    
    override func viewDidLoad() {
        backButton.layer.cornerRadius = 5
        super.viewDidLoad()
        textField.text = ViewController.email
        passwordField.text = ViewController.password
        self.textField.delegate = self
        self.passwordField.delegate = self
        
        changeMessage()
        

        // Do any additional setup after loading the view.
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    func changeMessage()
    {
        if NSUserDefaults.standardUserDefaults().boolForKey("message")
        {
            testlabel.text = "You are testing the main site"
        }
 
        else
        {
            testlabel.text = "You are testing the test site"
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func mainButton(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().setObject("http://vivalnkwebapp.us-west-1.elasticbeanstalk.com/", forKey: "site")
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "message")
        testlabel.text = "You are testing the main site"
        }
    
    
    @IBAction func testButton(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().setObject("http://vivalnkwebtest-env.us-west-1.elasticbeanstalk.com/", forKey: "site")
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "message")
        testlabel.text = "You are testing the test site"
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
    func setEverything() -> Bool
    {
        
        return false
    }
    
    @IBAction func saveEmail(sender: UITextField) {
        textField.resignFirstResponder()
        
        idk = textField.text!
        emailSaved()
    }
    
    func emailSaved()
    {
        NSUserDefaults.standardUserDefaults().setObject(textField.text, forKey: "email")
        ViewController.email = idk
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func savePass(sender: UITextField) {
        passwordField.resignFirstResponder()
        
        idk2 = passwordField.text!
        passSaved()
        
    }
    
    func passSaved()
    {
        NSUserDefaults.standardUserDefaults().setObject(passwordField.text, forKey: "password")
        ViewController.password = idk2
    }
    


    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
