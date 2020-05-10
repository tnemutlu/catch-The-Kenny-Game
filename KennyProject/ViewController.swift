//
//  ViewController.swift
//  KennyProject
//
//  Created by TANRIKUT NEMUTLU on 9.05.2020.
//  Copyright © 2020 TANRIKUT NEMUTLU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    

    
    var timer = Timer ()
    var counter = 0
    var score = 0
    var kennyArray = [UIImageView] ()
    var hideTimer = Timer ()
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "HardScore: \(highScore)"
        }
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        
        kenny1.addGestureRecognizer(gestureRecognizer1)
        kenny2.addGestureRecognizer(gestureRecognizer2)
        kenny3.addGestureRecognizer(gestureRecognizer3)
        kenny4.addGestureRecognizer(gestureRecognizer4)
        kenny5.addGestureRecognizer(gestureRecognizer5)
        kenny6.addGestureRecognizer(gestureRecognizer6)
        kenny7.addGestureRecognizer(gestureRecognizer7)
        kenny8.addGestureRecognizer(gestureRecognizer8)
        kenny9.addGestureRecognizer(gestureRecognizer9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
    
        
        counter = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        hideKenny()
        
       
        
    
    }
    
    @objc func hideKenny () {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
        kennyArray[random].isHidden = false
        
    }
    
    
    
    @objc func timerFunc () {
        timeLabel.text = String(counter)
        counter -= 1
        
        if counter == -1 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray {
            kenny.isHidden = true
            }
            
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "HighScore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            
            
            
        }
        
        if counter == -1 {
            let alert = UIAlertController.init(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            
            let retryButton = UIAlertAction.init(title: "Retry", style: UIAlertAction.Style.default) { (UIAlertAction) in
                // replay function
                
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                self.hideKenny()
                
            }
            alert.addAction(retryButton)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
   

    
    
    @objc func scoreFunc () {
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        
    }
    
}

     
     




