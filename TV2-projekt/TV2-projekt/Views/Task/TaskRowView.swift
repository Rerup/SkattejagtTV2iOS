//
//  TaskRowView.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 22/03/2021.
//

import SwiftUI

struct TaskRowView: View {
    var task: Task
    var body: some View {    
        HStack {
            VStack (alignment: .leading) {
                Text("\(task.hint)?????")
            }
            .padding()
            Spacer()
        }
        .opacity(0.5)
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowView(task: Task.data)
    }
}
