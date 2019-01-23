//
//  ViewController.swift
//  Todoey
//
//  Created by Eugene on 1/18/19.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit

class TodoListVC: UITableViewController{

    // temp var
    
    var itemsArray = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Kill Bil"
        itemsArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Kill Bob"
        itemsArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Kill Buch"
        itemsArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Kill Berny"
        itemsArray.append(newItem3)
        
        guard let itemsFromArray = defaults.array(forKey: "TodoListArray") else { return }
        itemsArray = itemsFromArray as! [Item]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemsArray[indexPath.row]
       
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what happen once the user click the Add Item button
            //itemsArray.append(textField.text)
            guard let text = textField.text else {return}
            if text != "" {
                let newItem = Item()
                newItem.title = text
                self.itemsArray.append(newItem)
                
                self.defaults.set(self.itemsArray, forKey: "TodoListArray")
                
                self.tableView.reloadData()

            }

        }
        
        alert.addTextField { (alertTextFiled) in
            alertTextFiled.placeholder = "Create new Item"
            textField = alertTextFiled
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

}

