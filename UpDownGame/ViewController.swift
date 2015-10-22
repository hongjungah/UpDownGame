//
//  ViewController.swift
//  UpDownGame
//
//  Created by 홍정아 on 2015. 10. 20..
//  Copyright © 2015년 hong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedIndex = 0
    var progressValue = 0
    var randomValue = 0
    var timer : NSTimer!
    var timerValue : Int = 10
    
    @IBOutlet weak var inputNumber: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var countDown: UILabel!
    
    func initGame() {
        progressView.progress = 0.0
        count.text = "0 / 5"
        label.text = "게임시작을 누르고 숫자를 입력하세요."
        progressValue = 0
        randomValue = 0
        inputNumber.text = ""
        timerValue = 10
        getValue(selectedIndex)
        inputNumber.isFirstResponder()
    }
    
    @IBAction func startGame(sender: UIButton) {
        let interval : NSTimeInterval = 1
        timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: Selector("countDown:"), userInfo: nil, repeats: true)
    }
    
    func countDown(ntimer : NSTimer) {
        timerValue--
        if timerValue == 0 {
            showAlertMessage("타임 오버", message: "제한된 시간을 초과하였습니다.")
            timer.invalidate()
            timer = nil
        }
        else if timerValue < 0 {
            timer.invalidate()
            timer = nil
        }
        else {
            countDown.text = "\(timerValue) 초"
        }
    }
    
    @IBOutlet weak var progressView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.initGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseGame(sender: UISegmentedControl){
        initGame()
        selectedIndex = sender.selectedSegmentIndex
        getValue(selectedIndex)
    }
    
    @IBAction func enterNumber(sender: AnyObject) {
        
        if selectedIndex == 0 && Int(inputNumber.text!)! > 10 {
            label.text = "10보다 작은 숫자를 입력하세요."
            inputNumber.text = ""
        }
        else if selectedIndex == 1 && Int(inputNumber.text!)! > 50 {
            label.text = "50보다 작은 숫자를 입력하세요."
            inputNumber.text = ""
        }
        else if selectedIndex == 2 && Int(inputNumber.text!)! > 100 {
            label.text = "100보다 작은 숫자를 입력하세요."
            inputNumber.text = ""
        }
        
        if progressValue > 4 {
            showAlertMessage("게임 오버", message: "사용 횟수가 끝났습니다")
        } else {
            progressValue++
            count.text = "\(progressValue)/5"
            progressView.progress = Float("0.\(progressValue)")!
            if inputNumber.text != nil {
                if Int(inputNumber.text!)! > randomValue {
                    label.text = "입력한 숫자보다 작습니다."
                    inputNumber.text = ""
                }
                else if Int(inputNumber.text!)! < randomValue {
                    label.text = "입력한 숫자보다 큽니다."
                    inputNumber.text = ""
                }
                else {
                    label.text = "정답입니다."
                    showAlertMessage("정답", message: "정답입니다.")
                    inputNumber.text = ""
                }
            }
            getValue(selectedIndex)
        }
    }
    
    func getValue(maxValue: Int) {
        switch maxValue {
        case 0:
            randomValue = Int(arc4random())%10 + 1;
        case 1:
            randomValue = Int(arc4random())%50 + 1;
        case 2:
            randomValue = Int(arc4random())%100 + 1;
        default:
            break
        }
    }

    func showAlertMessage(title: String, message: String) {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "확인", style : UIAlertActionStyle.Default, handler: {(action) -> Void in self.initGame()})
            
        dialog.addAction(okAction)
        self.presentViewController(dialog, animated: true, completion: nil)
    }
}

