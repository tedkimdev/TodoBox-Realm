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
  var viewMode: ViewMode = ViewMode.all
  
  
  // MARK: UI
  
  fileprivate let isDoneViewButtonItem = UIBarButtonItem(
    title: "✔︎",
    style: .done,
    target: nil,
    action: nil
  )
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
    
    self.navigationItem.leftBarButtonItem = self.isDoneViewButtonItem
    self.isDoneViewButtonItem.target = self
    self.isDoneViewButtonItem.action = #selector(isDoneViewButtonItemDidTap)
    
    self.navigationItem.rightBarButtonItem = self.addButtonItem
    self.addButtonItem.target = self
    self.addButtonItem.action = #selector(addButtonItemDidTap)
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
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
  
  func isDoneViewButtonItemDidTap() {
    
    switch self.viewMode {  // All -> checked -> unchecked 순
    case .all:
      self.viewMode = .checked
      self.isDoneViewButtonItem.title = "✔︎"
      self.tasks = self.getTasks(isDone: true)
      
    case .checked:
      self.viewMode = .unchecked
      self.isDoneViewButtonItem.title = "☐"
      self.tasks = self.getTasks(isDone: false)
      
    case .unchecked:
      self.viewMode = .all
      self.isDoneViewButtonItem.title = "All"
      self.readTasksAll()
    }
    
    self.tableView.reloadData()
  }
  
  
  // MARK: Notification
  
  func taskDidAdd(_ notification: Notification) {
    print("Notification")
    self.viewMode = .all
    self.readTasksAll()
    self.tableView.reloadData()
  }
  
  
  // MARK: Realm
  
  func readTasksAll() {
    let realm = try! Realm()
    self.tasks = realm.objects(Task.self)
  }

  func updateTask(task: Task) {
    let id = task.taskId
    if let realm = try? Realm(),
      let task = realm.object(ofType: Task.self, forPrimaryKey: id) {
      
      try! realm.write {
        task.isDone = !task.isDone
      }
    }
  }
  
  func getTasks(isDone: Bool) -> Results<Task> {
    let realm = try! Realm()
    self.tasks = realm.objects(Task.self)
    
    if (isDone) {
      self.tasks = self.tasks.filter("isDone = true")
    } else {
      self.tasks = self.tasks.filter("isDone = false")
    }
    
    return tasks.sorted(byKeyPath: "created", ascending: true)
  }
}


// MARK: - UITableViewDataSource

extension TaskListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let task = tasks[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
    
    cell.textLabel?.text = task.title
    
    if task.isDone {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
    
    return cell
  }
  
}


// MARK: - UITableViewDelegate

extension TaskListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let task = self.tasks[indexPath.row]
    
    self.updateTask(task: task)
    self.readTasksAll()
    
    tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      try! tasks.realm!.write {
        let task = self.tasks[indexPath.row]
        self.tasks.realm!.delete(task)
      }
    }
    self.tableView.deleteRows(at: [indexPath], with: .fade)
  }
  
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return false
  }

}
