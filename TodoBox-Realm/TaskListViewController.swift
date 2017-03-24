//
//  TaskListViewController.swift
//  TodoBox-Realm
//
//  Created by aney on 2017. 3. 25..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

final class TaskListViewController: UIViewController {
  
  // MARK: - UI
  fileprivate let tableView =  UITableView(frame: .zero)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self
    
    
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    
    self.view.addSubview(self.tableView)
    
    self.tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  
}


extension TaskListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
    
    cell.textLabel?.text = "test"
    
    return cell
  }
  
}


extension TaskListViewController: UITableViewDelegate {
  
  
  
}
