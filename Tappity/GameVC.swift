//
//  ViewController.swift
//  Tappity
//
//  Created by James  on 29/5/17.
//  Copyright © 2017 James . All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet var btnVerticalCenter: NSLayoutConstraint!
    @IBOutlet var btnHorizontalCenter: NSLayoutConstraint!
    
    // @IBOutlet var highScoresView: ViewController //
    
    var isTimeRunning = false
    var countdown: Timer!
    var time = 5
    var score = 0
    var newBtnX: CGFloat?
    var newBtnY: CGFloat?
    
    var colourArray = [UIColor.red,UIColor.green,UIColor.blue,UIColor.brown,UIColor.yellow,UIColor.orange,UIColor.gray,UIColor.purple,UIColor.magenta,UIColor.lightGray]
    
    override func viewDidLayoutSubviews() {
        if let buttonX = newBtnX {
            btn.center.x = buttonX
        }
        if let buttonY = newBtnY {
            btn.center.y = buttonY
        }
    }
    
    @IBAction func btnTapped(_ sender: Any) {
        score += 1
        scoreLabel.text = "\(score)"
        if isTimeRunning == false {
            btnVerticalCenter.isActive = false
            btnHorizontalCenter.isActive = false
            timer()
        }
        isTimeRunning = true
        let random = Int(arc4random_uniform(10))
        self.view.backgroundColor = colourArray[random]
        randomBtnLocation()
    }
    
    func timer() {
        countdown = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(GameVC.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func randomBtnLocation() {
        let btnWidth = btn.frame.width
        let btnHeight = btn.frame.height
        let viewWidth = btn.superview!.bounds.width
        let viewHeight = btn.superview!.bounds.height
        let xwidth = viewWidth - btnWidth
        let yheight = viewHeight - btnHeight
        let xoffset = CGFloat(arc4random_uniform(UInt32(xwidth)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(yheight)))
        newBtnX = xoffset + btnWidth / 2
        newBtnY = yoffset + btnHeight / 2
        btn.center.x = newBtnX!
        btn.center.y = newBtnY!
    }
    
    func updateTimer() {
        self.time -= 1
        self.timeLabel.text = "\(self.time)"
        if time == 0 {
            gameover()
        }
    }
    
    func gameover() {
        countdown.invalidate()
        isTimeRunning = false
        newBtnX = self.view.frame.width / 2
        newBtnY = self.view.frame.height / 2
        btn.center.x = newBtnX!
        btn.center.y = newBtnY!
        btnVerticalCenter.isActive = true
        btnHorizontalCenter.isActive = true
        let message = "Game over \nYour score is \(score)"
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Dismiss",
                                   style: .default,
                                   handler: {action in
                                    self.reset()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func reset() {
        time = 5
        score = 0
        timeLabel.text = "\(time)"
        scoreLabel.text = "\(score)"
        self.view.backgroundColor = UIColor.white
    }
    
}

