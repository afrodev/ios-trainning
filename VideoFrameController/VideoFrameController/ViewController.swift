//
//  ViewController.swift
//  VideoFrameController
//
//  Created by Humberto Vieira de Castro on 3/30/16.
//  Copyright © 2016 Humberto Vieira de Castro. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVAudioPlayerDelegate {

    @IBOutlet weak var sliderVideo: UISlider!
    @IBOutlet weak var viewVideo: UIView!
    @IBOutlet weak var buttonChooseVideo: UIButton!
    var player: AVPlayer?
    var playerController: AVPlayerViewController?
    var timer: NSTimer?
    @IBOutlet var progressBar: UIProgressView!
    //var objMoviePlayerController: MPMoviePlayerController = MPMoviePlayerController()
    var urlVideo :NSURL = NSURL()
    var avPlayerLayer: AVPlayerLayer!
    
    
    private var firstAppear = true
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if firstAppear {
            do {
                try playVideo()
                firstAppear = false
            } catch AppError.InvalidResource(let name, let type) {
                debugPrint("Could not find resource \(name).\(type)")
            } catch {
                debugPrint("Generic error")
            }
            
        }
    }
    
    private func playVideo() throws {
        
        
        guard let path = NSBundle.mainBundle().pathForResource("movie", ofType:"mov") else {
            throw AppError.InvalidResource("movie", "mov")
        }
        
        player = AVPlayer(URL: NSURL(fileURLWithPath: path))
        
        playerController = AVPlayerViewController()
        playerController!.player = player
        //player!.seekToTime()
        
        
        avPlayerLayer = AVPlayerLayer(player: player)
        view.layer.insertSublayer(avPlayerLayer, atIndex: 0)
        avPlayerLayer.frame = self.viewVideo.frame;
        
       //player!.play()
    }
    @IBAction func playTapped(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.playingVideo), userInfo: nil, repeats: true)
        player?.seekToTime(CMTime(seconds: 1/5, preferredTimescale: 1))
        player?.play()
        
    }
    
    @IBAction func pauseTapped(sender: AnyObject) {
        player?.pause()
    }
    
    func playingVideo() {
        //let percent = Float((player?.currentTime().seconds)! / (player?.currentItem?.duration.seconds)!)
        sliderVideo.maximumValue = Float((player?.currentItem?.duration.seconds)!)
        //sliderVideo.
        sliderVideo.value = Float((player?.currentTime().seconds)!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slideValueChanged(sender: AnyObject) {
        // Quando o valor mudar voltar e ir o video usando seekToTime
        player!.seekToTime(CMTime(seconds: Double(sliderVideo.value), preferredTimescale: 1))
    }

    @IBAction func buttonChooseVideoTapped(sender: AnyObject) {
        let ipcVideo = UIImagePickerController()
        ipcVideo.delegate = self
        ipcVideo.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        let kUTTypeMovieAnyObject : AnyObject = kUTTypeMovie as AnyObject
        ipcVideo.mediaTypes = [kUTTypeMovieAnyObject as! String]
        self.presentViewController(ipcVideo, animated: true, completion: nil)
            
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    }

}

enum AppError : ErrorType {
    case InvalidResource(String, String)
}