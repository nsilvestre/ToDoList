//
//  TaskViewPresenter.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/17/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import Foundation

class TaskViewPresenter {
    private weak var view: TaskViewController?
    
    init(view: TaskViewController) {
        self.view = view
    }
    
    func saveTask(taskDto: TaskDto) {
        self.view?.showProgressHUD()
        if taskDto.id == nil {
            ApiClient.shared.addTask(taskDto: taskDto) { result in
                self.handleResponse(result: result)
            }
        } else {
            ApiClient.shared.updateTask(taskDto: taskDto) { result in
                self.handleResponse(result: result)
            }
        }
    }
    
    fileprivate func handleResponse(result: ApiResult<Void>) {
        switch result {
        case .success:
            self.view?.hideProgressHUD()
            self.view?.goToMain()
            break
            
        case .failure(let error):
            self.view?.hideProgressHUD()
            self.view?.showError(message: error.userMessage())
            break
        }
    }
}
