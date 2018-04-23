//
//  CreateAccountSecController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/4/9.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit

class CreateAccountSecController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,UITextViewDelegate {
    
//    @IBOutlet weak var picker: UIPickerView!
//    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var picker: UIPickerView!

//    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var spTextField: UITextField!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //textView.delegate = self
        spTextField.delegate = self
        
        
        
        picker.delegate = self
        picker.dataSource = self
        
        textView!.layer.borderWidth = 0.7
        textView!.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        textView!.layer.cornerRadius = 5.0
        
        pickerData = ["What is your first pet's name?", "Where did your mother and father meet?", "What is your favourite food?", "What is your favourite sport?", "What is your best friend's name?"]
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.4, animations: {
            self.view.frame.origin.y = -220
        })
    }
    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//    }
//
//    func textView (_ textView: UITextView, shouldChangeTextIn range:NSRange, replacementText text:String) -> Bool {
//        if(text == "\n"){
//            textView.resignFirstResponder()
//            return false
//        }
//
//        if range.location >= 20 {
//            let alertController = UIAlertController(title: "Attention", message: "You can input up to 50 words", preferredStyle:  .alert)
//
//            let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
//
//        alertController.addAction(okAction)
//        self.present(alertController, animated: true, completion: nil)
//
//            return false
//        }
//        return true
//    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4, animations: {
            self.view.frame.origin.y = -220
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing( _ textField: UITextField)
    {
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else{
            return true
        }
        
        let textLength = text.count + string.count - range.length
        
        return textLength<=8
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
