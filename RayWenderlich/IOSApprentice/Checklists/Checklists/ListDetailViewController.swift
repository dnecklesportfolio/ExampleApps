//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by Dwayne Neckles on 9/17/19.
//  Copyright © 2019 Dwayne Neckles. All rights reserved.
//

import UIKit
protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(_ controller:ListDetailViewController)
    func listDetailViewController(_ controller:ListDetailViewController, didFinishAdding checklist:Checklist)
       func listDetailViewController(_ controller:ListDetailViewController, didFinishEditing checklist:Checklist)
}
class ListDetailViewController:UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textField:UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    weak var delegate:ListDetailViewControllerDelegate?
    
    var checklistToEdit:Checklist?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.isEnabled = true
        }
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    //MARK:- Actions
    @IBAction func cancel() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let checklist = checklistToEdit {
            checklist.name = textField.text!
            delegate?.listDetailViewController(self,didFinishEditing: checklist)
        } else {
            //add new checklist
            let checklist = Checklist(name:textField.text!)
            delegate?.listDetailViewController(self, didFinishAdding:checklist)
        }
    }
    
    // MARK: - Table View Delegates
    // Make sure the user cannot select the table cell
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
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
