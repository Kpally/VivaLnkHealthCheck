//
//  ViewController.swift
//  Idk
//
//  Created by Kunal Palwankar on 4/18/16.
//  Copyright © 2016 Kunal Palwankar. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {

    @IBOutlet weak var signInBox: UILabel!
    @IBOutlet weak var aWSRDS: UILabel!
    @IBOutlet weak var rESTAPI: UILabel!
    @IBOutlet weak var redisCache: UILabel!
    @IBOutlet weak var vivaLnkREST: UILabel!
    @IBOutlet weak var awsEC2: UILabel!
    @IBOutlet weak var vivaLnkWebApp: UILabel!
    @IBOutlet weak var dnsCloudFlare: UILabel!
    @IBOutlet weak var httpClient: UILabel!
    @IBOutlet weak var apns: UILabel!
    @IBOutlet weak var awsSNS: UILabel!
    @IBOutlet weak var snsProcessor: UILabel!
    @IBOutlet weak var awsSQS: UILabel!
    @IBOutlet weak var rightSideRESTapi: UILabel!
    @IBOutlet weak var dataUploadProcessor: UILabel!
    @IBOutlet weak var testAllButton: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    let neutral = UIColor(red: 204/255, green: 255/255, blue: 255/255, alpha: 1);
    let success = UIColor(red: 6/255, green: 198/255, blue: 64/255, alpha: 1);
    let fail = UIColor(red: 255/255, green: 71/255, blue: 26/255, alpha: 1);
    var flip = false;
    static var token = "no"
    static let baseURL = "http://vivalnkwebtest-env.us-west-1.elasticbeanstalk.com";
    static let email = "breakfastturkey@gmail.com";
    static let password = "234567";
    static var signInsucceed = false
    static var redisSucceed = false
    static var restSucceed = false
    static var rdsSucceed = false
    static var sqsSucceed = false
    static var snspSucceed = false
    static var snsSucceed = false
    static var apnsSucceed = false
    static var dataUpSucceed = false
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsButton.layer.cornerRadius = 5;
        testAllButton.layer.cornerRadius = 5;
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func signIn() -> Bool
    {
        var ifSuccess = 0;

        
        if let url = NSURL(string: baseURL)
        {
            let URLRequest = NSMutableURLRequest(URL: url)
            URLRequest.setValue("Content-Type", forHTTPHeaderField: "application/json")
            Alamofire.request(.POST, baseURL+"/api/signin", parameters: ["email": email, "password": password], encoding: .JSON)
                .responseJSON { response in
                    if let httpError = response.result.error {
                        let statusCode = httpError.code
                        ifSuccess = statusCode;
                    } else { //no errors
                        let statusCode = (response.response?.statusCode)!
                        ifSuccess = statusCode;
                    }
                    
                    

                    if (ifSuccess == 200) {
                        
                        let myToken = (response.response!.allHeaderFields["Authorization"] as! String)
                        token = myToken
                        signInsucceed = true
                        
                        
                        
                        
                    } else {
                        signInsucceed = false
                     
                    }
                    
            }
        }

        return signInsucceed
    }
    
    func signInSuccess()
    {
        
        if ViewController.signIn() == true
        {
            self.signInBox.backgroundColor = self.success;
            self.aWSRDS.backgroundColor = self.success;
            self.rESTAPI.backgroundColor = self.success;
            self.redisCache.backgroundColor = self.success;
            self.vivaLnkREST.backgroundColor = self.success;
            self.awsEC2.backgroundColor = self.success;
            self.vivaLnkWebApp.backgroundColor = self.success;
            self.dnsCloudFlare.backgroundColor = self.success;
            self.httpClient.backgroundColor = self.success;
            self.testAllButton.setTitle("Clear", forState: .Normal)
            self.flip = true;


        }
        
        else{
            self.signInBox.backgroundColor = self.fail;
            self.testAllButton.setTitle("Clear", forState: .Normal)
            self.flip = true;

        }
        
    }
    
    static func restCheck() -> Bool
    {
        
        if (token == "no")
        {
            print ("not ready")
        }
        
        var ifSuccess = 0;
        
        Alamofire.request(.GET, baseURL)
            .responseString { response in
                if let httpError = response.result.error {
                    let statusCode = httpError.code
                    ifSuccess = statusCode;
                    print (statusCode);
                } else { //no errors
                    let statusCode = (response.response?.statusCode)!
                    print (statusCode);
                    ifSuccess = statusCode;
                }
                
                if (ifSuccess == 200)
                {
                    restSucceed = true;
                }
                    
                else{
                    
                    
//                    self.vivaLnkREST.backgroundColor = self.fail;
//                    self.awsEC2.backgroundColor = self.fail;
//                    self.vivaLnkWebApp.backgroundColor = self.fail;
//                    self.dnsCloudFlare.backgroundColor = self.fail;
//                    self.httpClient.backgroundColor = self.fail;
//                    self.testAllButton.setTitle("Clear", forState: .Normal)
//                    self.flip = true;
                    restSucceed = false;
                }
                
        }
         //print (token);
        return restSucceed
    }
    
    static func redisCheck() -> Bool
    {
        //print (token)
        var ifSuccess = 0;
        
        
        if let url = NSURL(string: baseURL)
        {
            let URLRequest = NSMutableURLRequest(URL: url)
            URLRequest.setValue("Content-Type", forHTTPHeaderField: "application/json")
            URLRequest.setValue("Authorization", forHTTPHeaderField: token)
            URLRequest.setValue("email", forHTTPHeaderField: email)
            URLRequest.setValue("password", forHTTPHeaderField: password)
            
            
           // Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = ["Authorization": token]
            let headers = ["Authorization" : token, "email": email, "password": password]
            
            Alamofire.request(.GET, baseURL+"/api/healthcheck/redis", headers: headers)
                .responseJSON { response in
                    if let httpError = response.result.error {
                        let statusCode = httpError.code
                        ifSuccess = statusCode;

                    } else { //no errors
                        let statusCode = (response.response?.statusCode)!
                        ifSuccess = statusCode;
//                        print (statusCode)
//                        print ("hello")
//                        print(token)
              
                    }
                    
                    
                    
                    if (ifSuccess == 200) {
                        


                        //print ("yay")
                        redisSucceed = true;
                        //print (redisSucceed)
                        
                        
                        
                        
                    } else {
                        
//                        print ("nah")
//                        print (ifSuccess)
                        redisSucceed = false;
                       // print (redisSucceed)
                    }
                    
            }
        }
        
       // print (redisSucceed)
        print ("This should be first " + String (redisSucceed))
        return redisSucceed
        
    }
    
    func redisSuccess()
    {
        
        
        if ViewController.redisCheck() == true
        {
            self.redisCache.backgroundColor = self.success;
            self.vivaLnkREST.backgroundColor = self.success;
            self.awsEC2.backgroundColor = self.success;
            self.vivaLnkWebApp.backgroundColor = self.success;
            self.dnsCloudFlare.backgroundColor = self.success;
            self.httpClient.backgroundColor = self.success;
            self.testAllButton.setTitle("Clear", forState: .Normal)
            self.flip = true;
            
            
        }
            
        else{
            self.redisCache.backgroundColor = self.fail;
            self.testAllButton.setTitle("Clear", forState: .Normal)
            print(ViewController.redisCheck())
            self.flip = true;
    }
        
    }
    
    
    @IBAction func signIn(sender: UIButton) {
        

        ViewController.signIn()
        delay(2.0)
        {
            self.signInSuccess();
        }
    }
    
    static func rdsCheck() -> Bool{
        
        
        //print (token)
        var ifSuccess = 0;
        
        
        if let url = NSURL(string: baseURL)
        {
            let URLRequest = NSMutableURLRequest(URL: url)
            URLRequest.setValue("Content-Type", forHTTPHeaderField: "application/json")
            URLRequest.setValue("Authorization", forHTTPHeaderField: token)
            URLRequest.setValue("email", forHTTPHeaderField: email)
            URLRequest.setValue("password", forHTTPHeaderField: password)
            
            
            // Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = ["Authorization": token]
            let headers = ["Authorization" : token, "email": email, "password": password]
            
            Alamofire.request(.GET, baseURL+"/api/healthcheck/rds", headers: headers)
                .responseJSON { response in
                    if let httpError = response.result.error {
                        let statusCode = httpError.code
                        ifSuccess = statusCode;
                        
                    } else { //no errors
                        let statusCode = (response.response?.statusCode)!
                        ifSuccess = statusCode;
                        //                        print (statusCode)
                        //                        print ("hello")
                        //                        print(token)
                        
                    }
                    
                    
                    
                    if (ifSuccess == 200) {
                        
                        
                        
                        //print ("yay")
                        rdsSucceed = true;
                        //print (redisSucceed)
                        
                        
                        
                        
                    } else {
                        
                        //                        print ("nah")
                        //                        print (ifSuccess)
                        rdsSucceed = false;
                        // print (redisSucceed)
                    }
                    
            }
        }
        
        // print (redisSucceed)
        
        return rdsSucceed
    }
    
    
    func rdsSuccess()
    {
        if (ViewController.rdsCheck())
        {
            aWSRDS.backgroundColor = success;
            rESTAPI.backgroundColor = success;
            redisCache.backgroundColor = success;
            vivaLnkREST.backgroundColor = success;
            awsEC2.backgroundColor = success;
            vivaLnkWebApp.backgroundColor = success;
            dnsCloudFlare.backgroundColor = success;
            httpClient.backgroundColor = success;
            testAllButton.setTitle("Clear", forState: .Normal)
            flip = true;
        }
        
        else{
            aWSRDS.backgroundColor = fail;
            testAllButton.setTitle("Clear", forState: .Normal)
            flip = true;
        }
    }

    
    @IBAction func rdsCheck(sender: UIButton) {
        ViewController.signIn()
        ViewController.rdsCheck()
        delay(2.0)
        {
            self.rdsSuccess()
        }
    }
    
    @IBAction func redisCheck(sender: UIButton) {
        
        ViewController.signIn()
        ViewController.redisCheck()
        
        delay(2.0)
        {
            self.redisSuccess()
        }
        

    }
    

 
     func delay(delay: Double, closure: ()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
    }
    
    static func delay(delay: Double, closure: ()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
    }
    
    
    @IBAction func restCheck(sender: UIButton) {
        ViewController.signIn()
//        let userDefaults = NSUserDefaults.standardUserDefaults()
//        print(userDefaults .objectForKey("token"))
        
        delay(2.0)
        {
               ViewController.restCheck();
        }
     
        
     
    }
    
    static func apnsCheck() -> Bool
    {
        var ifSuccess = 0;
        
        
        if let url = NSURL(string: baseURL)
        {
            let URLRequest = NSMutableURLRequest(URL: url)
            URLRequest.setValue("Content-Type", forHTTPHeaderField: "application/json")
            URLRequest.setValue("Authorization", forHTTPHeaderField: token)
            URLRequest.setValue("email", forHTTPHeaderField: email)
            URLRequest.setValue("password", forHTTPHeaderField: password)
            
            
            // Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = ["Authorization": token]
            let headers = ["Authorization" : token, "email": email, "password": password]
            let parameters = ["accountId": "152", "deviceToken": "212121", "message": "Notification Triggered"]
            
            Alamofire.request(.POST, baseURL+"/api/triggerNotification", headers: headers, parameters: parameters, encoding: .JSON)
                .responseString { response in
                    if let httpError = response.result.error {
                        let statusCode = httpError.code
                        ifSuccess = statusCode;
                        
                    } else { //no errors
                        let statusCode = (response.response?.statusCode)!
                        ifSuccess = statusCode;
                        //                        print (statusCode)
                        //                        print ("hello")
                        //                        print(token)
                        
                    }
                    
                    
                    
                    if (ifSuccess == 200) {
                        
                        
                        
                        //print ("yay")
                        apnsSucceed = true;
                        //print (redisSucceed)
                        
                        
                        
                        
                    } else {
                        
                        //                        print ("nah")
                        //                        print (ifSuccess)
                        apnsSucceed = false;
                        // print (redisSucceed)
                    }
                    
            }
        }
        
        // print (redisSucceed)
        print ("This should be first " + String (redisSucceed))
        
        return apnsSucceed
    }
    
    func apnsSuccess()
    {
        if (ViewController.apnsSucceed)
        {
            apns.backgroundColor = success;
            awsSNS.backgroundColor = success;
            snsProcessor.backgroundColor = success;
            awsSQS.backgroundColor = success;
            rightSideRESTapi.backgroundColor = success;
            redisCache.backgroundColor = success;
            vivaLnkREST.backgroundColor = success;
            awsEC2.backgroundColor = success;
            vivaLnkWebApp.backgroundColor = success;
            dnsCloudFlare.backgroundColor = success;
            httpClient.backgroundColor = success;
            testAllButton.setTitle("Clear", forState: .Normal)
            flip = true;
        }
        else{
            apns.backgroundColor = fail;
            testAllButton.setTitle("Clear", forState: .Normal)
            flip = true;
        }
    }
    
    
    @IBAction func apnsCheck(sender: UIButton) {
        ViewController.signIn()
        ViewController.apnsCheck()
        
        delay(2.0)
        {
            self.apnsSuccess()
        }
    }
    
    static func snsCheck() -> Bool
    {
        var ifSuccess = 0;
        
        
        if let url = NSURL(string: baseURL)
        {
            let URLRequest = NSMutableURLRequest(URL: url)
            URLRequest.setValue("Content-Type", forHTTPHeaderField: "application/json")
            URLRequest.setValue("Authorization", forHTTPHeaderField: token)
            URLRequest.setValue("email", forHTTPHeaderField: email)
            URLRequest.setValue("password", forHTTPHeaderField: password)
            
            
            // Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = ["Authorization": token]
            let headers = ["Authorization" : token, "email": email, "password": password]
            
            Alamofire.request(.GET, baseURL+"/api/healthcheck/awsSNS?email="+email+"&message=NotificationForMe", headers: headers)
                .responseJSON { response in
                    if let httpError = response.result.error {
                        let statusCode = httpError.code
                        ifSuccess = statusCode;
                        
                    } else { //no errors
                        let statusCode = (response.response?.statusCode)!
                        ifSuccess = statusCode;
                        //                        print (statusCode)
                        //                        print ("hello")
                        //                        print(token)
                        
                    }
                    
                    
                    
                    if (ifSuccess == 200) {
                        
                        
                        
                        //print ("yay")
                        snsSucceed = true;
                        //print (redisSucceed)
                        
                        
                        
                        
                    } else {
                        
                        //                        print ("nah")
                        //                        print (ifSuccess)
                        snsSucceed = false;
                        // print (redisSucceed)
                        }
                    
            }
        }
        

        
        return snsSucceed
    }
    
    func snsSuccess()
    {
        if(ViewController.snsCheck())
        {
            awsSNS.backgroundColor = success;
            snsProcessor.backgroundColor = success;
            awsSQS.backgroundColor = success;
            rightSideRESTapi.backgroundColor = success;
            redisCache.backgroundColor = success;
            vivaLnkREST.backgroundColor = success;
            awsEC2.backgroundColor = success;
            vivaLnkWebApp.backgroundColor = success;
            dnsCloudFlare.backgroundColor = success;
            httpClient.backgroundColor = success;
            testAllButton.setTitle("Clear", forState: .Normal)
            flip = true;
        }
        
        else{
            awsSNS.backgroundColor = fail;
            testAllButton.setTitle("Clear", forState: .Normal)
            flip = true;
        }
    }
    
    @IBAction func awsSNScheck(sender: UIButton) {
     
        ViewController.signIn()
        ViewController.snsCheck()
        
        delay(2.0)
        {
            self.snsSuccess()
        }
        
    }
    
    static func snspCheck() -> Bool
    {
        //print (token)
        var ifSuccess = 0;
        
        
        if let url = NSURL(string: baseURL)
        {
            let URLRequest = NSMutableURLRequest(URL: url)
            URLRequest.setValue("Content-Type", forHTTPHeaderField: "application/json")
            URLRequest.setValue("Authorization", forHTTPHeaderField: token)
            URLRequest.setValue("email", forHTTPHeaderField: email)
            URLRequest.setValue("password", forHTTPHeaderField: password)
            
            
            // Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = ["Authorization": token]
            let headers = ["Authorization" : token, "email": email, "password": password]
            
            Alamofire.request(.GET, baseURL+"/api/healthcheck/snsProcessor", headers: headers)
                .responseJSON { response in
                    if let httpError = response.result.error {
                        let statusCode = httpError.code
                        ifSuccess = statusCode;
                        
                    } else { //no errors
                        let statusCode = (response.response?.statusCode)!
                        ifSuccess = statusCode;
                        //                        print (statusCode)
                        //                        print ("hello")
                        //                        print(token)
                        
                    }
                    
                    
                    
                    if (ifSuccess == 200) {
                        
                        
                        
                        print ("yay")
                        snspSucceed = true;
                        //print (redisSucceed)
                        
                        
                        
                        
                    } else {
                        
                                                print ("nah")
                        //                        print (ifSuccess)
                        snspSucceed = false;
                        // print (redisSucceed)
                    }
                    
            }
        }

        
        return snspSucceed
    }
    
    func snspSuccess()
    {
        if(ViewController.snspCheck())
        {
            snsProcessor.backgroundColor = success;
            awsSQS.backgroundColor = success;
            rightSideRESTapi.backgroundColor = success;
            redisCache.backgroundColor = success;
            vivaLnkREST.backgroundColor = success;
            awsEC2.backgroundColor = success;
            vivaLnkWebApp.backgroundColor = success;
            dnsCloudFlare.backgroundColor = success;
            httpClient.backgroundColor = success;
            testAllButton.setTitle("Clear", forState: .Normal)
            flip = true;
        }
            
        else{
            snsProcessor.backgroundColor = fail;
            testAllButton.setTitle("Clear", forState: .Normal)
            flip = true;
        }
    }

    @IBAction func snsProcessorCheck(sender: UIButton) {
        ViewController.signIn()
        ViewController.snspCheck()
        
        delay(8.0)
        {
            self.snspSuccess()
        }

    }
    
    static func sqsCheck() -> Bool{
     
        //print (token)
        var ifSuccess = 0;
        
        
        if let url = NSURL(string: baseURL)
        {
            let URLRequest = NSMutableURLRequest(URL: url)
            URLRequest.setValue("Content-Type", forHTTPHeaderField: "application/json")
            URLRequest.setValue("Authorization", forHTTPHeaderField: token)
            URLRequest.setValue("email", forHTTPHeaderField: email)
            URLRequest.setValue("password", forHTTPHeaderField: password)
            
            
            // Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = ["Authorization": token]
            let headers = [ "Authorization" : token, "email": email, "password": password]
            
            Alamofire.request(.GET, baseURL+"/api/healthcheck/temperatureSQS", headers: headers)
                .responseJSON { response in
                    if let httpError = response.result.error {
                        let statusCode = httpError.code
                        ifSuccess = statusCode;
                        
                    } else { //no errors
                        let statusCode = (response.response?.statusCode)!
                        ifSuccess = statusCode;
                        //                        print (statusCode)
                        //                        print ("hello")
                        //                        print(token)
                        
                    }
                    
                    
                    
                    if (ifSuccess == 200) {
                        
                        
                        
                        print ("yay")
                        sqsSucceed = true;
                        //print (redisSucceed)
                        
                        
                        
                        
                    } else {
                        
                        //                        print ("nah")
                        //                        print (ifSuccess)
                        sqsSucceed = false;
                        // print (redisSucceed)
                    }
                    
            }
        }
        
        // print (redisSucceed)
        
        return sqsSucceed
    }
    
    func sqsSuccess()
    {
        if (ViewController.sqsCheck())
        {
            awsSQS.backgroundColor = success;
            rightSideRESTapi.backgroundColor = success;
            redisCache.backgroundColor = success;
            vivaLnkREST.backgroundColor = success;
            awsEC2.backgroundColor = success;
            vivaLnkWebApp.backgroundColor = success;
            dnsCloudFlare.backgroundColor = success;
            httpClient.backgroundColor = success;
            testAllButton.setTitle("Clear", forState: .Normal)
            flip = true;
        }
        
        else{
            awsSQS.backgroundColor = fail;
            testAllButton.setTitle("Clear", forState: .Normal)
            flip = true;
        }
    }
    
    @IBAction func awsSQScheck(sender: UIButton) {
        ViewController.signIn()
        ViewController.sqsCheck()
        
        delay(2.0)
        {
            self.sqsSuccess()
        }
    }
    
    static func dataUploadCheck() -> Bool
    {
        var ifSuccess = 0;
        
        
        if let url = NSURL(string: baseURL)
        {
            let URLRequest = NSMutableURLRequest(URL: url)
            URLRequest.setValue("Content-Type", forHTTPHeaderField: "application/json")
            URLRequest.setValue("Authorization", forHTTPHeaderField: token)
            URLRequest.setValue("email", forHTTPHeaderField: email)
            URLRequest.setValue("password", forHTTPHeaderField: password)
            
            
            // Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = ["Authorization": token]
            let headers = ["Authorization" : token, "email": email, "password": password]
            
            Alamofire.request(.GET, baseURL+"/api/healthcheck/temperatureProcessor", headers: headers)
                .responseString { response in
                    if let httpError = response.result.error {
                        let statusCode = httpError.code
                        ifSuccess = statusCode;
                        debugPrint(response)
                        
                    } else { //no errors
                        let statusCode = (response.response?.statusCode)!
                        ifSuccess = statusCode;
                        debugPrint(response)
                        //                        print (statusCode)
                        //                        print ("hello")
                        //                        print(token)
                        
                    }
                    
                    
                    
                    if (ifSuccess == 200) {
                        
                        
                        
                        //print ("yay")
                        dataUpSucceed = true;
                        //print (redisSucceed)
                        
                        
                        
                        
                    } else {
                        
                        //                        print ("nah")
                        //                        print (ifSuccess)
                        dataUpSucceed = false;
                        // print (redisSucceed)
                    }
                    
            }
        }
        
        // print (redisSucceed)
        

        
        
        return dataUpSucceed
    }
    
    func dataUpSuccess()
    {
       
       
        if(ViewController.dataUploadCheck())
        {
            self.signInBox.backgroundColor = self.success;
            self.dataUploadProcessor.backgroundColor = self.success;
            self.awsSQS.backgroundColor = self.success;
            self.rightSideRESTapi.backgroundColor = self.success;
            self.redisCache.backgroundColor = self.success;
            self.vivaLnkREST.backgroundColor = self.success;
            self.awsEC2.backgroundColor = self.success;
            self.vivaLnkWebApp.backgroundColor = self.success;
            self.dnsCloudFlare.backgroundColor = self.success;
            self.httpClient.backgroundColor = self.success;
            self.testAllButton.setTitle("Clear", forState: .Normal)
            self.flip = true;
        }
            
        else{
            self.signInBox.backgroundColor = self.fail;
            self.testAllButton.setTitle("Clear", forState: .Normal)
            self.flip = true;
        }

        
        
            }
    
    
    @IBAction func dataUploadCheck(sender: UIButton) {
        ViewController.signIn()
        ViewController.dataUploadCheck()
        
        delay(8.0)
        {
            self.dataUpSuccess()
        }
    }
    
    
    @IBAction func resetCheck(sender: UIButton) {
        if(flip)
        {
            signInBox.backgroundColor = neutral;
            aWSRDS.backgroundColor = neutral;
            rESTAPI.backgroundColor = neutral;
            redisCache.backgroundColor = neutral;
            vivaLnkREST.backgroundColor = neutral;
            awsEC2.backgroundColor = neutral;
            vivaLnkWebApp.backgroundColor = neutral;
            dnsCloudFlare.backgroundColor = neutral;
            httpClient.backgroundColor = neutral;
            apns.backgroundColor = neutral;
            awsSQS.backgroundColor = neutral;
            awsSNS.backgroundColor = neutral;
            snsProcessor.backgroundColor = neutral;
            awsSQS.backgroundColor = neutral;
            rightSideRESTapi.backgroundColor = neutral;
            dataUploadProcessor.backgroundColor = neutral;
            testAllButton.setTitle("Test All", forState: .Normal)
            flip = false;
        }
        
        else
        {
            signInBox.backgroundColor = success;
            aWSRDS.backgroundColor = success;
            rESTAPI.backgroundColor = success;
            redisCache.backgroundColor = success;
            vivaLnkREST.backgroundColor = success;
            awsEC2.backgroundColor = success;
            vivaLnkWebApp.backgroundColor = success;
            dnsCloudFlare.backgroundColor = success;
            httpClient.backgroundColor = success;
            apns.backgroundColor = success;
            awsSNS.backgroundColor = success;
            awsSQS.backgroundColor = success;
            snsProcessor.backgroundColor = success;
            awsSQS.backgroundColor = success;
            rightSideRESTapi.backgroundColor = success;
            dataUploadProcessor.backgroundColor = success;
            testAllButton.setTitle("Clear", forState: .Normal)
            flip = true;
        }
    }
}

