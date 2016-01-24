//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Amr Sami on 1/24/16.
//  Copyright © 2016 Amr Sami. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumbr = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation : Operation = Operation.Empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print (err.debugDescription)
        }
    }

    @IBAction func numberPressed(btn: UIButton!) {
        
        playSound()
        
        runningNumbr += "\(btn.tag)"
        outputLbl.text = runningNumbr
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        
        playSound()
        
        if currentOperation != Operation.Empty {
            //run some math
            
            if runningNumbr != "" {
                
                rightValStr = runningNumbr
                runningNumbr = ""
                
                switch currentOperation {
                case Operation.Divide:
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                case Operation.Multiply:
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                case Operation.Subtract:
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                case Operation.Add:
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                default:
                    result = ""
                }
                
                leftValStr = result
                outputLbl.text = result
                
            }
            
            currentOperation = op
            
        } else {
            //this is the first time an operation has been pressed
            if runningNumbr != "" {
                
                leftValStr = runningNumbr
                runningNumbr = ""
                currentOperation = op
            }
        }
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        playSound()
        
        result = ""
        runningNumbr = ""
        outputLbl.text = runningNumbr
        currentOperation = Operation.Empty
        leftValStr = ""
        rightValStr = ""
        
        
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }

}

