//
//  SettingsView.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Settings")
                    .foregroundColor(Color("tx"))
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 25)
                
                Button(action: {
                    
                    guard let url = URL(string: DataManager().usagePolicy) else { return }
                    
                    UIApplication.shared.open(url)
                    
                }, label: {
                    
                    HStack {
                        
                        Image(systemName: "list.dash.header.rectangle")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 20, weight: .regular))
                        
                        Text("Usage profile")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 16, weight: .regular))
                        
                        Spacer()
                        
                    }
                    .padding()
                    .frame(height: 70)
                    .background(RoundedRectangle(cornerRadius: 16).fill(.white))
                })
                
                Button(action: {
                    
                    SKStoreReviewController.requestReview()
                    
                }, label: {
                    
                    HStack {
                        
                        Image(systemName: "star")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 20, weight: .regular))
                        
                        Text("Rate app")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 16, weight: .regular))
                        
                        Spacer()
                        
                    }
                    .padding()
                    .frame(height: 70)
                    .background(RoundedRectangle(cornerRadius: 16).fill(.white))
                })
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}
