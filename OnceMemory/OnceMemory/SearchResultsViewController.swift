//
//  SearchResultsViewController.swift
//  OnceMemory
//
//  Created by 陈建楠 on 2018/4/19.
//  Copyright © 2018年 BaikalSeal. All rights reserved.
//

import UIKit
import CoreData

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView:UITableView?
    
//    var tableNames: [String] = ["Item 1", "Item 2", "Item 3"]
    
    var tableItems: Array<(String, String, String, Int, Bool)> = Array<(String, String, String, Int, Bool)>()
    
//    var itemString: String?
    var itemPriority: Int?
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: CGRect(x:0, y:64, width:self.view.frame.width, height:self.view.frame.height - 44), style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        self.view.addSubview(self.tableView!)
        
        tableItems.append(("chinese", "chn", "chinese", 1, true))
        
        let tempResult: Array<(String, String, String, Int, Bool)> = self.searchResult(nil, nil, nil, itemPriority!, nil)
        if tempResult.count > 0 {
            tableItems = tempResult
        }
        // Do any additional setup after loading the view.
    }
    
    func searchResult(_ title: String? = nil, _ cate: String? = nil, _ content: String? = nil, _ priority: Int? = nil, _ marked: Bool? = nil) -> Array<(String, String, String, Int, Bool)> {
        
//        var sTitle: String
//        var sCate: String
//        var sContent: String
//        var sPriority: Int
//        var sMarked: Bool
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Records>(entityName: "Records")
        fetchRequest.fetchLimit = 5
        fetchRequest.fetchOffset = 0
        
        var dict = Dictionary<String, Any>()
        
        var predicateArray = Array<NSPredicate>()
        
        
        if title != nil {
            dict["title"] = title
            predicateArray.append(NSPredicate(format: "title = %s", title!))
//            predicate1 = NSPredicate(format: "title = %s", title!)
        }
        
        if cate != nil {
            dict["cate"] = cate
            predicateArray.append(NSPredicate(format: "cate = %s", cate!))
        }
        
        if priority != nil {
            dict["priority"] = priority
            predicateArray.append(NSPredicate(format: "priority = %d", priority!))
        }
        
        if marked != nil {
            dict["marked"] = marked
            predicateArray.append(NSPredicate(format: "priority = %d", priority!))
        }
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicateArray)
        
        
        
//        let NSdict = NSDictionary(dictionary: dict)
        
//        let predicate = NSPredicate()
//        let predicate = NSPredicate(format: "priority = 1")
//        predicate.withSubstitutionVariables(dict)
        
        fetchRequest.predicate = compoundPredicate
        
        var resultArray: Array<(String, String, String, Int, Bool)> = Array<(String, String, String, Int, Bool)>()
        
        //查询操作
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            
            if fetchedObjects.count > 0 {
                for item in fetchedObjects {
                    resultArray.append((item.title!, item.cate!, item.content!, Int(item.priority), item.marked))
                }
            }
        }
        catch {
            let alertController = UIAlertController(title: "Attention", message: "You can input up to 50 words", preferredStyle:  .alert)
            
            let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        return resultArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableItems.count
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "cell1"
            //同一形式的单元格重复使用，在声明时已注册
            let cell = tableView.dequeueReusableCell(withIdentifier: identify,
                                                     for: indexPath) as UITableViewCell
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = self.tableItems[indexPath.row].0
            return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        let itemString = self.tableItems[indexPath.row].0
        
        self.performSegue(withIdentifier: "ShowDetailView", sender: itemString)
    }
    
    //在这个方法中给新页面传递参数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailView"{
            let controller = segue.destination as! DetailViewController
            controller.itemString = sender as? String
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
