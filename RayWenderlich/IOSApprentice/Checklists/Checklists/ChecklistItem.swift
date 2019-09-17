//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Dwayne Neckles on 9/13/19.
//  Copyright © 2019 Dwayne Neckles. All rights reserved.
//
import Foundation

class ChecklistItem:NSObject, Codable {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
