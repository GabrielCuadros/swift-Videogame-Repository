//
//  ViewController.swift
//  Fly CC Online
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 29/7/15.
//  Copyright (c) 2015 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UITableViewController , UITableViewDataSource , UITableViewDelegate {
    
    //variables
    
    
    var itemsArray = [String]()
    var itemCounter = 0
    var itemsCell = [String]()
    
    //viewdidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        webData("http://www.flyinc.co/CC/WS/WS_GetCategoriesWithCountOfPromotions.php")
        
        
    }
  
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CEll") as! UITableViewCell
        
        if itemsArray.count == 0 {
        
            print("el array esta vacia...")
        }
        
        cell.textLabel?.text = itemsArray[indexPath.row]
        
        return cell
    }
    
    func webData(urlData : String){
    
        var url = NSURL(string: urlData)
        
        var task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
            
                if error != nil {
                    println(error)
                }else {
                    
                    var jerror : NSError?
                    
                    var jsonReader = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                    
                    if var response = jsonReader["response"] as? NSDictionary{
                        if var categories = response["Categories"] as? NSArray{
                            for i in 0...categories.count - 1{
                                if var section = categories[i] as? NSDictionary {
                                    if var name = section["name"] as? String {
                                        
                                        self.itemsArray.append(name)
                                        self.itemCounter = self.itemsArray.count
                                        println(self.itemCounter)
                                        println(self.itemsArray)
                                        
                                        //once the block has finished , its necesary reload the TableView component on the main thread
                                        
                                        self.tableView.reloadData()
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            })
            
            
        })
        
        task.resume()
        
        
    }


    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

