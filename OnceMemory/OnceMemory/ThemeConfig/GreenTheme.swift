//
//  Theme2.swift
//  CEThemeSwitcher
//
//  Created by Mr.LuDashi on 2017/1/13.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit
class GreenTheme: ThemeProtocol {
    var navigationBarColor: UIColor {
        get {
            return UIColor.colorWithHex(0x2AC67F)
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
    
    var sideBarColor: UIColor {
        get {
            return UIColor.colorWithHex(0x239A7B)
        }
    }
}
