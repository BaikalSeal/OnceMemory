//
//  DetailedPlanViewController.swift
//  OnceMemory
//
//  Created by Rui Huang on 4/22/18.
//  Copyright © 2018 BaikalSeal. All rights reserved.
//

import UIKit
import CoreData

class DetailedPlanViewController: SuperViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navigationBar: UINavigationBar!
    var days: [String] = []
    // username, title, category, numDays, numLessons, priority, marked
    var plan: (String?, String, String?, Int16, Int16, Int16, Bool) = ("", "", "", 0, 0, 0, true)
    var dayPlans : [[Int]] = []
    var selectedIndex: Int = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.topItem?.title = plan.1
        let numDays = Int(plan.3)
        for i in 1...numDays {
            days.append("Day \(i)")
        }
        
        for _ in 0...plan.3-1 {
            dayPlans.append([])
        }
        
        self.generateDayPlans();
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (days.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "GREDays")
        cell.textLabel?.text = days[indexPath.row]
        let imageName = "right_arrow.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x:0, y:0, width: 18, height:16)
        cell.accessoryView = imageView
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "toDayPlan", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDayPlan" {
            let destViewController : DayPlanViewController = segue.destination as! DayPlanViewController
            destViewController.lessons = dayPlans[selectedIndex]
            destViewController.day = selectedIndex+1
            destViewController.plan = self.plan
        }
        
    }
    
    // generate daily plan approximately based on Ebbinghaus Retention Curve
    private func generateDayPlans() {
        let numDays = Int(plan.3)
        let numLessons = Int(plan.4)
        var lessonsPerDay = 0
        var start = 0
        var end = 0
        
        // add new lessons to each day
        if numLessons < numDays {
            for i in 1...numLessons {
                dayPlans[i-1].append(i)
            }
        } else {
            if numLessons % numDays != 0 {
                if numLessons % numDays <= numDays/2 {
                    lessonsPerDay = numLessons / numDays
                    for i in 1...numDays {
                        end = lessonsPerDay * i
                        start = end - lessonsPerDay + 1
                        for j in start...end {
                            dayPlans[i-1].append(j)
                        }
                    }
                    for i in lessonsPerDay*numDays+1...numLessons {
                        dayPlans[numDays-1].append(i)
                    }
                } else {
                    lessonsPerDay = numLessons / numDays + 1
                    for i in 1...numDays-1 {
                        end = lessonsPerDay * i
                        start = end - lessonsPerDay + 1
                        for j in start...end {
                            dayPlans[i-1].append(j)
                        }
                    }
                    if lessonsPerDay * (numDays-1) < numLessons {
                        for i in lessonsPerDay*(numDays-1)+1...numLessons {
                            dayPlans[numDays-1].append(i)
                        }
                    }
                }
            } else {
                lessonsPerDay = numLessons / numDays
                for i in 1...numDays {
                    end = lessonsPerDay * i
                    start = end - lessonsPerDay + 1
                    for j in start...end {
                        dayPlans[i-1].append(j)
                    }
                }
            }
        }
        
        
        let basicLessons = dayPlans
        
        // review previous day
        for i in 1...dayPlans.count-1 {
            dayPlans[i] += basicLessons[i-1]
        }
        
        // review contents of 4 days before
        if numDays > 4 {
            for d in 4...numDays-1 {
                dayPlans[d] += basicLessons[d-4]
            }
        }
        
        // sort daily plans
//        for l in dayPlans {
//            l.sorted()
//        }
        
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
