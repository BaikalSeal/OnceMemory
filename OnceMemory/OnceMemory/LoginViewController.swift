//
//  LoginViewController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/4/18.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: SuperViewController, UITextFieldDelegate {

    @IBOutlet weak var usrnameTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var naviBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usrnameTextField.delegate = self
        pwdTextField.delegate = self
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
    

    @IBAction func confirmBtn(_ button: UIButton) {
//        let alertController = UIAlertController(title: "Attention", message: "You can input up to 50 words", preferredStyle:  .alert)
//
//        let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
//
//        alertController.addAction(okAction)
//        self.present(alertController, animated: true, completion: nil)
        
        if self.usrnameTextField.text == nil || (self.usrnameTextField.text?.count)! < 3 {
            let alertController = UIAlertController(title: "Attention", message: "Username length cannot be shorter than 3!", preferredStyle:  .alert)
            
            let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        if self.pwdTextField.text == nil || (self.pwdTextField.text?.count)! < 8 {
            let alertController = UIAlertController(title: "Attention", message: "Password length cannot be shorter than 8!", preferredStyle:  .alert)
            
            let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
//
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //声明数据的请求
        let fetchRequest = NSFetchRequest<User>(entityName:"User")
        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        
        //设置查询条件
        
        let usrname = self.usrnameTextField.text!
        let pwd = self.pwdTextField.text!
//        let predicate = NSPredicate(format: "username = 'jerry' ", "password = '123456'")
        
        var predicateArray = Array<NSPredicate>()
        predicateArray.append(NSPredicate(format: "username = %@", usrname))
        predicateArray.append(NSPredicate(format: "password = %@", pwd))
//        let predicateUsrname = NSPredicate(format: "username = %@", usrname)
//        let predicatePwd = NSPredicate(format: "password = %@", pwd)
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicateArray)
        
        
        fetchRequest.predicate = compoundPredicate
        
        //查询操作
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            
            if fetchedObjects.count > 0 {
                UserDefaultGetter.addName(usrname)
                self.performSegue(withIdentifier: "toLoggedIn", sender: self)
            }
            
            else{
                let alertController = UIAlertController(title: "Attention", message: "Log in failed, your username or password may be incorrect.", preferredStyle:  .alert)
        
                let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        catch {
            let alertController = UIAlertController(title: "Attention", message: "Log in failed, your username or password may be incorrect.", preferredStyle:  .alert)
            
            let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLoggedIn"{
//            let controller = segue.destination as! HomepageViewController
//            controller.refreshData()
        }
    }
    
    override func handelNotification(notification: NSNotification) {
        guard let theme = notification.object as? ThemeProtocol else {
            return
        }
        naviBar.barTintColor = theme.navigationBarColor
        naviBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: theme.textColor]
        naviBar.tintColor = theme.barItemColor
        naviBar.isTranslucent = false
        let barView = UIView(frame: CGRect(x:0, y:0, width:view.frame.width, height:UIApplication.shared.statusBarFrame.height))
        barView.backgroundColor = theme.navigationBarColor
        self.view.addSubview(barView)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if usrnameTextField == textField {
            guard let text = textField.text else {
                return true
            }
            
            let aSet = NSCharacterSet(charactersIn:Constraints.getAlphabet()+Constraints.getNumbers()).inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            
            let textLength = text.count + string.count - range.length
            
            return textLength <= 10 && string == numberFiltered
        }
        else if pwdTextField == textField {
            guard let text = textField.text else {
                return true
            }
            
            let aSet = NSCharacterSet(charactersIn:Constraints.getAlphabet()+Constraints.getNumbers()).inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            
            let textLength = text.count + string.count - range.length
            
            return textLength <= 15 && string == numberFiltered
        }
        return true
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
