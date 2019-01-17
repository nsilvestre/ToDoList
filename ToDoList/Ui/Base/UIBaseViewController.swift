//
//  BaseViewController.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/17/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import TTGSnackbar

class UIBaseViewController: UIViewController {
    fileprivate var snackbar: TTGSnackbar?
    
    func showProgressHUD() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideProgressHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showError(message: String) {
        if let snackbar = snackbar {
            snackbar.message = message
            snackbar.show()
        }
    }
}
