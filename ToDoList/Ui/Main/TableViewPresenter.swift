//
//  TableViewPresenter.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/16/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import Foundation

class TableViewPresenter {
    private weak var view: TableViewController?
    
    init(view: TableViewController) {
        self.view = view
    }
    
    func prepareData() {
        ApiClient.shared.fetchTasks() { result in
            switch result {
            case .success(let tasks):
                self.view?.refreshTasks(tasks: tasks)
                break
                
            case .failure(let error):
                self.view?.showError(message: error.userMessage())
                break
            }
        }
    }
    
    func deleteTask(id: Int32) {
        self.view?.showProgressHUD()
        ApiClient.shared.deleteTask(id: id) { result in
            switch result {
            case .success:
                self.view?.hideProgressHUD()
                self.prepareData()
                break
                
            case .failure(let error):
                self.view?.hideProgressHUD()
                self.view?.showError(message: error.userMessage())
                break
            }
        }
    }
}
