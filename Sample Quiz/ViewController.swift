//
//  ViewController.swift
//  Sample Quiz
//
//  Created by USER on 2023/03/11.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    var player: AVAudioPlayer?
    var sePlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.black.cgColor
        
        sound(resourceName: "retroparty")
    }

    @IBAction func startButtonAction(_ sender: Any) {
        if let soundURL = Bundle.main.url(forResource: "決定ボタンを押す35", withExtension: "mp3") {
            do {
                sePlayer = try AVAudioPlayer(contentsOf: soundURL)
                sePlayer?.play()
            } catch {
                print("error")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let genreVC = segue.destination as! SelectGenreViewController
        genreVC.bgmPlayer = player
    }
    
    func sound(resourceName: String) {
        if let soundURL = Bundle.main.url(forResource: resourceName, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
                player?.numberOfLoops = -1
                player?.play()
                player?.volume = 0.3
            } catch {
                print("error")
            }
        }
    }
    
}

