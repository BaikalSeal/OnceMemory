//
//  DataViewController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/3/25.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit

class DataViewController: SuperViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var naviBar: UINavigationBar!
    //    let sideBarOptions = ["Sign In / Sign Up", "Settings", "Feedback", "Copyright"]
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    var sideBarOptions: Array<String> = []
    
    var registered: Bool = false
    
//    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var name: String?
        
        name = UserDefaultGetter.getName()
        
        self.tableView.separatorColor = UIColor.clear
        
        if (name != nil){
            self.registered = true
        }
        else{
            self.registered = false
        }
        
        if (!self.registered) {
            self.sideBarOptions = ["Sign In / Sign Up", "Settings", "Feedback", "Copyright"]
            loginLabel.text = ""
            usernameLabel.text = ""
        }
        else{
            self.sideBarOptions = ["Settings", "Feedback", "Copyright", "Logout"]
            loginLabel.text = "You have logged in as"
            usernameLabel.text = name
        }
        
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sideBarOptions.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "sideBar")
        cell.textLabel?.text = sideBarOptions[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
//        cell.tintColor = UIColor.white
//        cell.accessoryView.
//        cell.accessoryView.
        let imageName = "white_arrow.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x:0, y:0, width: 18, height:16)
        cell.accessoryView = imageView
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (!self.registered){
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
        else{
            switch indexPath.row {
            case 0:
                self.performSegue(withIdentifier: "toSettings", sender: self);
                break;
            case 1:
                self.performSegue(withIdentifier: "toFeedback", sender: self);
                break;
            case 2:
                self.performSegue(withIdentifier: "toCopyright", sender: self);
                break;
            case 3:
                self.performSegue(withIdentifier: "toLogout", sender: self);
                break;
            default:
                break
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLogout"{
            UserDefaultGetter.removeName()
        }
    }
    
    override func handelNotification(notification: NSNotification) {
        guard let theme = notification.object as? ThemeProtocol else {
            return
        }
        naviBar.barTintColor = theme.sideBarColor
        naviBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: theme.textColor]
        naviBar.tintColor = theme.barItemColor
        naviBar.isTranslucent = false
        let barView = UIView(frame: CGRect(x:0, y:0, width:view.frame.width, height:UIApplication.shared.statusBarFrame.height))
        barView.backgroundColor = theme.sideBarColor
        self.view.addSubview(barView)
        self.tableView.backgroundColor = theme.sideBarColor
        self.view.backgroundColor = theme.sideBarColor
//        if (theme.navigationBarColor != UIColor.white){
//            UIApplication.shared.statusBarStyle = .lightContent
//        }
//        else{
//            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
//        }
    }


}

