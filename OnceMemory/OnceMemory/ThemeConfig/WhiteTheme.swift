//
//  Theme1.swift
//  CEThemeSwitcher
//
//  Created by Mr.LuDashi on 2017/1/13.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit
class WhiteTheme: ThemeProtocol {
    var navigationBarColor: UIColor {
        get {
            return UIColor.white
        }
    }
    
    var textColor: UIColor {
        get {
            return UIColor.black
        }
    }
    
    var barItemColor: UIColor {
        get {
            return UIColor.blue
        }
    }
    
    var sideBarColor: UIColor {
        get {
            return UIColor.white
        }
    }
}
