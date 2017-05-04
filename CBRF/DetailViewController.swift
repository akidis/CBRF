//
//  DetailViewController.swift
//  CBRF
//
//  Created by Andrey Kiselev on 03.05.17.
//  Copyright © 2017 Andrey Kiselev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textLabelTwo: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var textFieldOne: UITextField!
    @IBOutlet weak var equalsButton: UIButton!
    @IBOutlet weak var valValue: UILabel!
    @IBOutlet weak var nameOfValute: UILabel!
    
    var valuteValue = ""
    var nameValute = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addDoneButtonOnKeyboard()
        textLabelTwo.keyboardType = UIKeyboardType.decimalPad
        textFieldOne.keyboardType = UIKeyboardType.decimalPad
        
        
        valValue.layer.masksToBounds = true
        valValue.layer.cornerRadius = 10
        equalsButton.layer.masksToBounds = true
        equalsButton.layer.cornerRadius = 10
        
        valValue.layer.borderWidth = 0.7
        valValue.layer.borderColor = UIColor.black.cgColor
        
        equalsButton.layer.borderWidth = 0.7
        equalsButton.layer.borderColor = UIColor.black.cgColor

        valValue.text = "\(valuteValue)"
        nameOfValute.text = "\(nameValute)"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func addDoneButtonOnKeyboard()
    {
        
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: 320.0, height: 50.0))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: UIBarButtonItemStyle.done, target: self, action: #selector(DetailViewController.doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.textFieldOne.inputAccessoryView = doneToolbar
        self.textLabelTwo.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction()
    {
        self.textFieldOne.resignFirstResponder()
        self.textLabelTwo.resignFirstResponder()
        resultAct()
    }
    
    @IBAction func equalsActionButton(_ sender: Any) {
        
        self.textFieldOne.resignFirstResponder()
        self.textLabelTwo.resignFirstResponder()
        resultAct()
    
    }
    
    func resultAct () {
        
        if textFieldOne.text != "" && textLabelTwo.text == "" {
            
            let b = Double(valValue.text!)!
            
            let formatter = NumberFormatter()
            let maybeNumber = formatter.number(from: textFieldOne.text!)
            if let number = maybeNumber {
                
                let result = Double(number) / Double(b)
                resultLabel.text = String(format: "%.4f", result)
                
            }
            
        } else if textLabelTwo.text != "" && textFieldOne.text == "" {
            
            let b = valValue.text
    
            let formatter = NumberFormatter()
            let maybeNumber = formatter.number(from: textLabelTwo.text!)
            if let number = maybeNumber {
            
            let result = Double(number) * Double(b!)!
            resultLabel.text = String(format: "%.4f", result)
            
            }
                
        } else {
            
            let ac = UIAlertController(title: "Инструкция", message: "Вы вводите валюту, которую Вы хотите перевести, второе поле должно оставаться пустым!", preferredStyle: .alert)
            let acAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
            
            ac.addAction(acAction)
            present(ac, animated: true, completion: nil)
            
        }

        
    }
    
    @IBAction func clearAction(_ sender: UIBarButtonItem) {
        
        textFieldOne.text = ""
        textLabelTwo.text = ""
        resultLabel.text = ""
        self.textFieldOne.resignFirstResponder()
        self.textLabelTwo.resignFirstResponder()
    }
    
}

