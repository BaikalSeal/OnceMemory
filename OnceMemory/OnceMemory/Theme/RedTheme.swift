//
//  Theme2.swift
//  CEThemeSwitcher
//
//  Created by Mr.LuDashi on 2017/1/13.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit
class RedTheme: ThemeProtocol {
    var navigationBarColor: UIColor {
        get {
            return UIColor.red
        }
    }
    
    var textColor: UIColor {
        get {
            return UIColor.white
        }
    }
    
    var barItemColor: UIColor {
        get {
            return UIColor.white
        }
    }
}
