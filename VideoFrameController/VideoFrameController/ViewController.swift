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
    var tempoAtual = 0.0
    
    var controleRepeticaoGesto = 4
    var quantasVezesEntrou = 0
    
    private var firstAppear = true
    
    override func viewDidAppear(animated: Bool) {
        //       self.progressBar.progress = 0.444444444444
        super.viewDidAppear(animated)
        if firstAppear {
            do {
                try playVideo()
                firstAppear = false
                
                let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
                swipeRight.direction = UISwipeGestureRecognizerDirection.Right
                
                let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
                swipeRight.direction = UISwipeGestureRecognizerDirection.Left
                
                let panGest = UIPanGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
                
                self.view.addGestureRecognizer(panGest)
                self.view.addGestureRecognizer(swipeRight)
                self.view.addGestureRecognizer(swipeLeft)
                
            } catch AppError.InvalidResource(let name, let type) {
                debugPrint("Could not find resource \(name).\(type)")
            } catch {
                debugPrint("Generic error")
            }
            
        }
    }
    
    func respondToSwipeGesture(sender: UIPanGestureRecognizer) {
        let point = sender.velocityInView(self.view)
        //print("PONTO - \(point)")
        quantasVezesEntrou += 1

        if quantasVezesEntrou % controleRepeticaoGesto == 0 {
            
        
        
        print(quantasVezesEntrou)
        
        // Foi para a direita
        if point.x > 0 {
            self.progressBar.progress += 0.0050
            
            
            self.tempoAtual += 0.1
            
            if tempoAtual <= 0 {
                tempoAtual = 1
            }
            
           // CMTimeMakeWithSeconds(<#T##seconds: Float64##Float64#>, <#T##preferredTimeScale: Int32##Int32#>)
            //CMTimeMake(Int64(self.tempoAtual), 1000)
            player!.seekToTime(CMTimeMakeWithSeconds(self.tempoAtual, 10))
            //player!.seekToTime(CMTime(seconds: self.tempoAtual, preferredTimescale: 1000))
           // player?.seekToTime(CMTime(seconds: Double(tempoAtual), preferredTimescale: 1))
        }
        // Foi para a esquerda
        else {
            self.progressBar.progress -= 0.0050
            
            self.tempoAtual -= 0.1
            if tempoAtual <= 0 {
                tempoAtual = 1
            }
            player!.seekToTime(CMTimeMakeWithSeconds(self.tempoAtual, 10))
            //player?.seekToTime(CMTime(seconds: Double(tempoAtual), preferredTimescale: 1))

        }
        
        // Foi para baixo
        if point.y > 0 {
            //self.progressBar.progress += 0.25
        }
        // Foi para cima
        else {
            
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
        //sliderVideo.maximumValue = Float((player?.currentItem?.duration.seconds)!)
        //sliderVideo.value = Float((player?.currentTime().seconds)!)
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
        //player!.seekToTime(CMTime(seconds: Double(sliderVideo.value), preferredTimescale: 100))
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