//
//  ScannerView.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 10/03/2021.
//

import SwiftUI
import CodeScanner

struct ScannerView: View {
    @State private var isScannerShowing = false
    @State private var taskViewModel = TaskViewModel()
    @State private var isTaskScreenActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: TestView(), isActive: $isTaskScreenActive) {
                    EmptyView()
                }
                
                Button(action: {isScannerShowing = true}) {
                    VStack {
                        Label("Icon", systemImage: "qrcode")
                            .font(.largeTitle)
                            .labelStyle(IconOnlyLabelStyle())
                            .padding(30)
                        Text("Klik her for at begynde scanning")
                            .font(.headline)
                    }
                }
                .sheet(isPresented: $isScannerShowing) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Some simulated data", completion: self.handleScan)
                }
            }
        }
    }
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isScannerShowing = false
        switch result {
        case .success(let data):
            taskViewModel.handleScan(jsonString: data)
            //Check for om brugeren allerede har løst opgave
            //Bind user til dette view også send user tilbage viewmodel og check.
            self.isTaskScreenActive = true
            
        case .failure(let error):
            print("Scanning failed \(error)")
        }
    }
}


struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
