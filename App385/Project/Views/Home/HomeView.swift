//
//  HomeView.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Home")
                    .foregroundColor(Color("tx"))
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 25)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        ForEach(viewModel.categories, id: \.self) { index in
                            
                            Button(action: {
                                
                                viewModel.currentCategory = index
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isDetail = true
                                }
                                
                            }, label: {
                                
                                VStack {
                                    
                                    Image(index)
                                        .resizable()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 170)
                                    
                                    Text(index)
                                        .foregroundColor(Color("tx"))
                                        .font(.system(size: 18, weight: .semibold))
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                            })
                            .padding(.bottom, 8)
                        }
                    }
                }
            }
            .padding()
            
            VStack {
                
                Spacer()
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAddCategory = true
                    }
                    
                }, label: {
                    
                    HStack {
                        
                        Image(systemName: "plus")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 12, weight: .regular))
                            .padding(4)
                            .background(Circle().fill(.white))
                        
                        Text("Add new category")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 14).fill(Color("prim")))
                })
                .padding()
                .padding(.bottom, 20)
            }
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddCategory ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddCategory  = false
                        }
                    }
                
                VStack {
                    
                    ZStack {
                        
                        HStack {
                            
                            Button(action: {
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isAddCategory  = false
                                }
                                
                            }, label: {
                                
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .font(.system(size: 11, weight: .regular))
                                    .padding(5)
                                    .background(Circle().fill(.white.opacity(0.2)))
                            })
                            
                            Spacer()
                            
                        }
                        
                        Text("Add new Category")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 16, weight: .medium))
                            .padding()
                        
                    }
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Enter")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.ACat.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.ACat)
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 14, weight: .regular))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("tx")))

                    Button(action: {
                        
                        viewModel.categories.append(viewModel.ACat)
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddCategory  = false
                        }
                        
                    }, label: {
                        
                        Text("Add")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                        
                    })
                    .disabled(viewModel.ACat.isEmpty ? true : false)
                    .opacity(viewModel.ACat.isEmpty ? 0.5 : 1)
                    .padding(.top, 120)
                    .padding(.bottom, 30)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .bottom)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg")).ignoresSafeArea())
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: viewModel.isAddCategory  ? 0 : UIScreen.main.bounds.height)
            }
        )
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            CategoriesView(viewModel: viewModel)
        })
    }
}

#Preview {
    HomeView()
}
