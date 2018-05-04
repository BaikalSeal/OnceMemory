//
//  SearchDayPlanViewController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/5/4.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit

class SearchDayPlanViewController: SuperViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var itemPriority: Int?
    
    var itemTitle: String?
    
    var itemCate: String?
    
    var itemMarked: Bool?

    var pController: Int = 0
    
    var lessons: [Int] = []
    var day = 0
    var plan: (String?, String, String?, Int16, Int16, Int16, Bool) = ("", "", "", 0, 0, 0, true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.topItem?.title = "Day \(day)"
        tableView.delegate = self
        tableView.dataSource = self
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
        let destViewController : SearchDetailedPlanViewController = segue.destination as! SearchDetailedPlanViewController
        destViewController.plan = self.plan
        destViewController.itemPriority = self.itemPriority
        destViewController.itemCate = self.itemCate
        destViewController.itemTitle = self.itemTitle
        destViewController.itemMarked = self.itemMarked
        destViewController.pController = self.pController
    }
    
    override func handelNotification(notification: NSNotification) {
        guard let theme = notification.object as? ThemeProtocol else {
            return
        }
        navigationBar.barTintColor = theme.navigationBarColor
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: theme.textColor]
        navigationBar.tintColor = theme.barItemColor
        navigationBar.isTranslucent = false
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
