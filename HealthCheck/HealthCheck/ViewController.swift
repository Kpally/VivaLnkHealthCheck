//
//  ViewController.swift
//  HealthCheck
//
//  Created by Kunal Palwankar on 4/18/16.
//  Copyright © 2016 Kunal Palwankar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func myButton(sender: UIButton) {
        myLabel.text = "Hello World";
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

