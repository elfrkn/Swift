//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Calis Family on 3.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // Veriable
    
    var score=0
    var timer=Timer()
    var counter=0
    var kennyArray=[UIImageView]()
    var hideTimer=Timer()
    var highScore=0

    // Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text="Score: \(score)"
        
        // HighScore Check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore=0
            highscoreLabel.text="Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore=newScore
            highscoreLabel.text="Highscore: \(highScore)"
        }
        
        
        //İmages
        
        kenny1.isUserInteractionEnabled=true
        kenny2.isUserInteractionEnabled=true
        kenny3.isUserInteractionEnabled=true
        kenny4.isUserInteractionEnabled=true
        kenny5.isUserInteractionEnabled=true
        kenny6.isUserInteractionEnabled=true
        kenny7.isUserInteractionEnabled=true
        kenny8.isUserInteractionEnabled=true
        kenny9.isUserInteractionEnabled=true
        
        kennyArray=[kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        let recognizer1=UITapGestureRecognizer(target: self, action: #selector(totalScore))
        let recognizer2=UITapGestureRecognizer(target: self, action: #selector(totalScore))
        let recognizer3=UITapGestureRecognizer(target: self, action: #selector(totalScore))
        let recognizer4=UITapGestureRecognizer(target: self, action: #selector(totalScore))
        let recognizer5=UITapGestureRecognizer(target: self, action: #selector(totalScore))
        let recognizer6=UITapGestureRecognizer(target: self, action: #selector(totalScore))
        let recognizer7=UITapGestureRecognizer(target: self, action: #selector(totalScore))
        let recognizer8=UITapGestureRecognizer(target: self, action: #selector(totalScore))
        let recognizer9=UITapGestureRecognizer(target: self, action: #selector(totalScore))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        // Tİmers
        
        counter=10
        timeLabel.text = "\(counter)"
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        hideTimer=Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
    
        hideKenny()
        
        
    }
    
    
    @objc func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        
        // Rasgele sayı oluşturmak
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
        
    }

    @objc func totalScore(){
        
        score += 1
        scoreLabel.text="Score: \(score)"
        
    }
    
    @objc func timerFunction(){
        
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter==0 {
            timer.invalidate()
            hideTimer.invalidate()
            // oyun bittiğinde kenny'nin gözükmemesş için
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            //HighScore
            if self.score > self.highScore {
                self.highScore=self.score
                highscoreLabel.text="Highscore: \(highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
           
            
            //Alert
            
            let alert=UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton=UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel,handler: nil)
            
            let replayButton=UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){
                //Replay Function
                (UIAlertAction) in
                self.score=0
                self.scoreLabel.text="Score: \(self.score)"
                self.counter=10
                self.timeLabel.text=String(self.counter)
                
                self.timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
                self.hideTimer=Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
                
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true,completion: nil)
        }
    }
}

