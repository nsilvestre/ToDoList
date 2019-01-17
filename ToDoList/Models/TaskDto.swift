//
//  Task.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/16/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import Foundation
import ObjectMapper

class TaskDto: NSObject, Mappable {
    var id: Int32?
    var title: String?
    var detail: String?
    var created: String?
    var updated: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        detail <- map["detail"]
        created <- map["created"]
        updated <- map["updated"]
    }
}
