//
//  CreateAccountController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/4/9.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit
import CoreData

class CreateAccountController: UIViewController, UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {


    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var secTextField: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerData: [String] = [String]()
    
//    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        emailTextField.delegate = self
        pwdTextField.delegate = self
        secTextField.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerData = ["What is your first pet's name?", "Where did your mother and father meet?", "What is your favourite food?", "What is your favourite sport?", "What is your best friend's name?"]
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
    
//    @IBAction func funcBtn(_ confirmBtn: UIButton) {
//        let app = UIApplication.shared.delegate as! AppDelegate
//        let context = app.persistentContainer.viewContext
//
//        //创建User对象
//        let user = NSEntityDescription.insertNewObject(forEntityName: "User",
//                                                       into: context) as! User
//
//        //对象赋值
//
//        let usrname = self.idTextField.text
//        let password = self.pwdTextField.text
//
//        user.username = usrname
//        user.password = password
//
//        //保存
//        do {
//            try context.save()
//            print("Saved Successfully")
//        } catch {
//            let alertController = UIAlertController(title: "Attention", message: "Save failed", preferredStyle:  .alert)
//
//            let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
//
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    @IBAction func DoneBtn(_ sender: UIBarButtonItem) {
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //given attributes values
        
        let usrname = self.idTextField.text
        let password = self.pwdTextField.text
        let email = self.emailTextField.text
        
        //check for duplicates
        
        let fetchRequest = NSFetchRequest<User>(entityName:"User")
        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        var predicateArray = Array<NSPredicate>()
        predicateArray.append(NSPredicate(format: "username = %@", usrname!))
        //        predicateArray.append(NSPredicate(format: "password = %@", password!))
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicateArray)
        fetchRequest.predicate = compoundPredicate
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            
            let count = fetchedObjects.count
            
            if count > 0 {
                let alertController = UIAlertController(title: "Attention", message: "This username has already been registered, please take another one!", preferredStyle:  .alert)
                
                let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
        }
        catch {
            let alertController = UIAlertController(title: "Attention", message: "You can input up to 50 words", preferredStyle:  .alert)
            
            let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        //create User object
        let user = NSEntityDescription.insertNewObject(forEntityName: "User",
                                                       into: context) as! User
        
        user.username = usrname!
        user.password = password!
        user.email = email!
        
        //save
        do {
            try context.save()
            print("Saved Successfully")
        } catch let err as NSError{
            print (err.debugDescription)
        }
        
        UserDefaultGetter.addName(usrname!)

        self.performSegue(withIdentifier: "SaveAndBack", sender: usrname)
    }
    
    func get_uuid() -> String {
        
        if UserDefaultGetter.getName() != nil {
            let username = UserDefaultGetter.getName()
            return username!
        }
        
        else {
            let uuid_ref = CFUUIDCreate(nil)
            let uuid_string_ref = CFUUIDCreateString(nil, uuid_ref)
            let uuid = uuid_string_ref as! String
            UserDefaults.standard.set(uuid, forKey: "name")
            return uuid
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveAndBack"{
//            let controller = segue.destination as! HomepageViewController
//            controller.itemTitle = sender as? String
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
