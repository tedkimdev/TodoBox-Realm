//
//  TaskListViewController.swift
//  TodoBox-Realm
//
//  Created by aney on 2017. 3. 25..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

import RealmSwift

final class TaskListViewController: UIViewController {
  
  // MARK: Properties
  var tasks: Results<Task>!
  
  
  // MARK: UI
  
  fileprivate let addButtonItem = UIBarButtonItem(
    barButtonSystemItem: .add,
    target: nil,
    action: nil
  )
  fileprivate let tableView =  UITableView(frame: .zero)
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.readTasksAll()
    
    self.title = "Todo Box"
    
    self.navigationItem.rightBarButtonItem = self.addButtonItem
    self.addButtonItem.target = self
    self.addButtonItem.action = #selector(addButtonItemDidTap)
    
    self.tableView.dataSource = self
    
    self.tableView.register(TaskCell.self, forCellReuseIdentifier: "taskCell")
    
    self.view.addSubview(self.tableView)
    
    self.tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    NotificationCenter.default.addObserver(self, selector: #selector(taskDidAdd), name: .taskDidAdd, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  
  // MARK: Actions
  
  func addButtonItemDidTap() {
    let taskEditViewController = TaskEditViewController()
      self.navigationController?.pushViewController(taskEditViewController, animated: true)
  }
  
  
  // MARK: Notification
  
  func taskDidAdd(_ notification: Notification) {
    print("Notification")
    self.readTasksAll()
    self.tableView.reloadData()
  }
  
  
  // MARK: Realm
  
  func readTasksAll() {
    let realm = try! Realm()
    self.tasks = realm.objects(Task.self)
  }
  
}


extension TaskListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
    
    cell.textLabel?.text = tasks[indexPath.row].title
    
    return cell
  }
  
}


extension TaskListViewController: UITableViewDelegate {
  
  
  
}
