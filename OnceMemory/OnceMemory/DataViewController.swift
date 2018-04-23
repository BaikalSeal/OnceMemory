//
//  DataViewController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/3/25.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let sideBarOptions = ["Sign In", "Settings", "Feedback", "Copyright"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sideBarOptions.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "sideBar")
        cell.textLabel?.text = sideBarOptions[indexPath.row]
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "toSignUp", sender: self);
            break;
        case 1:
            self.performSegue(withIdentifier: "toSettings", sender: self);
            break;
        case 2:
            self.performSegue(withIdentifier: "toFeedback", sender: self);
            break;
        case 3:
            self.performSegue(withIdentifier: "toCopyright", sender: self);
            break;
        default:
            break
        }
    }

//    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.dataLabel!.text = dataObject
    }


}

