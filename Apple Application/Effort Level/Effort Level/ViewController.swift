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


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkInput(){
        if(timeText.text != ""){
            timeBool = true;
            timeText.textColor = UIColor.black
        }
        else{
            timeText.textColor = UIColor.red
        }
        if(distanceText.text != ""){
            distanceBool = true;
            distanceText.textColor = UIColor.black
        }
        else{
            distanceText.textColor = UIColor.red
        }
    }
    
    func parseTime(){
        top: if(timeBool == false || distanceBool == false){
            break top
        }
        else{
            let str = timeText.text
            let count = str?.count
            if(count! < 6 ){
                //time is less than 1 min
                let sub1 = str?.split(separator: ".")
                seconds = Int(String(sub1![0]))!
                hundreths = Int(String(sub1![1]))!
            }
            else{
                //time is more than 1 min
                let sub1 = str?.split(separator: ".")
                minutes = Int(String(sub1![0]))!
                seconds = Int(String(sub1![1]))!
                hundreths = Int(String(sub1![2]))!
            }
        }
    }
    
    @IBAction func buttonClick(sender: UIButton) {
        checkInput()
        parseTime()
    }


}

