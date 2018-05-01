//
//  NewPlanViewController.swift
//  OnceMemory
//
//  Created by Rui Huang on 4/22/18.
//  Copyright © 2018 BaikalSeal. All rights reserved.
//

import UIKit
import CoreData

class NewPlanViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var numDaysField: UITextField!
    @IBOutlet weak var numLessonsField: UITextField!
    @IBOutlet weak var priority: UISlider!
    @IBOutlet weak var marked: UISwitch!
    
    let step: Float = 1
    
    @IBAction func saveNewPlan(_ sender: UIBarButtonItem) {
        let username = UserDefaultGetter.getName()
        if titleField.text?.count == 0 {
            let alertController = UIAlertController(title: "Attention", message:
                "Please enter the title of your plan", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else if numDaysField.text?.count == 0 {
            let alertController = UIAlertController(title: "Attention", message:
                "Please enter the number of days to review", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else if numLessonsField.text?.count == 0 {
            let alertController = UIAlertController(title: "Attention", message:
                "Please enter the number of lessons to review", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            self.addNewPlan(username, titleField.text!, categoryField.text!, Int16(numDaysField.text!)!, Int16(numLessonsField.text!)!, Int16(priority.value), marked.isOn)
            performSegue(withIdentifier: "toHomepage", sender: self)
        }
        
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleField.delegate = self
        self.categoryField.delegate = self
        self.numDaysField.delegate = self
        self.numLessonsField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let roundedValue = Int(round(sender.value / step) * step)
        sender.value = Float(roundedValue)
    }
    
    func addNewPlan(_ username: String?, _ title: String, _ category: String?, _ numDays: Int16, _ numLessons: Int16, _ priority: Int16, _ marked: Bool) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let plan = NSEntityDescription.insertNewObject(forEntityName: "Plan", into: context) as! Plan
        
        plan.username = username
        plan.title = title
        plan.category = category
        plan.numDays = numDays
        plan.numLessons = numLessons
        plan.priority = priority + 1
        plan.marked = marked
        
        do {
            try context.save()
            print("a new plan added successfully!")
        } catch {
            let alertController = UIAlertController(title: "Attention", message: "New plan insertion Failed", preferredStyle:  .alert)
            
            let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4, animations: {
            self.view.frame.origin.y = -100
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
