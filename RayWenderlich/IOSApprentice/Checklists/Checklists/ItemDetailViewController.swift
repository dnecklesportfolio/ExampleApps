//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Dwayne Neckles on 9/14/19.
//  Copyright © 2019 Dwayne Neckles. All rights reserved.


import UIKit
protocol ItemDetailViewControllerDelegate:class {
    func itemDetailControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
    func itemDetailController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)

}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    var itemToEdit: ChecklistItem?
    weak var delegate: ItemDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            if let doneBtn = doneBarButton {
            doneBtn.isEnabled = true
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    
    // MARK:- Actions
    @IBAction func cancel() {
        //tells parent
        delegate?.itemDetailControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
item.text = textField.text!
            // tells the representative that we are done and to take the new updated it
            delegate?.itemDetailController(self, didFinishEditing: item)
        } else {
            let item = ChecklistItem()
            item.text = textField.text!
            delegate?.itemDetailController(self, didFinishAdding: item)
        }
    }
    
    // MARK:- Table View Delegates Make the labels non selectable
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath)
        -> IndexPath? {
            return nil
    }
    
    // MARK:- Ensure that there is content in textfield before user presses done
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange,
                                                  with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
    
  
}
