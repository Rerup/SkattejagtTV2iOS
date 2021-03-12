//
//  FrontPageView.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 02/03/2021.
//

import SwiftUI
import CodeScanner

struct FrontPageView: View {
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        NavigationView {
            VStack {
                
                //MARK: Første knap scanner
                NavigationLink(destination: ScannerView()) {
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
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 130, maxHeight: 130)
                .background(Color("Scanner"))
                
                
                
                //MARK: Anden knap scanner
                NavigationLink(destination: TestView()) {
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
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 130, maxHeight: 130)
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
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 130, maxHeight: 130)
                .background(Color("Leaderboard"))
            }
            .foregroundColor(.white)
            .cornerRadius(16)
            .padding(.top, -200)
            .padding()
            .navigationBarTitle("Forside")
            .navigationBarItems(trailing: Button(action: {}) {
                Image(systemName: "person.circle").imageScale(.large)
            })
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            FrontPageView()
        }
    }
    
}
