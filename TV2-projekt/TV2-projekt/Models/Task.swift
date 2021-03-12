//
//  Task.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 04/03/2021.
//

import SwiftUI

struct Task : Encodable, Decodable {
    var id: String
    var name: String
    var description: String
    var hint: String
    var solution: String
    var answer: String?
    var point: Int
    
    
    /*
    var isDone: Bool {
        if solution.uppercased() == answer.uppercased() {
            return true
        } else {
            return false
        }
    }
    */
    
    //Når der kreeres en
    init(name:String, description: String, hint:String, solution:String, point: Int) {
        self.id = UUID().uuidString
        self.name = name
        self.description = description
        self.hint = hint
        self.solution = solution
        self.point = point
    }
    
    //Når der hentes en
    init(id: String, name:String, description: String, hint:String, solution:String, point: Int ) {
        self.id = id
        self.name = name
        self.description = description
        self.hint = hint
        self.solution = solution
        self.point = point
    }
}

extension Task {
    static var data: Task {
            Task(id: "E13AE161-88A9-4A9A-9E79-318A9CBBCC90", name: "Task X", description: "What is 2+2", hint: "In cafeteria", solution: "4", point: 10)
    }
}

