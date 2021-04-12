//
//  HomeView.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 12/03/2021.
//

import SwiftUI
import CodeScanner

struct HomeView: View {
    enum Action {
        case scan, userdetail, taskactive
    }
    @State private var showSheet = false
    @State private var action: Action?
    @EnvironmentObject var userVM: UserVM
    @EnvironmentObject var taskViewModel: TaskVM
    var body: some View {
        NavigationView {
            
            VStack {
                //MARK: Første knap
                Button(action: {
                    self.action = .scan
                    self.showSheet = true
                }) {
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Scanner")
                                .font(.title)
                                .bold()
                            Text("Scan your NFC chip here")
                        }
                        Spacer()
                        Image(systemName: "wave.3.forward.circle.fill").imageScale(.large)
                    }
                }
                .padding()
                .background(Color("Scanner"))
                
                //MARK: Anden knap
                NavigationLink(destination: TaskListView()) {
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Skattejagt")
                                .font(.title)
                                .bold()
                            Text("See what you're missing?")
                        }
                        Spacer()
                        Image(systemName: "map.fill")
                    }
                }
                .padding()
                .background(Color("Skattejagt"))
                
                //MARK: Trejde knap scanner
                NavigationLink(destination: CreateTaskView()) {
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Leaderboard")
                                .font(.title)
                                .bold()
                            Text("Which Department is the best?")
                        }
                        Spacer()
                        Image(systemName: "person.3.fill")
                    }
                }
                .padding()
                .background(Color("Leaderboard"))
            }
            .foregroundColor(.white)
            .cornerRadius(16)
            .padding()
            .sheet(isPresented: $showSheet) {
                if action == .scan {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Some simulated data", completion: self.handleScan)
                } else if action == .userdetail {
                    userVM.
                } else if action == .taskactive {
                    TaskView()
                }
            }
            .navigationBarTitle("Welcome \(userVM.user.name)")
            .navigationBarItems(trailing: Button(action: {
                self.action = .userdetail
                self.showSheet = true
            }) {
                Image(systemName: "person.circle").imageScale(.large)
            })
        }
    }
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.showSheet = false
        switch result {
        case .success(let data):
            if taskViewModel.handleScan(jsonString: data, ids: userVM.user.completedTasks) == true {
                print("Succes")
                self.action = .taskactive
                self.showSheet = true
            } else {
                print("You have already done this")
            }
        case .failure(let error):
            print("Scanning failed \(error)")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
