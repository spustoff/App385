//
//  R2.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI

struct R2: View {
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("reviewers_2")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                
                Text("Important information")
                    .foregroundColor(Color("tx"))
                    .font(.system(size: 26, weight: .bold))
                
                Spacer()
                
                NavigationLink(destination: {
                    
                    R3()
                        .navigationBarBackButtonHidden()
                    
                }, label: {
                    
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color("primary2")))
                })
            }
            .padding()
        }
    }
}

#Preview {
    R2()
}
