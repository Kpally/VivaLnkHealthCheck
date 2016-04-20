//
//  ViewController.swift
//  Idk
//
//  Created by Kunal Palwankar on 4/18/16.
//  Copyright © 2016 Kunal Palwankar. All rights reserved.
//

import UIKit

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
    
    
    @IBAction func signIn(sender: UIButton) {
        signInBox.backgroundColor = success;
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

    
    @IBAction func rdsCheck(sender: UIButton) {
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
    
    @IBAction func redisCheck(sender: UIButton) {
        redisCache.backgroundColor = success;
        vivaLnkREST.backgroundColor = success;
        awsEC2.backgroundColor = success;
        vivaLnkWebApp.backgroundColor = success;
        dnsCloudFlare.backgroundColor = success;
        httpClient.backgroundColor = success;
        testAllButton.setTitle("Clear", forState: .Normal)
        flip = true;
    }
    
    
    @IBAction func restCheck(sender: UIButton) {
        vivaLnkREST.backgroundColor = success;
        awsEC2.backgroundColor = success;
        vivaLnkWebApp.backgroundColor = success;
        dnsCloudFlare.backgroundColor = success;
        httpClient.backgroundColor = success;
        testAllButton.setTitle("Clear", forState: .Normal)
        flip = true;
    }
    
    
    @IBAction func apnsCheck(sender: UIButton) {
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
    
    @IBAction func awsSNScheck(sender: UIButton) {
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
    

    @IBAction func snsProcessorCheck(sender: UIButton) {
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
    
    
    
    @IBAction func awsSQScheck(sender: UIButton) {
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
    
    
    @IBAction func dataUploadCheck(sender: UIButton) {
        signInBox.backgroundColor = success;
        dataUploadProcessor.backgroundColor = success;
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

