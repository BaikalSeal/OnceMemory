//
//  HomepageViewController.swift
//  OnceMemory
//
//  Created by Rui Huang on 4/22/18.
//  Copyright © 2018 BaikalSeal. All rights reserved.
//

import UIKit
import CoreData 

class HomepageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // var homepageOptions = ["GRE"]
    @IBOutlet weak var tableView: UITableView!
    
    var homepageOptionObjects: Array<(String?, String, String?, Int16, Int16, Int16, Bool)> = Array<(String?, String, String?, Int16, Int16, Int16, Bool)>()
    var homepageOptions:[String]  = []
    var selectedIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllData()
//        UserDefaultGetter.removeName()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAllData() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        let usrname = UserDefaultGetter.getName()
        
        var predicateArray = Array<NSPredicate>()
        
        if (usrname != nil){
            predicateArray.append(NSPredicate(format: "username = %@", usrname!))
        }
        else {
            predicateArray.append(NSPredicate(format: "username == nil"))
        }
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicateArray)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plan")
        
        fetchRequest.predicate = compoundPredicate
        
        do {
            let results = try context.fetch(fetchRequest) as! [Plan]
            if results.count > 0 {
                for plan in results {
                    homepageOptionObjects.append((plan.username, plan.title!, plan.category!, plan.numDays, plan.numLessons, plan.priority, plan.marked))
                    homepageOptions.append(plan.title!)
                }
            }
        } catch let err as NSError {
            print (err.debugDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (homepageOptions.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "homepage")
        cell.textLabel?.text = homepageOptions[indexPath.row]
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "toDetailedPlan", sender: self);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailedPlan" {
            let destViewController : DetailedPlanViewController = segue.destination as! DetailedPlanViewController
            destViewController.plan = homepageOptionObjects[selectedIndex]
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let app = UIApplication.shared.delegate as! AppDelegate
            let context = app.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Plan> = Plan.fetchRequest()
            let titleToDelete = homepageOptionObjects[indexPath.row].1
            fetchRequest.predicate = NSPredicate(format: "title = %@", titleToDelete)
            
            let result = try! context.fetch(fetchRequest)
            do {
                for obj in result {
                    context.delete(obj)
                }
            }
            
            do {
                try context.save()
            } catch let err as NSError {
                print (err.debugDescription)
            }
            homepageOptions.remove(at: indexPath.row)
            homepageOptionObjects.remove(at: indexPath.row)
            self.tableView.reloadData()
            //            DispatchQueue.main.async {
            //                tableView.reloadData()
            //            }
            //            self.tableView.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: true)
            
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
