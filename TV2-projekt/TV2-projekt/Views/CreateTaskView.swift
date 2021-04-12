//
//  CreateTaskView.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 09/03/2021.
//

import SwiftUI

struct CreateTaskView: View {
    @EnvironmentObject var taskViewModel: TaskVM
    @State private var counter = 0.0
    var body: some View {
        List {
            Section(header: Text("New task")) {
                TextField("Name", text: $taskViewModel.name)
                TextField("Description", text: $taskViewModel.description)
                TextField("Solution", text: $taskViewModel.solution)
                TextField("Hint", text: $taskViewModel.hint)
                HStack {
                    Slider(value: $counter, in: 1...20, step: 1.0) {
                        Text("Lenght")
                    }
                    Spacer()
                    Text("\(Int(counter))")
                }
                HStack {
                    Label("Add task", systemImage: "folder")
                    Spacer()
                    Button(action: {
                        withAnimation {
                            taskViewModel.CreateTask()
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
