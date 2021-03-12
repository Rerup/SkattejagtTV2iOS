//
//  CreateTaskView.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 09/03/2021.
//

import SwiftUI

struct CreateTaskView: View {
    @State private var taskViewModel = TaskViewModel()
    @State private var name = ""
    @State private var description = ""
    @State private var hint = ""
    @State private var solution = ""
    @State private var point = 0.0
    var body: some View {
        
        List {
            Section(header: Text("New task")) {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
                TextField("Solution", text: $solution)
                TextField("Hint", text: $hint)
                HStack {
                    Slider(value: $point, in: 1...20, step: 1.0) {
                        Text("Lenght")
                    }
                    Spacer()
                    Text("\(Int(point))")
                }
                HStack {
                    Label("Add task", systemImage: "folder")
                    Spacer()
                    Button(action: {
                        withAnimation {
                            taskViewModel.CreateTask(task: Task(name: name, description: description, hint: hint, solution: solution, point: Int(point)))
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView()
    }
}
