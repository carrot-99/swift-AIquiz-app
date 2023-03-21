//
//  SelectGenreViewController.swift
//  Sample Quiz
//
//  Created by USER on 2023/03/12.
//

import UIKit
import AVFoundation

class SelectGenreViewController: UIViewController {
    @IBOutlet weak var genre1Button: UIButton!
    @IBOutlet weak var genre2Button: UIButton!
    @IBOutlet weak var genre3Button: UIButton!
    @IBOutlet weak var genre4Button: UIButton!
    @IBOutlet weak var genre5Button: UIButton!
    @IBOutlet weak var genre6Button: UIButton!
    @IBOutlet weak var genre7Button: UIButton!
    @IBOutlet weak var genre8Button: UIButton!
    @IBOutlet weak var genre9Button: UIButton!
    @IBOutlet weak var genre10Button: UIButton!
    
    
    var selectTag = 0
    var bgmPlayer: AVAudioPlayer?
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        genre1Button.layer.borderWidth = 2
        genre1Button.layer.borderColor = UIColor.black.cgColor
        
        genre2Button.layer.borderWidth = 2
        genre2Button.layer.borderColor = UIColor.black.cgColor
        
        genre3Button.layer.borderWidth = 2
        genre3Button.layer.borderColor = UIColor.black.cgColor
        
        genre4Button.layer.borderWidth = 2
        genre4Button.layer.borderColor = UIColor.black.cgColor
        
        genre5Button.layer.borderWidth = 2
        genre5Button.layer.borderColor = UIColor.black.cgColor
        
        genre6Button.layer.borderWidth = 2
        genre6Button.layer.borderColor = UIColor.black.cgColor
        
        genre7Button.layer.borderWidth = 2
        genre7Button.layer.borderColor = UIColor.black.cgColor
        
        genre8Button.layer.borderWidth = 2
        genre8Button.layer.borderColor = UIColor.black.cgColor
        
        genre9Button.layer.borderWidth = 2
        genre9Button.layer.borderColor = UIColor.black.cgColor
        
        genre10Button.layer.borderWidth = 2
        genre10Button.layer.borderColor = UIColor.black.cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizVC = segue.destination as! QuizViewController
        quizVC.selectGenre = selectTag
        quizVC.bgmPlayer = bgmPlayer
    }
    
    @IBAction func genreButtonAction(sender: UIButton) {
        print(sender.tag)
        selectTag = sender.tag
        performSegue(withIdentifier: "toQuizVC", sender: nil)
        sound(resourceName: "決定ボタンを押す35")
    }
    
    func sound(resourceName: String) {
        if let soundURL = Bundle.main.url(forResource: resourceName, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
                player?.play()
            } catch {
                print("error")
            }
        }
    }
}
