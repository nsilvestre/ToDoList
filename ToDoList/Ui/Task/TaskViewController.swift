//
//  TaskViewController.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/17/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import UIKit
import MBProgressHUD
import TTGSnackbar

class TaskViewController: UIBaseViewController {
    fileprivate var presenter: TaskViewPresenter?
    fileprivate var snackbar: TTGSnackbar?
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tvDetail: UITextView!
    
    var taskDto = TaskDto()
    
    static func newInstance() -> TaskViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TaskViewPresenter(view: self)
        prepareUI()
    }
    
    func goToMain() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTask(_ sender: Any) {
        taskDto.title = tfTitle.text
        taskDto.detail = tvDetail.text
        presenter?.saveTask(taskDto: taskDto)
    }
    
    fileprivate func prepareUI() {
        tfTitle.text = taskDto.title
        tvDetail.text = taskDto.detail
    }
}
