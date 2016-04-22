//
//  ResultViewController.swift
//  Spring
//
//  Created by 嶋本夏海 on 2016/03/23.
//  Copyright © 2016年 嶋本夏海. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var scoreLabel : UILabel! = UILabel()
    var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text = String(appDelegate.scoreNum)
        scoreLabel.textColor = UIColor.whiteColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back() {
        let startViewController: StartViewController = self.storyboard?.instantiateViewControllerWithIdentifier("startVC") as! StartViewController
        self.presentViewController(startViewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
