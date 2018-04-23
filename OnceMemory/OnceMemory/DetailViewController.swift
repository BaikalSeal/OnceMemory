//
//  DetailViewController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/4/19.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var itemString: String?

    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = itemString
        
        let alertController = UIAlertController(title: "Attention", message: itemString, preferredStyle:  .alert)
        
        let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
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
