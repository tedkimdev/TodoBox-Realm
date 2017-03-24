//
//  TaskCell.swift
//  TodoBox-Realm
//
//  Created by aney on 2017. 3. 25..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

import RealmSwift

final class TaskCell: UITableViewCell {
  
  // MARK: Properties
  var taskId: String?
  
  // MARK: Initializing
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
 
 
  // MARK: Realm
  
  private func updateTask(checked: Bool) {
    if let realm = try? Realm(),
      let id = self.taskId,
      let task = realm.object(ofType: Task.self, forPrimaryKey: id) {
      
      try! realm.write {
        task.isDone = checked
      }
      
    }
  }
  
}
