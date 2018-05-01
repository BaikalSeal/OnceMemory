//
//  LoginViewController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/4/18.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usrnameTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
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
                self.performSegue(withIdentifier: "toLoggedIn", sender: self)
                UserDefaultGetter.addName(usrname)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
