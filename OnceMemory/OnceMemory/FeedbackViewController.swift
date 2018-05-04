//
//  FeedbackViewController.swift
//  OnceMemory
//
//  Created by Rui Huang on 4/22/18.
//  Copyright © 2018 BaikalSeal. All rights reserved.
//

import UIKit

class FeedbackViewController: SuperViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var naviBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
        
        textView!.layer.borderWidth = 0.7
        textView!.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        textView!.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    func textView (_ textView: UITextView, shouldChangeTextIn range:NSRange, replacementText text:String) -> Bool {
        if(text == "\n"){
            textView.resignFirstResponder()
            return false
        }
        
        if range.location >= 20 {
            let alertController = UIAlertController(title: "Attention", message: "You can input up to 50 words", preferredStyle:  .alert)
            
            let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        return true
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
