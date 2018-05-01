//
//  SearchViewController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/4/20.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchBtn: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var searchTitle: String?
    
    var alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if searchTextField == textField {
            
//            let length = string.lengthOfBytes(using: String.Encoding.utf8)
            guard let text = textField.text else {
                return true
            }
            
            let aSet = NSCharacterSet(charactersIn:alphabet).inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            
            let textLength = text.count + string.count - range.length
            
            return textLength < 24 && string == numberFiltered
//            guard let text = textField.text else {
//                return true
//            }
//
//            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
//            let compSepByCharInSet = string.components(separatedBy: aSet)
//            let numberFiltered = compSepByCharInSet.joined(separator: "")
////            return string == numberFiltered
//
//            let textLength = text.count + string.count - range.length
//
//            return textLength < 5 && string == numberFiltered
//
//            return textLength < 5 && string == numberFiltered
        }
        return true
    }
    
    @IBAction func funcBtn(_ sender: UIButton) {
        
        if self.searchTextField.text != nil {
            searchTitle = self.searchTextField.text!
            self.performSegue(withIdentifier: "GetSearchResult", sender: searchTitle)
        }
        else {
            let alertController = UIAlertController(title: "Attention", message: "Title cannot be empty!", preferredStyle:  .alert)
            
            let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GetSearchResult"{
            let controller = segue.destination as! SearchResultsViewController
            controller.itemTitle = sender as? String
        }
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
