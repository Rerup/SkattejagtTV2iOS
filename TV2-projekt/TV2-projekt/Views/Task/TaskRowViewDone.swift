//
//  TaskRowViewDone.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 22/03/2021.
//

import SwiftUI

struct TaskRowViewDone: View {
    var task: Task
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(task.name)
                Text("\(task.hint)?????")
            }
            .padding()
            Spacer()
        }
    }
}

struct TaskRowViewDone_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowViewDone(task: Task.data)
    }
}
