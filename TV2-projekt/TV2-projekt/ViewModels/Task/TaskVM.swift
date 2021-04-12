//
//  TaskVM.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 09/03/2021.
//

import SwiftUI
import Firebase
import CodeScanner

let storage = Storage.storage()
let storageRef = storage.reference()
let taskRepo = TaskRepository()

class TaskVM: ObservableObject {
    @Published var tasks = [Task]()
    var name: String = ""
    var description: String = ""
    var hint: String = ""
    var solution: String = ""
    var point: Double = 0.0

    @Published var task: Task = .init(id: "",name: "", description: "", hint: "", solution: "", point: 0)
    var answer: String = ""
    private var isSucces: Bool = true
    
    func handleScan (jsonString: String, ids: [String]) -> Bool {
        if let jsonData = jsonString.data(using: .utf8)
        {
            let decoder = JSONDecoder()
            do {
                self.task = try decoder.decode(Task.self, from: jsonData)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        for item in ids {
            if item == self.task.id {
                isSucces = false
                return isSucces
            }
            else {
                isSucces = true
            }
        }
        return isSucces
    }
    
    func CreateTask() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let newTask = Task(name: self.name, description: self.description, hint: self.hint, solution: self.solution, point: Int(self.point))
        
        let imageStorageRef = storageRef.child(newTask.name)
        
        do {
            let jsonData = try encoder.encode(newTask)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
              let image = generateQRCode(string: jsonString)
                imageStorageRef.putData(image!.pngData()! as Data, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        //error
                        return
                    }

                    taskRepo.createTask(task: newTask)
                   print(metadata)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func generateQRCode (string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    
    func fetchTasks() {
        db.collection("tasks").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.tasks = documents.map { (queryDocumentSnapshot) -> Task in
                let data = queryDocumentSnapshot.data()
                
                let id = data["id"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let hint = data["hint"] as? String ?? ""
                let point = data["point"] as? Int ?? 0
                let solution = data["solution"] as? String ?? ""
                
                return Task(id: id, name: name, description: description, hint: hint, solution: solution, point: point)
            }
        }
    }
}
