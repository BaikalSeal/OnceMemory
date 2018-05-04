//
//  ThemeChangeViewController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/5/2.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit

enum CellTitleType: Int {
    case Black, Green, Red, Blue

    var themeType : ThemeType {
        get {
            switch self {
            case .Black:
                return .blackTheme
            case .Green:
                return .greenTheme
            case .Red:
                return .redTheme
            case .Blue:
                return .blueTheme
            }
        }
    }
}

class ThemeChangeViewController: SuperViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var naviBar: UINavigationBar!
    
    @IBOutlet weak var leftBarItem: UIBarButtonItem!
    
    @IBOutlet weak var rightBarItem: UIBarButtonItem!
    
    var sideBarOptions: Array<String> = []
    var registered: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.sideBarOptions = ["Black", "Green", "Red", "Blue"]
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.dataLabel!.text = dataObject
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sideBarOptions.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "sideBar")
        cell.textLabel?.text = sideBarOptions[indexPath.row]
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cellType: CellTitleType = CellTitleType(rawValue: indexPath.row) else {
//            return
//        }
//        self.switchTheme(type: cellType)
        switch indexPath.row {
        case 0:
            self.switchTheme(type: ThemeType.blackTheme)
            UserDefaultGetter.setTheme(0)
            break;
        case 1:
            self.switchTheme(type: ThemeType.greenTheme)
            UserDefaultGetter.setTheme(1)
            break;
        case 2:
            self.switchTheme(type: ThemeType.redTheme)
            UserDefaultGetter.setTheme(2)
            break;
        case 3:
            self.switchTheme(type: ThemeType.blueTheme)
            UserDefaultGetter.setTheme(3)
            break;
        default:
            break
        }
    }
    
    func switchTheme(type: ThemeType){
        ThemeManager.switcherTheme(type: type)
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
        if (theme.navigationBarColor != UIColor.white){
            UIApplication.shared.statusBarStyle = .lightContent
        }
        else{
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        }
    }
    
    
//    override func handelNotification(notification: NSNotification) {
//        guard let theme = notification.object as? ThemeProtocol else {
//            return
//        }
//        self.tableView.backgroundColor = theme.navigationBarColor
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
