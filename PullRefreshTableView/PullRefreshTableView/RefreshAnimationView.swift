//
//  RefreshAnimation.swift
//  PullRefreshTableView
//
//  Created by Humberto Vieira de Castro on 3/28/16.
//  Copyright © 2016 Humberto Vieira de Castro. All rights reserved.
//

import UIKit

class RefreshAnimationView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var arrayImages: [UIImage] = []
    var isAnimating = false
    var numImage = 0
    var timer: NSTimer?
    
    func initWithImages(frame: CGRect) {
        self.frame = frame
        self.frame.origin = CGPoint(x: 0.0, y: 0.0)
        
        for i in 0 ... 55 {
            var nameImage = "loading_white_0"
            
            if i < 10 {
                nameImage += "0"
            }
            
            nameImage += "\(i)"
            self.arrayImages.append(UIImage(named: nameImage)!)
        }
        
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.04, target: self, selector: #selector(RefreshAnimationView.updatingImagesView), userInfo: nil, repeats: true)
    }
    
    func resume() {
        self.isAnimating = true
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.alpha = 1.0
        }) { (resp) -> Void in
            self.hidden = false
        }
    }
    
    func pause() {
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.alpha = 0.0
        }) { (resp) -> Void in
            self.hidden = true
            self.isAnimating = false
        }
    }
    
    func updatingImagesView() {
        if isAnimating {
            if arrayImages.count == numImage {
                self.numImage = 0
            }
            
            self.imageView.image = self.arrayImages[numImage]
            self.numImage += 1
        }
    }
    
    func close() {
        timer = nil
        self.removeFromSuperview()
    }
    
}
