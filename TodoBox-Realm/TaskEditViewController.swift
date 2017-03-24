//
//  TaskEditViewController.swift
//  TodoBox-Realm
//
//  Created by aney on 2017. 3. 25..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

final class TaskEditViewController: UIViewController {
  
  // MARK: Constants
  
  struct Font {
    static let textField = UIFont.systemFont(ofSize: 13)
  }
  
  // MARK: UI
  
  fileprivate let doneButtonItem = UIBarButtonItem(
    barButtonSystemItem: .done,
    target: nil,
    action: nil
  )
  fileprivate let textField = UITextField(frame: .zero)
  
  // MARK: Initializing
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Add Todo Item"
    
    self.navigationItem.rightBarButtonItem = self.doneButtonItem
    self.doneButtonItem.target = self
    self.doneButtonItem.action = #selector(doneButtomItemDidTap)
    
    self.textField.borderStyle = .roundedRect
    self.textField.placeholder = "Input Todo Item"
    
    self.view.addSubview(self.textField)
    
    self.textField.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(100)
      make.left.equalToSuperview().offset(10)
      make.right.equalToSuperview().offset(-10)
      make.height.equalTo(Font.textField.lineHeight * 2)
    }
  }
  
  
  // MARK: Actions
  
  func doneButtomItemDidTap() {
    print("doneButtomItemDidTap")
  }
  
}
