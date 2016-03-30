//
//  ViewController.swift
//  PageViewTrainning
//
//  Created by Humberto Vieira de Castro on 3/29/16.
//  Copyright © 2016 Humberto Vieira de Castro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource,  {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func skipButtonTaped(sender: AnyObject) {
        let nextView: TheNextViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TheNextViewController") as! TheNextViewController
        
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.window?.rootViewController = nextView
        
        
    }

}

