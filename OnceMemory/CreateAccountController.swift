//
//  CreateAccountController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/4/9.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit

class CreateAccountController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var repwdTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        emailTextField.delegate = self
        pwdTextField.delegate = self
        repwdTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4, animations: {
            self.view.frame.origin.y = -60
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
