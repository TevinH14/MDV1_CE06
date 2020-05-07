//
//  StoreTableViewController.swift
//  HamiltonTevin_CE06
//
//  Created by Tevin Hamilton on 9/18/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import UIKit

class StoreTableViewController: UITableViewController {
    var shoppingListArray = [ShoppingList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerNib = UINib.init(nibName: "StoreHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "header_ID1")
        AddJsonToArray()
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    //complete
    @objc func trashAllSelected()
    {
        if var selectedIPs = tableView.indexPathsForSelectedRows
        {
            // sort in largest to smallest indx so that we can remove items from back to front
            selectedIPs.sort { (a, b) -> Bool in
                a.row > b.row
            }
            for indexpath in selectedIPs
            {
                shoppingListArray.remove(at: indexpath.row)
            }
            tableView.deleteRows(at: selectedIPs, with: .left)
            tableView.reloadData()
        }
    }
    //complete
    @IBAction func AddNewStore(_ sender: UIButton)
    {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add New Store", message: "Enter the name of the store", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let storeName = alert!.textFields![0] // Force unwrapping because we know it exists.
            if (storeName.text != "")
            {
                self.shoppingListArray.append(ShoppingList(store: String((storeName.text)!), list: [String]()))
                self.tableView.reloadData()
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
       
    }
    
    @IBAction func editTapped(_ sender: UIBarButtonItem)
    {
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing
        {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,
                                                                target: self, action: #selector(StoreTableViewController.trashAllSelected))
           navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self,action: #selector(StoreTableViewController.editTapped(_:)))
            
        }
        else
        {
            //tableView.setEditing(false, animated: true)
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action:#selector(StoreTableViewController.editTapped(_:)))
            
        }
      
    }
    
    override func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        if  tableView.isEditing == true{
            print("deselceting row:" + indexPath.row.description)
        }
        return indexPath
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            shoppingListArray.remove(at: indexPath.row)
            //delete the row
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingListArray.count
    }
    
    //done
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_ID1", for: indexPath)  as! StoreTableViewCell
        
        // Configure the cell...
        cell.labelStoreName.text = shoppingListArray[indexPath.row].store
        cell.labelNumStores.text = shoppingListArray[indexPath.row].list.count.description
        
        return cell
    }
    
    //MARK: header... done
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //create the view
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header_ID1") as? CustomStoreHeader
        // config the view
        header?.numStoresLabel.text = shoppingListArray.count.description
        //return the view
        
        return header
        
    }
    
    
    func AddJsonToArray()
    {
        if let path = Bundle.main.path(forResource: "ShoppingList", ofType: ".json") {
            
            //Create the URL using path
            let url = URL(fileURLWithPath: path)
            
            do{
                let data = try Data.init(contentsOf: url)
                
                //create josn object
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                guard let json = jsonObj
                    else{print("something went wrong");return}
                
                for firstLevel in json
                {
                    guard let object = firstLevel as? [String: Any],
                        let store = object ["store"] as? String,
                        let list = object ["list"] as? [String]
                        else {print("something went wrong"); return}
                    shoppingListArray.append(ShoppingList(store: store, list: list))
                    
                    
                }
            }
            catch{print(error.localizedDescription)}
        }
    }
    
    
     // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tableView.isEditing
        {
            return false
        }
        else
        {
            return true
        }
    }
    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        //get the selected row in the table view
        if let indexPath = tableView.indexPathForSelectedRow
        {
            let postToSend = shoppingListArray[indexPath.row]
            
            if let destination = segue.destination as? StoreListTableViewController
            {
                //pass data to view controler
                destination.list = postToSend
            }
        }
     }
    
    
}
