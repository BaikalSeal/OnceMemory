//
//  AddItemViewController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/4/20.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit
import CoreData

class AddItemViewController: UIViewController {

    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func funcBtn(_ addBtn: UIButton) {
        
        var cates = ["English", "Math", "Chemistry"]
        var contents = ["eng", "math", "chemi"]
        var marks = [true, false, true]
        var priorities = [0, 1, 1]
        var titles = ["Eng", "Mathematics", "Che"]
        
        for index in 0...2 {
            self.addRecords(titles[index], Int16(priorities[index]), cates[index], contents[index], marks[index])
        }
        
    }
    
    func addRecords(_ title: String, _ priority: Int16, _ cate: String, _ content: String, _ marked: Bool) {
        let app = UIApplication.shared.delegate as! AppDelegate
        
        let context = app.persistentContainer.viewContext
        
        let records = NSEntityDescription.insertNewObject(forEntityName: "Records", into: context) as! Records
        
        records.cate = cate
        records.content = content
        records.marked = marked
        records.priority = priority
        records.title = title
        
        do {
            try context.save()
            print("saved successfully!")
        } catch {
            let alertController = UIAlertController(title: "Attention", message: "Insert Failed", preferredStyle:  .alert)
            
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
