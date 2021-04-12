//
//  TaskRepository.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 09/03/2021.
//

import Foundation
import FirebaseFirestore

let taskRef = db.collection("tasks")

struct TaskRepository {
    
    func createTask (task: Task) {
        db.collection("tasks").document(task.id).setData([
            "id": task.id,
            "name": task.name,
            "description": task.description,
            "hint": task.hint,
            "point": task.point,
            "solution": task.solution
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
   /* func retriveTasks() -> [Task] {
        let listOfTasks: [Task] = taskRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
 */
    
}
