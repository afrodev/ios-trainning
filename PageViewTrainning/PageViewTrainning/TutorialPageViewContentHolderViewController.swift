//
//  TutorialPageViewContentHolderViewController.swift
//  PageViewTrainning
//
//  Created by Humberto Vieira de Castro on 3/29/16.
//  Copyright © 2016 Humberto Vieira de Castro. All rights reserved.
//

import UIKit

class TutorialPageViewContentHolderViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageFileName: String!
    var pageIndex: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
