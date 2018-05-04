//
//  ColorTestViewController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/5/3.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit

class ColorTestViewController: SuperViewController {

    @IBOutlet weak var label: UILabel!
    //    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var naviBar: UINavigationBar!
    //
    @IBOutlet weak var leftBarItem: UIBarButtonItem!
    //    @IBOutlet weak var leftBarItem: UIBarButtonItem!
    
//    var barView: UIView = UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        naviBar.delegate = self
//        leftBarItem.de
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        UIApplication.shared.statusBarStyle = .lightContent
//        //self.dataLabel!.text = dataObject
//    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func handelNotification(notification: NSNotification) {
        guard let theme = notification.object as? ThemeProtocol else {
            return
        }
//        self.label.textColor = theme.textColor
//        self.naviBar.barTintColor = theme.navigationBarColor
//        self.leftBarItem.tintColor = theme.barItemColor
        naviBar.barTintColor = theme.navigationBarColor
        naviBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: theme.textColor]
        naviBar.tintColor = theme.barItemColor
        naviBar.isTranslucent = false
        let barView = UIView(frame: CGRect(x:0, y:0, width:view.frame.width, height:UIApplication.shared.statusBarFrame.height))
        barView.backgroundColor = theme.navigationBarColor
//        barView.tintColor = theme.textColor
        self.view.addSubview(barView)

    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//
//        return .lightContent
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
