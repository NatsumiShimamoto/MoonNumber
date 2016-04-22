//
//  ViewController.swift
//  Spring
//
//  Created by 嶋本夏海 on 2016/03/23.
//  Copyright © 2016年 嶋本夏海. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var number : Int! = Int(arc4random_uniform(99))
    @IBOutlet var numLabel : UILabel! = UILabel()
    @IBOutlet var multipleLabel1 : UILabel! = UILabel()
    @IBOutlet var multipleLabel2 : UILabel! = UILabel()
    
    var multipleNum1 : Int!
    var multipleNum2 : Int!
    
    var judgeLabel : UILabel! = UILabel()
    
    @IBOutlet var scoreLabel : UILabel! = UILabel()
    var scoreNumNow : Int! = 0
    
    @IBOutlet var timeLabel : UILabel! = UILabel()
    var timerCount : Float! = 30.0
    var introCount = 3
    
    var gameTimer : NSTimer!
    var introTimer : NSTimer!
    
    let screenSize = UIScreen.mainScreen().bounds.size
    
    var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var countImgView : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        countImgView = UIImageView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
        self.view.addSubview(countImgView)
        
        introTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("introCountDown"), userInfo: nil, repeats: true)
        introTimer.fire()
        
        
    }
    
    func createView() {
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("gameCountDown"), userInfo: nil, repeats: true)
        gameTimer.fire()
        
        
        self.view.addSubview(timeLabel)
        
        numLabel.text = String(number)
        self.view.addSubview(numLabel)
        
        numLabel.userInteractionEnabled = true
        
        // single swipe up
        let swipeUpGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeUp:")
        swipeUpGesture.numberOfTouchesRequired = 1  // number of fingers
        swipeUpGesture.direction = UISwipeGestureRecognizerDirection.Up
        numLabel.addGestureRecognizer(swipeUpGesture)
        
        // single swipe left
        let swipeLeftGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeLeft:")
        swipeLeftGesture.numberOfTouchesRequired = 1  // number of fingers
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Left
        numLabel.addGestureRecognizer(swipeLeftGesture)
        
        // single swipe down
        let swipeDownGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeDown:")
        swipeDownGesture.numberOfTouchesRequired = 1
        swipeDownGesture.direction = UISwipeGestureRecognizerDirection.Down
        numLabel.addGestureRecognizer(swipeDownGesture)
        
        // single swipe right
        let swipeRightGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeRight:")
        swipeRightGesture.numberOfTouchesRequired = 1  // number of fingers
        swipeRightGesture.direction = UISwipeGestureRecognizerDirection.Right
        numLabel.addGestureRecognizer(swipeRightGesture)
        
        var multipleArr = [2,3,4,5,6,7,8,9]
        var multipleArrNum : Int! = Int(arc4random_uniform(8))
        multipleNum1 = multipleArr[multipleArrNum]
        
        multipleLabel1.text = String(multipleNum1)
        
        multipleArr.removeAtIndex(multipleArrNum)
        
        multipleArrNum = Int(arc4random_uniform(UInt32(multipleArr.count)))
        multipleNum2 = multipleArr[multipleArrNum]
        
        multipleLabel2.text = String(multipleNum2)
              
        judgeLabel.frame = CGRectMake(180, 167, 45, 45)
        self.view.addSubview(judgeLabel)
        
        scoreLabel.text = String(appDelegate.scoreNum)
        
    }


    
    func introCountDown() {
        
        if(introCount == 3) {
            countImgView.image = UIImage(named: "countDown3")
        }
        if(introCount == 2) {
            countImgView.image = UIImage(named: "countDown2")
        }
        if(introCount == 1) {
            countImgView.image = UIImage(named: "countDown1")
        }
        if(introCount == 0) {
            countImgView.removeFromSuperview()
            
            createView()
        }
        introCount--
    }
    
    
    func gameCountDown() {
        timeLabel.text = String(format:"%.1f",timerCount)
        
        if(timerCount<=0.0){
            gameTimer.invalidate()
            
            let resultViewController: ResultViewController = self.storyboard?.instantiateViewControllerWithIdentifier("resultVC") as! ResultViewController
            self.presentViewController(resultViewController, animated: true, completion: nil)
        }
        timerCount = timerCount - 0.1
    }
    
    
    func judgeUp() {
        if(number % multipleNum1 == 0 && number >= multipleNum1 && number % multipleNum2 == 0 && number >= multipleNum2){
            
            correct()
        }else{
            wrong()
        }
    }
    func judgeLeft() {
        if(number % multipleNum1 == 0 && number >= multipleNum1){
            correct()
        }else{
            wrong()
        }
    }
    func judgeDown() {
        if(number % multipleNum1 == 0 && number >= multipleNum1 || number % multipleNum2 == 0 && number >= multipleNum2){
            wrong()
        }else{
            correct()
        }
    }
    func judgeRight() {
        if(number % multipleNum2 == 0 && number >= multipleNum2){
            correct()
        }else{
            wrong()
        }
    }
    
    func correct() {
        judgeLabel.text = "◯"
        scoreNumNow = appDelegate.scoreNum + 10
        scoreLabel.text = String(scoreNumNow)
        appDelegate.scoreNum = scoreNumNow
        
    }
    func wrong() {
        judgeLabel.text = "×"
        scoreNumNow = appDelegate.scoreNum - 5
        scoreLabel.text = String(scoreNumNow)
        appDelegate.scoreNum = scoreNumNow
    }
    
    func handleSwipeUp(sender: UITapGestureRecognizer){
        print("Swiped up!")
        
        UIView.animateWithDuration(0.3, animations: {() -> Void in
            self.numLabel.center = CGPoint(x: 188,y: -40);
            }, completion: {(Bool) -> Void in
                self.judgeUp()
                self.reset()
        })
    }
    func handleSwipeLeft(sender: UITapGestureRecognizer){
        print("Swiped left!")
        
        UIView.animateWithDuration(0.3, animations: {() -> Void in
            self.numLabel.center = CGPoint(x: -40,y: 366);
            }, completion: {(Bool) -> Void in
                
                self.judgeLeft()
                self.reset()
                
        })
    }
    
    func handleSwipeDown(sender: UITapGestureRecognizer){
        print("Swiped down!")
        
        UIView.animateWithDuration(0.3, animations: {() -> Void in
            self.numLabel.center = CGPoint(x: 188,y: 700);
            }, completion: {(Bool) -> Void in
                self.judgeDown()
                self.reset()
                
        })
    }
    
    func handleSwipeRight(sender: UITapGestureRecognizer){
        print("Swiped right!")
        
        UIView.animateWithDuration(0.3, animations: {() -> Void in
            self.numLabel.center = CGPoint(x: 400,y: 366);
            }, completion: {(Bool) -> Void in
                self.judgeRight()
                self.reset()
                
        })
    }
    
    func reset() {
        number = Int(arc4random_uniform(99))
        numLabel.text = String(number)
        numLabel.frame = CGRectMake(138, 310, 100, 118)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

