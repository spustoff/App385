//
//  CurrencyPair.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI

struct CurrencyPair: View {
    
    @StateObject var viewModel: PlanningViewModel
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Currency pair")
                    .foregroundColor(Color("tx"))
                    .font(.system(size: 16, weight: .medium))
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    ForEach(viewModel.currencies, id: \.self) { index in
                    
                        VStack {
                            
                            Button(action: {
                                
                                viewModel.currCur = index
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isChart = true
                                }
                                
                            }, label: {
                                
                                HStack {
                                    
                                    Text(index)
                                        .foregroundColor(.black)
                                        .font(.system(size: 16,weight: .semibold))
                                    
                                    Spacer()
                                 
                                    VStack(alignment: .trailing, spacing: 12) {
                                        
                                        Text("+\(String(format: "%.f", Double(.random(in: 2...5)))),\(String(format: "%.f", Double(.random(in: 2...5))))\(String(format: "%.f", Double(.random(in: 2...5))))")
                                            .foregroundColor(.green)
                                            .font(.system(size: 10, weight: .regular))
                                        
                                        Text("$\(String(format: "%.f", Double(.random(in: 32...59)))),\(String(format: "%.f", Double(.random(in: 2...5))))\(String(format: "%.f", Double(.random(in: 32...59))))")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, weight: .semibold))
                                    }
                                }
                            })
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 16).fill(.white))
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.isChart, content: {
            
            Chart(viewModel: viewModel)
        })
    }
}

#Preview {
    CurrencyPair(viewModel: PlanningViewModel())
}
