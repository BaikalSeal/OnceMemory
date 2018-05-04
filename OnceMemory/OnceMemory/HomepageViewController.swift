//
//  HomepageViewController.swift
//  OnceMemory
//
//  Created by Rui Huang on 4/22/18.
//  Copyright © 2018 BaikalSeal. All rights reserved.
//

import UIKit
import CoreData 

class HomepageViewController: SuperViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var naviBar: UINavigationBar!
    
    // var homepageOptions = ["GRE"]
    @IBOutlet weak var tableView: UITableView!
    
    var homepageOptionObjects: Array<(String?, String, String?, Int16, Int16, Int16, Bool)> = Array<(String?, String, String?, Int16, Int16, Int16, Bool)>()
    var homepageOptions:[String]  = []
    var selectedIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllData()
        let colorTheme = UserDefaultGetter.getTheme()
        
        if (colorTheme != nil){
            let theme = getThemeType(colorTheme!)
            self.switchTheme(type: theme)
        }
        else {
            self.switchTheme(type: ThemeType.blueTheme)
            UserDefaultGetter.setTheme(3)
        }
//        UserDefaultGetter.removeName()
        // Do any additional setup after loading the view.
    }
    
    func getThemeType(_ number: Int) -> ThemeType {
        switch number {
        case 0:
            return ThemeType.blackTheme
        case 1:
            return ThemeType.greenTheme
        case 2:
            return ThemeType.redTheme
        case 3:
            return ThemeType.blueTheme
        default:
            break
        }
        return ThemeType.blueTheme
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
        let imageName = "right_arrow.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x:0, y:0, width: 18, height:16)
        cell.accessoryView = imageView
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
    
//    func refreshData() {
//        homepageOptions.removeAll()
//        homepageOptionObjects.removeAll()
//        self.getAllData()
////        self.tableView.reloadData()
//    }
    
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
        if (theme.navigationBarColor != UIColor.white){
            UIApplication.shared.statusBarStyle = .lightContent
        }
        else{
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        }
    }
    
    func switchTheme(type: ThemeType){
        ThemeManager.switcherTheme(type: type)
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
