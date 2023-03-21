//
//  QuizViewController.swift
//  Sample Quiz
//
//  Created by USER on 2023/03/11.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class QuizViewController: UIViewController {
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var quizTextView: UITextView!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var judgeImageView: UIImageView!
    
    var bannerView: GADBannerView!
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    var selectGenre = 0
    var player: AVAudioPlayer?
    var bgmPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.adUnitID = "ca-app-pub-8019786431500792/3295341004"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
        
        csvArray = loadCSV(fileName: "quiz\(selectGenre)")
        csvArray.shuffle()
        
        quizArray = csvArray[quizCount].components(separatedBy: ",")

        quizNumberLabel.text = "第\(quizCount + 1)問"
        quizTextView.text = quizArray[0]
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
        
        answerButton1.layer.borderWidth = 2
        answerButton1.layer.borderColor = UIColor.black.cgColor
        answerButton2.layer.borderWidth = 2
        answerButton2.layer.borderColor = UIColor.black.cgColor
        answerButton3.layer.borderWidth = 2
        answerButton3.layer.borderColor = UIColor.black.cgColor
        answerButton4.layer.borderWidth = 2
        answerButton4.layer.borderColor = UIColor.black.cgColor
        
        sound(resourceName: "クイズ出題1")
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
    }
    
    @IBAction func btnAction(sender: UIButton) {
        if sender.tag == Int(quizArray[1]) {
            correctCount += 1
            print("○")
            judgeImageView.image = UIImage(named: "correct")
            sound(resourceName: "クイズ正解1")
        } else {
            print("×")
            judgeImageView.image = UIImage(named: "incorrect")
            sound(resourceName: "クイズ不正解1")
        }
        print("Score:\(correctCount)")
        self.judgeImageView.isHidden = false
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        if sender.tag == 1 {
            answerButton1.backgroundColor = UIColor.gray
        } else if sender.tag == 2 {
            answerButton2.backgroundColor = UIColor.gray
        } else if sender.tag == 3 {
            answerButton3.backgroundColor = UIColor.gray
        } else {
            answerButton4.backgroundColor = UIColor.gray
        }
        if Int(quizArray[1]) == 1 {
            answerButton1.backgroundColor = UIColor.red
        } else if Int(quizArray[1]) == 2 {
            answerButton2.backgroundColor = UIColor.red
        } else if Int(quizArray[1]) == 3 {
            answerButton3.backgroundColor = UIColor.red
        } else {
            answerButton4.backgroundColor = UIColor.red
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.judgeImageView.isHidden = true
            self.nextQuiz()
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            self.answerButton1.backgroundColor = UIColor.white
            self.answerButton2.backgroundColor = UIColor.white
            self.answerButton3.backgroundColor = UIColor.white
            self.answerButton4.backgroundColor = UIColor.white
        }
    }
    
    func nextQuiz() {
        quizCount += 1
        if quizCount < csvArray.count {
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizCount + 1)問"
            quizTextView.text = quizArray[0]
            answerButton1.setTitle(quizArray[2], for: .normal)
            answerButton2.setTitle(quizArray[3], for: .normal)
            answerButton3.setTitle(quizArray[4], for: .normal)
            answerButton4.setTitle(quizArray[5], for: .normal)
            sound(resourceName: "クイズ出題1")
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
            print(quizCount)
            print(correctCount)
            if Double(correctCount) / Double(quizCount) < 0.3 {
                sound(resourceName: "目が点になる")
            } else if Double(correctCount) / Double(quizCount) < 0.5 {
                sound(resourceName: "間抜け1")
            } else if Double(correctCount) / Double(quizCount) < 0.8 {
                sound(resourceName: "キラッ2")
            } else if Double(correctCount) / Double(quizCount) < 1.0 {
                sound(resourceName: "歓声と拍手")
            } else {
                sound(resourceName: "教会の祈り")
            }
        }
    }
    
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        } catch {
            print("error")
        }
        return csvArray
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [
            NSLayoutConstraint(item: bannerView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: view.safeAreaLayoutGuide,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: bannerView,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0)
            ]
        )
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
