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
}
