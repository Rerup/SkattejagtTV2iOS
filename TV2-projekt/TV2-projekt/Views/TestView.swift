//
//  TestView.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 02/03/2021.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
            }
            .frame(width: 300, height: 220)
            .background(Color("secondcolor"))
            .cornerRadius(20)
            .shadow(radius: 20)
            .offset(x: 0, y: -20)
            
            VStack {
                HStack {
                    VStack (alignment: .leading) {
                        Text("Titel")
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("Noget tekst")
                            .foregroundColor(Color("secondcolor"))
                    }
                    Spacer()
                }
                .padding(20)
                Spacer()
            }
            .frame(width: 340, height: 220)
            .background(Color("cardcolor"))
            .cornerRadius(20)
            .shadow(radius: 10)
        }
        
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
