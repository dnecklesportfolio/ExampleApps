//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Dwayne Neckles on 9/16/19.
//  Copyright © 2019 Dwayne Neckles. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController,ListDetailViewControllerDelegate {
    let cellIdentifier = "CheckListCell"
    var lists = [Checklist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        var list = Checklist(name: "Birthdays")
        lists.append(list)
        list = Checklist(name: "Groceries")
        lists.append(list)
        list = Checklist(name: "Cool Apps")
        lists.append(list)
         list = Checklist(name: "To Do")
        lists.append(list)
        
        //Prototype cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: - Table view data source
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lists.count
    }

    //generates cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let checklist = lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
 // on click tell segue open next screen with the checklist
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checkList = lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checkList)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist" {
            // cast controller to the screen i want to use
            let controller = segue.destination as! ChecklistViewController
            
            controller.checklist = sender as? Checklist 
            
        } else if segue.identifier == "AddChecklist" {
            let controller = segue.destination as! ListDetailViewController
            controller.delegate = self
        }
    }
    // Mark:- List Detail View Controller Functions to implement
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
        let newRowIndex = lists.count
        lists.append(checklist)
        
        let indexPath = IndexPath (row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows( at: indexPaths, with: .automatic)
     navigationController?.popViewController(animated: true)
    }
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
        if let index = lists.firstIndex(of: checklist){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        navigationController?.popViewController(animated:true)
        //saveChecklistItems()
    }
    
    override func tableView( _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 1
        lists.remove(at: indexPath.row)
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        //saveChecklistItems()
        
    }
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
    controller.delegate = self
    let checklist = lists[indexPath.row]
    controller.checklistToEdit = checklist
    navigationController?.pushViewController(controller, animated: true) }
    
}
