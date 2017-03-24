//
//  Task.swift
//  TodoBox-Realm
//
//  Created by aney on 2017. 3. 25..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import RealmSwift

class Task: Object {
  
  dynamic var taskId = UUID().uuidString
  
  dynamic var title = ""
  dynamic var isDone = false
  
  override class func primaryKey() -> String? {
    return "taskId"
  }
  
  override class func indexedProperties() -> [String] {
    return ["isDone"]
  }
  
  convenience init(title: String, priority: Int) {
    self.init()
    self.title = title
  }
  
}
