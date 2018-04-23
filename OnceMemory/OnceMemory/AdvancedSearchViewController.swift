//
//  AdvancedSearchViewController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/4/20.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit

class AdvancedSearchViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var cateTextField: UITextField!
    
    @IBOutlet weak var slider: UISlider!
    
    
    var marked: Bool?
    
    var alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    let step: Float = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.slider.isContinuous = true
        self.titleTextField.delegate = self
        self.cateTextField.delegate = self
        
//        self.marked = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if titleTextField == textField {
            guard let text = textField.text else {
                return true
            }

            let aSet = NSCharacterSet(charactersIn:alphabet).inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")

            let textLength = text.count + string.count - range.length
            
            return textLength < 24 && string == numberFiltered
        }
        else if cateTextField == textField {
            guard let text = textField.text else {
                return true
            }
            
            let aSet = NSCharacterSet(charactersIn:alphabet).inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            
            let textLength = text.count + string.count - range.length
            
            return textLength < 24 && string == numberFiltered
        }
        return true
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let roundedValue = Int(round(sender.value / step) * step)
        sender.value = Float(roundedValue)
    }
    
    
    @IBAction func funcYes(_ sender: Any) {
        self.marked = true
    }
    
    @IBAction func funcNo(_ sender: Any) {
        self.marked = false
    }
    
    @IBAction func funcBtn(_ sender: UIButton) {
        
        var itemKeyValue = Dictionary<String, Any>()
        
        if self.titleTextField.text?.count != 0 {
            itemKeyValue["title"] = self.titleTextField.text
        }
        if self.cateTextField.text?.count != 0 {
            itemKeyValue["cate"] = self.cateTextField.text
        }
        itemKeyValue["priority"] = Int(self.slider.value)
        if self.marked != nil {
            itemKeyValue["marked"] = self.marked
        }
        
        self.performSegue(withIdentifier: "AdvancedResult", sender: itemKeyValue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AdvancedResult"{
            let senderDict = sender as! Dictionary<String, Any>
            let controller = segue.destination as! AdvnacedResultViewController
            var priority: Int
            priority = senderDict["priority"] as! Int
            priority = priority + 1
            controller.itemTitle = senderDict["title"] as? String
            controller.itemPriority = priority
            controller.itemCate = senderDict["cate"] as? String
            controller.itemMarked = senderDict["marked"] as? Bool
        }
    }
    
    
    
    
//    @IBAction func radioYes(_ sender: Any) {
////        titleTextField.text = "yes"
//    }
//
//    @IBAction func radioNo(_ sender: Any) {
////        titleTextField.text = "no"
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
