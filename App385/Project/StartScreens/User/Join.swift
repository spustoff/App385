//
//  Join.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI

struct Join: View {
    
    let telegram: URL
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("users_3")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                
                Text("Join our Telegram")
                    .foregroundColor(Color("tx"))
                    .font(.system(size: 26, weight: .bold))
                
                Spacer()
                
                Button(action: {
                    
                    UIApplication.shared.open(telegram)
                    
                }, label: {
                    
                    Text("Join")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color("primary2")))
                })
            }
            .padding()
            
            VStack {
                
                NavigationLink(destination: {
                    
                    Not()
                        .navigationBarBackButtonHidden()
                    
                }, label: {
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .regular))
                        .padding(5)
                        .background(Circle().fill(Color("primary2").opacity(0.4)))
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    Join(telegram: URL(string: "h")!)
}
