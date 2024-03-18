//
//  Not.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI
import OneSignalFramework

struct Not: View {
 
    @AppStorage("status") var status: Bool = false
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("users_4")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                
                Text("Don’t miss anything")
                    .foregroundColor(Color("tx"))
                    .font(.system(size: 26, weight: .bold))
                
                Spacer()
                
                Button(action: {
                    
                    OneSignal.Notifications.requestPermission({ accepted in
                      print("User accepted notifications: \(accepted)")
                        status = true
                    }, fallbackToSettings: true)
                    
                }, label: {
                    
                    Text("Enable Notifications")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color("primary2")))
                })
            }
            .padding()
            
            VStack {
                
                Button(action: {
                    
                    status = true
                    
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
    Not()
}
