//
//  CustomTableViewController.swift
//  PullRefreshTableView
//
//  Created by Humberto Vieira de Castro on 3/28/16.
//  Copyright © 2016 Humberto Vieira de Castro. All rights reserved.
//

import UIKit

class CustomTableViewController: UITableViewController {
    var arrayAnyText = ["JBSON", "LUIS", "FERNANDINHO", "MOHAMED", "EITA POXA TO BOM!", "QUE DOIDO ESSA FITA"]
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var timer: NSTimer?
    
    override func viewDidLoad() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.enabled = true
        self.refreshControl?.backgroundColor = UIColor.redColor()
        self.refreshControl?.tintColor = UIColor.yellowColor()
        // Colocar as imagens do Refresh Animation View
        
//        tableView.addSubview(refreshControl!)
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        let refreshAnimation = NSBundle.mainBundle().loadNibNamed("RefreshAnimationView", owner: self, options: nil).last as! RefreshAnimationView
        
        //refreshAnimation.frame =  // CGRect(x: 0, y: 0, width: self.refreshControl, height: self.refreshControl.height)
        refreshAnimation.initWithImages(self.refreshControl!.frame)
        refreshAnimation.resume()
        self.refreshControl!.addSubview(refreshAnimation)
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(CustomTableViewController.shutdownRefresh), userInfo: nil, repeats: true)
        //tableView.addSubview(refreshAnimation)
        
    }
    
    func shutdownRefresh() {
        self.refreshControl?.endRefreshing()
    }
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) // UITableViewCell
        
        cell.textLabel?.text = arrayAnyText[indexPath.row]
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayAnyText.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
}
