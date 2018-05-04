 //
//  DayPlanViewController.swift
//  OnceMemory
//
//  Created by Rui Huang on 4/22/18.
//  Copyright © 2018 BaikalSeal. All rights reserved.
//

import UIKit
import CoreData

class DayPlanViewController: SuperViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var naviBar: UINavigationBar!
    
    var lessons: [Int] = []
    var day = 0
    var plan: (String?, String, String?, Int16, Int16, Int16, Bool) = ("", "", "", 0, 0, 0, true)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.topItem?.title = "Day \(day)"
//
//        lessons.append("Lesson \(selectedIndex*2+1)")
//        lessons.append("Lesson \(selectedIndex*2+2)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (lessons.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "lesson")
        cell.textLabel?.text = "Lesson \(lessons[indexPath.row])" 
        return (cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController : DetailedPlanViewController = segue.destination as! DetailedPlanViewController
        destViewController.plan = self.plan
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
