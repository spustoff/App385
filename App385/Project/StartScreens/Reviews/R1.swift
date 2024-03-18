//
//  R1.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI

struct R1: View {
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("reviewers_1")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                
                Text("Manage your home")
                    .foregroundColor(Color("tx"))
                    .font(.system(size: 26, weight: .bold))
                
                Spacer()
                
                NavigationLink(destination: {
                    
                    R2()
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
    R1()
}
