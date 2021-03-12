//
//  TaskViewModel.swift
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

struct TaskViewModel {
    //Denne task skal anvendes til at blive vist i et opgave view, den bliver sat af handleScan
    var task: Task?
    
    
    mutating func handleScan (jsonString: String) -> Bool {
        var userAlreadyDoneTask = false
        if let jsonData = jsonString.data(using: .utf8)
        {
            //Tilføj funktionalitet så der bliver tjekket for om id allerede er brugt.
            let decoder = JSONDecoder()
            do {
                self.task = try decoder.decode(Task.self, from: jsonData)
                userAlreadyDoneTask = false
            } catch {
                userAlreadyDoneTask = true
                print(error.localizedDescription)
            }
        }
        return userAlreadyDoneTask
    }
    
    func CreateTask(task: Task) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let imageStorageRef = storageRef.child("\(task.name)")

        do {
            let jsonData = try encoder.encode(task)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                let image = generateQRCode(string: jsonString)
                imageStorageRef.putData(image!.pngData()! as Data, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        //error
                        return
                    }
                    taskRepo.createTask(task: task)
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
}
