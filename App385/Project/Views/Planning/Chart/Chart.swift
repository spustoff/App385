//
//  Chart.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI

struct Chart: View {
    
    @StateObject var viewModel: PlanningViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text(viewModel.currCur)
                    .foregroundColor(Color("tx"))
                    .font(.system(size: 18, weight: .medium))
                    .padding()
                    .padding(.bottom, 15)
                
                HStack {
  
                    Text("$\(String(format: "%.f", Double(.random(in: 32...59)))),\(String(format: "%.f", Double(.random(in: 2...5))))\(String(format: "%.f", Double(.random(in: 32...59))))")
                        .foregroundColor(Color("tx"))
                        .font(.system(size: 18, weight: .semibold))
                    
                    Text("+\(String(format: "%.f", Double(.random(in: 2...5)))),\(String(format: "%.f", Double(.random(in: 2...5))))\(String(format: "%.f", Double(.random(in: 2...5))))")
                        .foregroundColor(.green)
                        .font(.system(size: 10, weight: .regular))
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Image("chart")
                    .resizable()
                
                HStack {
                    
                    Button(action: {
                        
                        viewModel.currentCurrency = viewModel.currCur
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Text("Apply")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 12).fill(.green))
                    })
                    .padding(.leading)
                    
                    Button(action: {
                        
                        viewModel.currentCurrency = viewModel.currCur
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Text("Back")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 12).fill(.red))
                    })
                    .padding(.trailing)
                }
                .padding(.vertical)
            }
        }
    }
}

#Preview {
    Chart(viewModel: PlanningViewModel())
}
