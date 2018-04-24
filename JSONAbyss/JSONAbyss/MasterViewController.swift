//
//  MasterViewController.swift
//  JSONAbyss
//
//  Created by Sebastian Snyder on 4/24/18.
//  Copyright © 2018 Sebastian Snyder. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "TitleIcon"));
        
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow
            {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                
                
                let row = indexPath.row;
                let section = indexPath.section;
                controller.detailItem = (JSONAbyss.get("datData","franchise",section,"entries",row) as! [String:Any]);
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        let J = JSONAbyss.get("datData","franchise") as! [Any];
        return J.count;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let J = JSONAbyss.get("datData","franchise",section,"entries") as! [Any];
        return J.count;
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (JSONAbyss.get("datData","franchise",section,"franchiseName") as! String);
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let row = indexPath.row;
        let section = indexPath.section;
        
        let FranchiseEntry = JSONAbyss.get("datData","franchise",section,"entries",row) as! [String:Any];
        
        cell.textLabel!.text = (FranchiseEntry["name"] as! String)
        var detailStr = (FranchiseEntry["yearStart"] as! String)
        if let Yend = FranchiseEntry["yearEnd"] as? String
        {
            if(Yend != detailStr)
            {
                detailStr += " -";
                if(Int(Yend) != nil)
                {
                    detailStr += " " + Yend
                }
            }
        }
        cell.detailTextLabel!.text = detailStr;
        return cell;
    }

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }


}

