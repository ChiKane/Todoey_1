//
//  CategoryVC.swift
//  Todoey
//
//  Created by Eugene on 1/25/19.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit
import CoreData

class CategoryVC: UITableViewController {

    // custom vars
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name

        return cell
    }
    
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error occured while saving the data \(error)")
        }
        tableView.reloadData()
    }

    func loadCategories() {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error occured while loading the data, \(error)")
        }
        tableView.reloadData()
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            guard let text = textField.text else {return}
            if text != "" {
                let newCategory = Category(context: self.context) // specify the path of DB
                newCategory.name = text
                self.categories.append(newCategory)
                self.saveCategories()
            }
        }
        
        alert.addAction(action)
        
        alert.addTextField { (text) in
            textField = text
            text.placeholder = "Add new Category"
        }
    
        present(alert, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destnationVC = segue.destination as! TodoListVC
        
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        destnationVC.selectedCategory = categories[indexPath.row]
    }
    
}
