//
//  UserDefaultGetter.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/5/1.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit

class UserDefaultGetter {
    
    static func getName() -> String? {
        let usrname = UserDefaults.standard.string(forKey: "name")
        
        if (usrname != nil){
            let name = UserDefaults.standard.string(forKey: "usrname")
            return name!
        }
        else {
            return nil
        }
//        return nil
    }

    static func getId() -> Int? {
        let userid = UserDefaults.standard.integer(forKey: "id")
        if (userid != -1){
            return userid
        }
        else {
            return nil
        }
    }
    
    static func addName(_ usrname: String) -> String {
        let uuid_ref = CFUUIDCreate(nil)
        let uuid_string_ref = CFUUIDCreateString(nil, uuid_ref)
        let uuid = uuid_string_ref as! String
        UserDefaults.standard.set(uuid, forKey: "name")
        UserDefaults.standard.set(usrname, forKey: "usrname")
        return uuid
    }
    
    static func removeName() {
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "usrname")
    }
    
    static func setTheme(_ color: Int) {
        UserDefaults.standard.set(color, forKey: "theme")
    }
    
    static func getTheme() -> Int? {
        let color = UserDefaults.standard.integer(forKey: "theme")
        if (color != -1){
            return color
        }
        else {
            return nil
        }
    }
    
}
