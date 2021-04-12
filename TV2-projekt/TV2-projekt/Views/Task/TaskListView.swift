//
//  TaskListView.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 22/03/2021.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskViewModel: TaskVM
    @EnvironmentObject var userVM: UserVM
    var body: some View {
        NavigationView {
            List(taskViewModel.tasks) { task in
                if userVM.user.completedTasks.contains(task.id) {
                    TaskRowViewDone(task: task)
                } else {
                    TaskRowView(task: task)
                }
            }
            .navigationTitle("Tasks")
        }
        .onAppear() {
            self.taskViewModel.fetchTasks()
        }
        
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
