//
//  StoreListTableViewController.swift
//  HamiltonTevin_CE06
//
//  Created by Tevin Hamilton on 9/20/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import UIKit

class StoreListTableViewController: UITableViewController {
    var list:ShoppingList! = nil
    var listArray = [[String](),[String]()]
    override func viewDidLoad() {
        super.viewDidLoad()
        if list != nil
        {
            listArray.insert(list.list, at: 0)
           listArray.insert(list.completeList, at: 1)
            let headerNibOne = UINib.init(nibName: "NeededHeader", bundle: nil)
            tableView.register(headerNibOne, forHeaderFooterViewReuseIdentifier: "header_ID2")
            let headerNibTwo = UINib.init(nibName: "CompleteHeader", bundle: nil)
            tableView.register(headerNibTwo, forHeaderFooterViewReuseIdentifier: "header_ID3")
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listArray[section].count
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      
        if section == 0
        {
            //create the view
            let headerOne = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header_ID2") as? CustomNeededHeader
            // config the view
            headerOne?.labelTotalItems.text = listArray[0].count.description
            return headerOne
        }
        else
        {
            let headerTwo = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header_ID3") as? CustomCompleteHeader
            // config the view
            headerTwo?.labelCompleteTotal.text = listArray[1].count.description
            //return the view
            return headerTwo
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_id2", for: indexPath)
        
        // Configure the cell...
        cell.textLabel!.text = listArray[indexPath.section][indexPath.row]
        return cell
    }

   
    @IBAction func AddItem(_ sender: UIBarButtonItem)
    {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add New Item", message: "Enter the name of the item", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let storeItem = alert!.textFields![0] // Force unwrapping because we know it exists.
            if (storeItem.text != "")
            {
                // self.shoppingListArray.append(ShoppingList(store: String((storeName.text)!), list: [String]()))\
                self.list.list.append(String((storeItem.text)!))
                self.listArray[0].append(String((storeItem.text)!))
                DispatchQueue.main.async {
                    //reload the the tableview with data.
                    self.tableView.reloadData()
                }
            }
            
        }))
        // 4. Present the alert.
        present(alert, animated: true, completion: nil)
    }
}
