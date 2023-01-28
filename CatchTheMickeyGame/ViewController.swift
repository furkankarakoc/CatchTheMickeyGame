//
//  ViewController.swift
//  CatchTheMickeyGame
//
//  Created by Furkan Karakoc on 15.01.2023.
//

import UIKit

class ViewController: UIViewController {
     
    //MARK: Variables
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var mickeyArray = [UIImageView]()
    var highScore = 0
    
    //MARK: Views
    @IBOutlet weak var mickey1: UIImageView!
    @IBOutlet weak var mickey2: UIImageView!
    @IBOutlet weak var mickey3: UIImageView!
    @IBOutlet weak var mickey4: UIImageView!
    @IBOutlet weak var mickey5: UIImageView!
    @IBOutlet weak var mickey6: UIImageView!
    @IBOutlet weak var mickey7: UIImageView!
    @IBOutlet weak var mickey8: UIImageView!
    @IBOutlet weak var mickey9: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Score
        scoreLabel.text = "Score: \(score)"
        highScoreLabel.text = "Highscore: 0"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil{
            score = 0
            scoreLabel.text = "Score: \(score)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
            
        }
        
        //MARK: Images
        mickey1.isUserInteractionEnabled = true
        mickey2.isUserInteractionEnabled = true
        mickey3.isUserInteractionEnabled = true
        mickey4.isUserInteractionEnabled = true
        mickey5.isUserInteractionEnabled = true
        mickey6.isUserInteractionEnabled = true
        mickey7.isUserInteractionEnabled = true
        mickey8.isUserInteractionEnabled = true
        mickey9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(updateScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(updateScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(updateScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(updateScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(updateScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(updateScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(updateScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(updateScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(updateScore))
        
        mickey1.addGestureRecognizer(recognizer1)
        mickey2.addGestureRecognizer(recognizer2)
        mickey3.addGestureRecognizer(recognizer3)
        mickey4.addGestureRecognizer(recognizer4)
        mickey5.addGestureRecognizer(recognizer5)
        mickey6.addGestureRecognizer(recognizer6)
        mickey7.addGestureRecognizer(recognizer7)
        mickey8.addGestureRecognizer(recognizer8)
        mickey9.addGestureRecognizer(recognizer9)
        
        mickeyArray = [mickey1, mickey2,mickey3, mickey4, mickey5, mickey6, mickey7, mickey8, mickey9]
        //MARK: Timer
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counterDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideMickey), userInfo: nil, repeats: true)
        hideMickey()
        
       
        
    }
    
   @objc func hideMickey () {
        for mickey in mickeyArray {
            mickey.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(mickeyArray.count)))
        mickeyArray[random].isHidden = false
    }
    
    @objc func updateScore () {
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func counterDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
        
            
        //MARK: Highscore
            
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "Highscore:\(highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
           
            
        //MARK: Alert
            let alert = UIAlertController(title: "Time is over", message: "Do you want play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Reply", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay func
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.counterDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideMickey), userInfo: nil, repeats: true)
            }
                alert.addAction(okButton)
                alert.addAction(replayButton)
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
    }




