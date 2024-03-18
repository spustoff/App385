//
//  LoadingView.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            Image("logo2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
            
            VStack {
                
                Spacer()
                
                ProgressView()
                    .padding()
            }
        }
    }
}

#Preview {
    LoadingView()
}
