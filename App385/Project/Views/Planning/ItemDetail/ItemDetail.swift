//
//  ItemDetail.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI

struct ItemDetail: View {
    
    @StateObject var viewModel: PlanningViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color("tx"))
                                    .font(.system(size: 16, weight: .regular))
                                
                                Text("Back")
                                    .foregroundColor(Color("tx"))
                                    .font(.system(size: 16, weight: .regular))
                                
                                Spacer()
                            }
                        })
                        
                        Spacer()
                    }
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text(viewModel.selectedItem?.pTitle ?? "")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 26, weight: .bold))
                        
                        HStack {
                            
                            Text("#\(viewModel.selectedItem?.pCategory ?? "")")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 12, weight: .regular))
                                .padding(4)
                                .padding(.horizontal, 6)
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color("prim").opacity(0.2)))
                            
                            Spacer()
                            
                            Text("$\(viewModel.selectedItem?.pCost ?? "")")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 25,weight: .bold))
                        }
                        
                        Text("Nores")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 16, weight: .medium))
                        
                        Text(viewModel.selectedItem?.pNotes ?? "")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 14, weight: .regular))
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ItemDetail(viewModel: PlanningViewModel())
}
