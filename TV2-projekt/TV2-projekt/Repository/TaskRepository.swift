//
//  TaskRepository.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 09/03/2021.
//

import SwiftUI
import Firebase
import FirebaseDatabase

let databaseRef = Database.database().reference()

struct TaskRepository {
    
    func createTask (task: Task) {
        databaseRef.child("tasks").child(task.id).setValue(["name": task.name, "description": task.description, "hint": task.hint, "solution": task.solution, "point": task.point])
    }
    
}
