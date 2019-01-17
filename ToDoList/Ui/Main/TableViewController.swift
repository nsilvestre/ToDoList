//
//  ViewController.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/16/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import UIKit
import TTGSnackbar

class TableViewController: UITableViewController {
    fileprivate var presenter: TableViewPresenter?
    fileprivate var snackbar: TTGSnackbar?
    
    @IBOutlet var tTasks: UITableView!
    
    var tasks:[TaskDto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TableViewPresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.prepareData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.title
        
        return cell
    }
    
    func refreshTasks(tasks: [TaskDto]) {
        self.tasks = tasks
        tTasks.reloadData()
    }
    
    func showError(message: String) {
        if let snackbar = snackbar {
            snackbar.message = message
            snackbar.show()
        }
    }
}

