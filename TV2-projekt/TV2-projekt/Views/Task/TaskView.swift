//
//  TaskView.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 15/03/2021.
//

import SwiftUI

struct TaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var taskViewModel: TaskVM
    @EnvironmentObject var userVM: UserVM
    @State private var showingAlert = false
    var body: some View {
        
            VStack {
                Text("\(taskViewModel.task.name)")
                    .font(.largeTitle)
                Text("\(taskViewModel.task.description)")
                    .font(.title)
                TextField("Answer", text: self.$taskViewModel.answer)
                    .font(.title)
                Button(action: {
                    if self.taskViewModel.task.solution == self.taskViewModel.answer {
                        userVM.updateCompletedTasks(taskId: taskViewModel.task.id) { (result) in
                            switch result {
                            case .failure( _):
                                print("something went wroooooooong updating the id")
                            case .success( _):
                                print("Signed in")
                            }
                        }
                    } else {
                        print("Fejl")
                    }
                }) {
                    Text("Click here")
                }
                .padding()
                .background(Color("Leaderboard"))
            }
            .padding()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Important message"), message: Text("Du svarede korrekt"), dismissButton: .default(Text("Got it!")))
            }
        
    }

}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
            .environmentObject(TaskVM())
    }
}
