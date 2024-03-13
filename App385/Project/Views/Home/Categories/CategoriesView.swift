//
//  CategoriesView.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI

struct CategoriesView: View {
    
    @StateObject var viewModel: HomeViewModel
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
                .padding(.bottom)
                
                Text(viewModel.currentCategory)
                    .foregroundColor(Color("tx"))
                    .font(.system(size: 26, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                
                if viewModel.furnitures.isEmpty {
                    
                    VStack {
                        
                        Text("Empty")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .frame(maxHeight: .infinity)
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = true
                        }
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "plus")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 12, weight: .regular))
                                .padding(4)
                                .background(Circle().fill(.white))
                            
                            Text("Add new \(viewModel.currentCategory)")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color("prim")))
                    })
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.furnitures, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.selectedFurniture = index
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDelete = true
                                    }
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        VStack(alignment: .leading, spacing: 12) {
                                            
                                            Text(index.furDate ?? "")
                                                .foregroundColor(Color("tx"))
                                                .font(.system(size: 12, weight: .regular))
                                            
                                            Text(index.furTitle ?? "")
                                                .foregroundColor(Color("tx"))
                                                .font(.system(size: 18, weight: .regular))
                                        }
                                        
                                        Spacer()
                                        
                                        Text("$\(index.furCost ?? "")")
                                            .foregroundColor(Color("prim"))
                                            .font(.system(size: 24, weight: .bold))
                                        
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                                })
                            }
                        }
                    }
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = true
                        }
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "plus")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 12, weight: .regular))
                                .padding(4)
                                .background(Circle().fill(.white))
                            
                            Text("Add new \(viewModel.currentCategory)")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color("prim")))
                    })
                }
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchFurnitures()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAdd ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd  = false
                        }
                    }
                
                VStack {
                    
                    ZStack {
                        
                        HStack {
                            
                            Button(action: {
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isAdd  = false
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
                        
                        Text("Add new furniture")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 16, weight: .medium))
                            .padding()
                        
                    }
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Item title")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.furTitle.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.furTitle)
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 14, weight: .regular))
                            .keyboardType(.decimalPad)
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("tx")))

                    ZStack(alignment: .leading, content: {
                        
                        Text("Date of purchase")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.furDate.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.furDate)
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 14, weight: .regular))
                            .keyboardType(.decimalPad)
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("tx")))
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("$ Cost")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.furCost.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.furCost)
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 14, weight: .regular))
                            .keyboardType(.decimalPad)
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("tx")))

                    Button(action: {
                        
                        viewModel.furCategory = viewModel.currentCategory
                        
                        viewModel.addFurniture()
                        
                        viewModel.furTitle = ""
                        viewModel.furDate = ""
                        viewModel.furCost = ""
                        
                        viewModel.fetchFurnitures()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd  = false
                        }
                        
                    }, label: {
                        
                        Text("Add")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                        
                    })
                    .disabled(viewModel.furTitle.isEmpty || viewModel.furDate.isEmpty || viewModel.furCost.isEmpty || viewModel.currentCategory.isEmpty ? true : false)
                    .opacity(viewModel.furTitle.isEmpty || viewModel.furDate.isEmpty || viewModel.furCost.isEmpty || viewModel.currentCategory.isEmpty ? 0.5 : 1)
                    .padding(.top, 120)
                    .padding(.bottom, 30)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .bottom)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg")))
                .offset(y: viewModel.isAdd  ? 0 : UIScreen.main.bounds.height)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            }
        )
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Delete item")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    Text("Are you sure you want to delete? It will be permanently deleted")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        
                        CoreDataStack.shared.deleteFur(withFurTitle: viewModel.selectedFurniture?.furTitle ?? "", completion: {
                            
                            viewModel.fetchFurnitures()
                        })
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = true
                            
                        }
                                
                    }, label: {
                        
                        Text("Delete")
                            .foregroundColor(.red)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                    .padding(.top, 25)
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                        
                    }, label: {
                        
                        Text("Cancel")
                            .foregroundColor(.blue)
                            .font(.system(size: 18, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg").opacity(0.9)))
                .padding()
                .offset(y: viewModel.isDelete ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    CategoriesView(viewModel: HomeViewModel())
}
