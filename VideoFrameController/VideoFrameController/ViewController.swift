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
import Regift



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
    var tempoAtual = 0.0
    var arrayImages: [UIImage?] = []
    
    var pathAtual: String? = ""
    
    var controleRepeticaoGesto = 4
    var quantasVezesEntrou = 0
    var imageview: UIImageView?
    
    private var firstAppear = true
    
    override func viewDidAppear(animated: Bool) {
        //       self.progressBar.progress = 0.444444444444
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
        
        self.pathAtual = path
        
        player = AVPlayer(URL: NSURL(fileURLWithPath: path))
        
        playerController = AVPlayerViewController()
        playerController!.player = player
        //player!.seekToTime()
        
        avPlayerLayer = AVPlayerLayer(player: player)
        view.layer.insertSublayer(avPlayerLayer, atIndex: 0)
        avPlayerLayer.frame = self.viewVideo.frame;
        
        //self.sliderVideo.maximumValue = player?.currentItem?.duration
        //player!.play()
    }
    
    @IBAction func playTapped(sender: AnyObject) {
        //        player?.seekToTime(CMTime(seconds: 0, preferredTimescale: 1))
        //        player?.play()
        self.imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        self.view.addSubview(imageview!)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(ViewController.chama), userInfo: nil, repeats: true)
        controleRepeticaoGesto = 0
    }
    
    func chama () {
        
        var im = arrayImages[controleRepeticaoGesto]
        controleRepeticaoGesto += 1
        if controleRepeticaoGesto > 6 {
            controleRepeticaoGesto = 0
        }
        
        
        self.imageview!.image = im!
        print("entra")
    }
    
    @IBAction func pauseTapped(sender: AnyObject) {
        transformaVideoEmImagens()
    }
    
    func transformaVideoEmImagens() {
        let asset = player?.currentItem?.asset
        
        let generator = AVAssetImageGenerator(asset: asset!)
        
        generator.appliesPreferredTrackTransform = true
        
        let tolerance = CMTimeMakeWithSeconds(0.01, 600)
        generator.requestedTimeToleranceBefore = tolerance
        generator.requestedTimeToleranceAfter = tolerance
        
        
        //        var times = [NSValue]()
        //        for time in timePoints {
        //            times.append(NSValue(CMTime: time))
        //        }
        //        
        let t = NSValue(CMTime: CMTime(seconds: 0.1, preferredTimescale: 1000))
        let t1 = NSValue(CMTime: CMTime(seconds: 0.2, preferredTimescale: 1000))
        let t2 = NSValue(CMTime: CMTime(seconds: 0.3, preferredTimescale: 1000))
        let t3 = NSValue(CMTime: CMTime(seconds: 0.4, preferredTimescale: 1000))
        let t4 = NSValue(CMTime: CMTime(seconds: 0.5, preferredTimescale: 1000))
        let t5 = NSValue(CMTime: CMTime(seconds: 0.6, preferredTimescale: 10))
        let t6 = NSValue(CMTime: CMTime(seconds: 0.7, preferredTimescale: 100))
        
        
        generator.generateCGImagesAsynchronouslyForTimes([t, t1, t2, t3, t4, t5, t6]) { (requestedTime:CMTime, image: CGImage?, actualTime:CMTime, avresult:AVAssetImageGeneratorResult, error: NSError?) in
            if error == nil {
                print("FUNFOU")
                
                
                self.arrayImages.append(UIImage(CGImage: image!))
                
                //self.view.addSubview(imageview)
                
            } else {
                print("Não funfou")
            }
        }
        
        
        
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
        
        
        
        
        player!.seekToTime(CMTime(seconds: Double(sliderVideo.value), preferredTimescale: 1/30))
    }
    
}

enum AppError : ErrorType {
    case InvalidResource(String, String)
}