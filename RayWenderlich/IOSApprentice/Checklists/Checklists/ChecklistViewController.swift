//
//  ViewController.swift
//  Checklists
//
//  Created by Dwayne Neckles on 9/12/19.
//  Copyright © 2019 Dwayne Neckles. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    var items = [ChecklistItem]()
    var checklist:Checklist!
    
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()
        
        // Load items
        loadChecklistItems()
        title = checklist.name
       // print("Documents folder is \(documentsDirectory())")
       // print("Data file path is \(dataFilePath())")
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
        
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    // MARK:- Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
            
            let item = items[indexPath.row]
            
            configureText(for: cell, with: item)
            configureCheckmark(for: cell, with: item)
            return cell
    }
    
    // MARK:- Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        saveChecklistItems()
        
    }
    // Delete
    override func tableView( _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 1
        items.remove(at: indexPath.row)
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        saveChecklistItems()
        
    } 
    
    //Mark:– Navigation Either AddItem Screen or Edit ItemScreen
    // segue is the screen its attached too
    // sender is the item that triggered the segue
    override func prepare(for segue: UIStoryboardSegue,sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
            
            
        }
    }
    
    func itemDetailControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated:true)
    }
    
    
    func itemDetailController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = items.firstIndex(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
                
            }
        }
        navigationController?.popViewController(animated:true)
        saveChecklistItems()
    }
    func itemDetailController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        //if 0-10 index is 11
        let newRowIndex = items.count
        
        //add to MODEL always use test data
        items.append(item)
        
        //ADD TO TABLE VIIEW create the row first
        let indexPath = IndexPath(row:newRowIndex, section: 0)
        //put it in an array of indexpaths
        let indexPaths = [indexPath]
        //add to tableviews the arrayPath
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated:true)
        saveChecklistItems()
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func dataFilePath() -> URL {   return documentsDirectory().appendingPathComponent(      "Checklists.plist")
    }
    
    func saveChecklistItems() {
            print("runs")
        // 1
        let encoder = PropertyListEncoder()
        // 2
        do {
            // 3
            let data = try encoder.encode(items)
            // 4
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
            // 5
        } catch {
            // 6
            print("Error encoding item array: \(error.localizedDescription)")
        }
        
    }
    
    func loadChecklistItems() {
        print("runs")
        // 1
        let path = dataFilePath()
        // 2
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
        do {
           
            items = try decoder.decode([ChecklistItem].self,                                   from: data)
            // 5
        } catch {
            // 6
            print("Error decoding item array: \(error.localizedDescription)")
        }
        
    }
    
}

}
