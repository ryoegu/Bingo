//
//  ViewController.swift
//  Bingo
//
//  Created by Ryo Eguchi on 2015/09/13.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    
    let maxNumber: Int = 39
    var numberArray: [Int] = []
    @IBOutlet var shuffleButton: UIButton!
    var isShuffle: Bool = true
    
    

    
    @IBOutlet var historyTextView: UITextView!
    var timer: NSTimer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTapped() {
        if isShuffle {
            shuffleAnimation()
            isShuffle = false
            shuffleButton.setTitle("ストップ", forState: .Normal)
            
        }else{
            //ストップボタン
            timer.invalidate()
            isShuffle = true
            shuffleButton.setTitle("スタート", forState: .Normal)
            decisionNumber()
            NSLog("%@",numberArray)
        }
    }
    
    func shuffleAnimation() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("shuffle"), userInfo: nil, repeats: true)

        timer.fire()
    }
    
    func shuffle() {
        let randomNumber: Int = Int(arc4random_uniform(UInt32(maxNumber)))
        label.text = String(randomNumber)
    }
    
    func decisionNumber() {
        var randomNumber: Int = Int(arc4random_uniform(UInt32(maxNumber)))+1
        while checkForMultiple(randomNumber) == true {
            randomNumber = Int(arc4random_uniform(UInt32(maxNumber)))
        }
        
        
        numberArray.append(randomNumber)
        historyTextView.text = historyTextView.text + "\n" + String(stringInterpolationSegment: numberArray.last!)
        label.text = String(randomNumber)
        
    }
    
    func checkForMultiple(number: Int) -> Bool{
        var isMultiple: Bool = false
        for_number: for num in numberArray {
            if number == num {
                NSLog("重複が見つかりました")
                return true
            }
        }
        return false
    }
    


}

