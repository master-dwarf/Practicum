//
//  ViewController.swift
//  Effort Level
//
//  Created by Impiraltwinky on 6/5/18.
//  Copyright © 2018 Grady Hilgendorf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Elements declatation
    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var distanceText: UITextField!
    @IBOutlet weak var enteredTime: UITextField!
    @IBOutlet weak var enteredDistace: UITextField!
    @IBOutlet weak var colorStack:UIStackView!
    @IBOutlet weak var timeStack:UIStackView!
    
    //Private variables
    private var minutes:Int = 0
    private var seconds:Int = 0
    private var hundreths:Int = 0
    private var timeBool: Bool = false
    private var distance:Int = 0
    private var distanceBool: Bool = false
    private var colorList = [UIColor.white,UIColor.red,UIColor.orange,UIColor.yellow,UIColor.green,UIColor.cyan,UIColor.gray]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkInput(){
        if(timeText.text != ""){
            timeBool = true;
        }
        if(distanceText.text != ""){
            if(Int(distanceText.text!)! < 3000){
                distanceBool = true;
            }
        }
    }
    
    func parseTime(){
        top: if(timeBool == false){
            break top
        }
        else{
            if((timeText.text?.split(separator: ".").count)! <= 2 ){
                //time is less than 1 min
                let sub1 = timeText.text?.split(separator: ".")
                seconds = Int(String(sub1![0]))!
                hundreths = Int(String(sub1![1]))!
            }
            else{
                //time is more than 1 min
                let sub1 = timeText.text?.split(separator: ".")
                minutes = Int(String(sub1![0]))!
                seconds = Int(String(sub1![1]))!
                hundreths = Int(String(sub1![2]))!
            }
            let stringHunds = String(hundreths)
            hundreths = Int(String(stringHunds.prefix(2)))!
        }
    }
    
    func parseDistance(){
        top: if(distanceBool == false){
            break top
        }
        else {
            let distanceCopy = Double(distanceText.text!)!
            let q = distanceCopy.truncatingRemainder(dividingBy: 25.0)
            if(q > 0 && q < 12.5) {
                distance = Int(distanceCopy - q)
            }
            else if(q >= 12.5 && q < 25){
                distance = Int(distanceCopy + (25-q))
            }
            else{
                distance = Int(distanceCopy)
            }
        }
    }
    
    func Calculations(){
        displaycollected()
        let totalTime = Double((minutes) * 60) + Double(seconds) + (Double(hundreths)/100)
        let laps = distance / 50
        var counter = 100
        var timeText = ""
        var colorPicker = 0
        
        //Run Through all of the iterations
        var base = Double(totalTime) / Double(laps)
        while(counter >= 75){
            timeText = ""
            timeText.append(String(Int(counter)) + "%: ")
            var x = base * Double(laps)
            if(counter != 100){
                x = x * 1.05
            }
            base = x / Double(laps)
            base = (base * 100).rounded()
            base = base / 100
            if(base.truncatingRemainder(dividingBy: 0.1) > 0.095 && base.truncatingRemainder(dividingBy: 0.1) < 0.1){
                timeText.append(String(base) + "0 ")
            }
            else {
                timeText.append(String(base) + " ")
            }
            counter = counter - 5
            colorPicker = colorPicker + 1
            labelMaker(time: timeText, color: colorList[Int(colorPicker)])
        }

    }
    
    func labelMaker(time: String, color: UIColor){
        let yourLabel: UILabel = UILabel()
        yourLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        yourLabel.backgroundColor = color
        yourLabel.textColor = UIColor.black
        yourLabel.textAlignment = NSTextAlignment.center
        yourLabel.text = time
        timeStack.addArrangedSubview(yourLabel)
    }
    
    func reset(){
        minutes = 0
        seconds = 0
        hundreths = 0
        distance = 0
        timeBool = false
        distanceBool = false
        timeText.text = ""
        distanceText.text = ""
    }
    
    func displaycollected() {
        while(seconds >= 60){
            seconds = seconds - 60
            minutes = minutes + 1
        }
        enteredTime.text = String(minutes) + ":"
        if(seconds == 0){
            enteredTime.text = enteredTime.text! + (String(seconds) + "0.")
        }
        else{
            enteredTime.text = enteredTime.text! + String(seconds) + "."
        }
        if(hundreths == 0){
            enteredTime.text = enteredTime.text! + (String(hundreths) + "0")
        }
        else{
            enteredTime.text = enteredTime.text! + String(hundreths)
        }
        enteredDistace.text = String(distance)
    }
    
    @IBAction func buttonClick(sender: UIButton) {
        for subUIView in timeStack.subviews as [UIView] {
            subUIView.removeFromSuperview()
        }
        checkInput()
        parseTime()
        parseDistance()
        if(timeBool != false && distanceBool != false){
            Calculations()
            reset()
        }
    }


}

