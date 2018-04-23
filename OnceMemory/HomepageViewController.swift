//
//  HomepageViewController.swift
//  OnceMemory
//
//  Created by Rui Huang on 4/22/18.
//  Copyright © 2018 BaikalSeal. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let homepageOptions = ["GRE", "HCI"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (homepageOptions.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "homepage")
        cell.textLabel?.text = homepageOptions[indexPath.row]
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "toGRE", sender: self);
            break;
        case 1:
            self.performSegue(withIdentifier: "toSettings", sender: self);
            break;
        default:
            break
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
