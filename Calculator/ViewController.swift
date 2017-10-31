//
//  ViewController.swift
//  Calculator
//
//  Created by Soeng Saravit on 10/25/17.
//  Copyright © 2017 Soeng Saravit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var showLabel: UILabel!
    
    @IBOutlet weak var clearButton: customButton!
    @IBOutlet weak var plusMinusButton: customButton!
    @IBOutlet weak var modulusButton: customButton!
    @IBOutlet weak var divButton: customButton!
    @IBOutlet weak var mulButton: customButton!
    @IBOutlet weak var minusButton: customButton!
    @IBOutlet weak var plusButton: customButton!
    @IBOutlet weak var equalButton: customButton!
    @IBOutlet weak var dotButton: customButton!
    @IBOutlet weak var zeroButton: customButton!
    @IBOutlet weak var oneButton: customButton!
    @IBOutlet weak var twoButton: customButton!
    @IBOutlet weak var threeButton: customButton!
    @IBOutlet weak var fourButton: customButton!
    @IBOutlet weak var fiveButton: customButton!
    @IBOutlet weak var sixButton: customButton!
    @IBOutlet weak var sevenButton: customButton!
    @IBOutlet weak var eightButton: customButton!
    @IBOutlet weak var nineButton: customButton!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    var results: Double?
    var tmpResult: Double?
    
    var showLabelText: String?
    var arithSign: String?
    
    var dotIsClicked: Bool = false
    var isChangeArithSign = false
    var isMulti = true
    
    var storeNumbers = Array(repeating: "", count: 3)//[firstNumber, arithmeticSign, secondNumber]
    
    var getLatestNum: String = ""
    
    //get number function
    func getNumbers(_ appendNum: String?) -> String
    {
        let tmpNum: String = appendNum!
        let getCurrentShowLabelText: String = showLabel.text!
        
        if getCurrentShowLabelText == ""{
            if tmpNum == "." && dotIsClicked == false{
                dotIsClicked = true
                return "0."
            }
            else if tmpNum == "0"{
                return ""
            }
            else {
                return tmpNum
            }
        }//end if
        else if getCurrentShowLabelText == "0" {
            if tmpNum == "." && dotIsClicked == false{
                dotIsClicked = true
                return "0."
            }
            else if tmpNum == "0"{
                return "0"
            }
            else {
                return tmpNum
            }
        }//end else if
        else{
            if tmpNum == "." && dotIsClicked == false{
                dotIsClicked = true
                return getCurrentShowLabelText + tmpNum
            }
            else {
                if dotIsClicked == false && tmpNum == "."{
                    return getCurrentShowLabelText + tmpNum
                }
                else if dotIsClicked == true && tmpNum == "."{
                    return getCurrentShowLabelText
                }
                else{
                    return getCurrentShowLabelText + tmpNum
                }
                
            }
        }//end else
        
    }
    //end get number function

    
    //format double
    func format(_ number: Double) -> String {
        return String(format: "%g", number)
    }
    
    
    
    //number button (11 buttons in action)
    @IBAction func numberButtons(_ sender: customButton)
    {
        if sender.currentTitle == "+/-" {
            if showLabel.text == ""{
                showLabel.text = "-0"
            }
            
            else if showLabel.text![(showLabel.text?.startIndex)!] == "-" {
                showLabel.text!.removeFirst()
                
                if storeNumbers[0] != ""{
                    storeNumbers[0] = showLabel.text!
                }
                
                if getLatestNum != "" && storeNumbers[0] == ""{
                    getLatestNum.removeFirst()
                }
            }
            else{
                showLabel.text = "-" + showLabel.text!
                getLatestNum = "-" + getLatestNum
                //storeNumbers[0] = showLabel.text!
                
                if storeNumbers[0] != ""{
                    storeNumbers[0] = showLabel.text!
                }
                
                if getLatestNum != "" && storeNumbers[0] == ""{
                    getLatestNum.removeFirst()
                }
            }
        }
            
            
//            ត្រូវធ្វើលក្ខខណ្ឌកន្លែលនេះថែម
        else {
            getLatestNum = getNumbers(sender.currentTitle)
            print("\(getLatestNum)")
            showLabel.text = getLatestNum
        }
        
        if storeNumbers[0] != "" && storeNumbers[1] != ""{
            isChangeArithSign = false
            isMulti = true
        }
        
    }

    //arithmetic button (6 buttons in action)
    @IBAction func arithmeticButton(_ sender: customButton)
    {
        arithSign = sender.currentTitle
        dotIsClicked = false
        
        //ប្រមាណវិធីមិនអាចធ្វើនៅទីនេះបានទេ
        if storeNumbers[0] == ""{
            
            storeNumbers[0] = getLatestNum
            storeNumbers[1] = arithSign!
            
            getLatestNum = ""
            showLabel.text = ""
            resultLabel.text = storeNumbers[0] + " " + arithSign! + " "
            isChangeArithSign = true
            print(storeNumbers[1])
            return
        }
        
        if storeNumbers[0] != "" && isChangeArithSign == true{
            resultLabel.text = storeNumbers[0] + " " + arithSign! + " "
            storeNumbers[1] = arithSign!
            showLabel.text = ""
            print(storeNumbers[1])
            return
        }
        
        //ការធ្វើប្រមាណវីធីតគ្នានិងនៅទីនេះ
        if storeNumbers[0] != "" && storeNumbers[1] != "" && isMulti == true{
            
            storeNumbers[2] = getLatestNum
            
            getLatestNum = ""
            showLabel.text = ""
            
            resultLabel.text = storeNumbers[0] + " " + storeNumbers[1] + " " + storeNumbers[2]
            
            var result: Double?
            switch storeNumbers[1] {
            case "+":
                result = Double(storeNumbers[0])! + Double(storeNumbers[2])!
                break
            case "-":
                result = Double(storeNumbers[0])! - Double(storeNumbers[2])!
                break
            case "×":
                result = Double(storeNumbers[0])! * Double(storeNumbers[2])!
                break
            case "÷":
                result = Double(storeNumbers[0])! / Double(storeNumbers[2])!
                break
            case "%":
                result = Double(storeNumbers[0])!.truncatingRemainder(dividingBy: Double(storeNumbers[2])!)
                break
            default:
                print("meme")
            }
            
            resultLabel.text = format(result!) + " " + arithSign! + " "
            showLabel.text = ""
            storeNumbers[0] = String(format(result!))
            storeNumbers[1] = arithSign!
            storeNumbers[2] = ""
            isChangeArithSign = true
            isMulti = false
            
        }
        
        
    }
    
    @IBAction func equalButton(_ sender: customButton)
    {
        if storeNumbers[0] != "" && storeNumbers[1] != ""{
            storeNumbers[2] = getLatestNum
            
            getLatestNum = ""
            showLabel.text = ""
            
            resultLabel.text = storeNumbers[0] + " " + storeNumbers[1] + " " + storeNumbers[2]
            
            var result: Double?
            switch storeNumbers[1] {
            case "+":
                result = Double(storeNumbers[0])! + Double(storeNumbers[2])!
                break
            case "-":
                result = Double(storeNumbers[0])! - Double(storeNumbers[2])!
                break
            case "×":
                result = Double(storeNumbers[0])! * Double(storeNumbers[2])!
                break
            case "÷":
                result = Double(storeNumbers[0])! / Double(storeNumbers[2])!
                break
            case "%":
                result = Double(storeNumbers[0])!.truncatingRemainder(dividingBy: Double(storeNumbers[2])!)
                break
            default:
                print("meme")
            }
            
            resultLabel.text = storeNumbers[0] + " " + arithSign! + " " + storeNumbers[2]
            showLabel.text = format(result!)
            storeNumbers[0] = String(format(result!))
            storeNumbers[1] = ""
            storeNumbers[2] = ""
            isChangeArithSign = true
            isMulti = false
            
        }
    }
    
    //clear button (one button in action)
    @IBAction func clearButton(_ sender: customButton)
    {
        results = 0.0
        showLabelText = ""
        dotIsClicked = false
        arithSign = ""
        
        showLabel.text = "0"
        resultLabel.text = ""
        storeNumbers = Array(repeating: "", count: 3)
        getLatestNum = ""
        
        dotIsClicked = false
        isChangeArithSign = false
        isMulti = true
        
    }
}



@IBDesignable class customButton: UIButton {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
           self.layer.cornerRadius = self.cornerRadius
        }
    }
    
}











