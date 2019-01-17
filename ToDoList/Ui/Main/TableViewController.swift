//
//  ViewController.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/16/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import UIKit
import TTGSnackbar
import MBProgressHUD

class TableViewController: UIBaseViewController, UITableViewDelegate, UITableViewDataSource {
    fileprivate var presenter: TableViewPresenter?
    fileprivate var snackbar: TTGSnackbar?
    
    @IBOutlet var tTasks: UITableView!
    
    var tasks:[TaskDto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TableViewPresenter(view: self)
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.prepareData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TaskTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TaskTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let task = tasks[indexPath.row]
        cell.bindTo(task: task)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
             let task = tasks[indexPath.row]
            presenter?.deleteTask(id: task.id!)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = TaskViewController.newInstance()
        vc.taskDto = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func refreshTasks(tasks: [TaskDto]) {
        self.tasks = tasks
        tTasks.reloadData()
    }
    
    fileprivate func prepareUI() {
     
    }
}

