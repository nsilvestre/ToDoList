//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/16/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var lTitle: UILabel!
    @IBOutlet weak var lDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindTo(task: TaskDto) {
        lTitle.text = task.title
        lDetail.text = task.detail
    }
}
