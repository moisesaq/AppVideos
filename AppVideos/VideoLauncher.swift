//
//  VideoLauncher.swift
//  AppVideos
//
//  Created by Moises on 8/15/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let keyPathForPlayer = "currentItem.loadedTimeRanges"
    
    let activityIndicatorView: UIActivityIndicatorView = {
       let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true;
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    var isPlaying = false
    
    func handlePause(){
        print("Pause")
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named:"play"), for: .normal)
        }else{
            player?.play()
            pausePlayButton.setImage(UIImage(named:"pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        playVideo()
        addControls()
    }
    
    private func addControls(){
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    var player: AVPlayer?
    
    private func playVideo(){
        let urlString = "https://firebasestorage.googleapis.com/v0/b/appcoer.appspot.com/o/Majin%20Buu%20quiere%20un%20beso%20en%20Latino.mp4?alt=media&token=e3122134-f96c-4b6c-aa49-fa27874a00c1"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: keyPathForPlayer, options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == keyPathForPlayer {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init has not been implemented")
    }
}

class VideoLauncher: NSObject{
    
    func showVideoPlayer(){
        print("Showing animation player.....")
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            
            let videPlayerView = VideoPlayerView(frame: getHeightVideoPlayerView(keyWindow: keyWindow))
            view.addSubview(videPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }, completion: { (completionAnimation) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
    
    private func getHeightVideoPlayerView(keyWindow: UIWindow) -> CGRect{
        //16 x 9 the aspect ratio of all HD videos
        let height = keyWindow.frame.width * 9 / 16
        return CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
    }
    
}
