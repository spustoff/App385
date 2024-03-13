//
//  PlanningView.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI

struct PlanningView: View {
    
    @StateObject var viewModel = PlanningViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isCurrencies = true
                    }
                    
                }, label: {
                    
                    Text(viewModel.currCur)
                        .foregroundColor(Color("tx"))
                        .font(.system(size: 16, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                })
                
                Text("Planning")
                    .foregroundColor(Color("tx"))
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 25)
                
                if viewModel.items.isEmpty {
                    
                    VStack {
                        
                        Text("Empty")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 22, weight: .semibold))
                        
                        Text("You don’t have any items here")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 14, weight: .regular))

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
                            
                            Text("Add new item")
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
                            
                            ForEach(viewModel.items, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.selectedItem = index
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDetail = true
                                    }
                                    
                                }, label: {
                                    
                                    VStack(alignment: .leading, spacing: 12) {
                                        
                                        Text("#\(index.pCategory ?? "")")
                                            .foregroundColor(Color("prim"))
                                            .font(.system(size: 12, weight: .regular))
                                            .padding(4)
                                            .padding(.horizontal, 6)
                                            .background(RoundedRectangle(cornerRadius: 8).fill(Color("prim").opacity(0.2)))
                                        
                                        Text(index.pTitle ?? "")
                                            .foregroundColor(Color("tx"))
                                            .font(.system(size: 18, weight: .bold))
                                        
                                        HStack {
                                            
                                            Spacer()
                                            
                                            Text("$\(index.pCost ?? "")")
                                                .foregroundColor(Color("prim"))
                                                .font(.system(size: 25,weight: .bold))
                                        }
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 20).fill(.white))
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
                            
                            Text("Add new item")
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
            
            viewModel.fetchItems()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAdd ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        UIApplication.shared.endEditing()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd  = false
                        }
                    }
                
                VStack {
                    
                    ZStack {
                        
                        HStack {
                            
                            Button(action: {
                                
                                UIApplication.shared.endEditing()
                                
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
                        
                        Text("Add new item")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 16, weight: .medium))
                            .padding()
                        
                    }
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Item title")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.pTitle.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.pTitle)
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 14, weight: .regular))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("tx")))
                    
                    Menu(content: {
                        
                        ForEach(viewModel.categories, id: \.self) { index in
                          
                            Button(action: {
                                
                                viewModel.currentCategory = index
                                
                            }, label: {
                                
                                Text(index)
                            })
                        }
                        
                    }, label: {
                        
                        if viewModel.currentCategory.isEmpty {
                            
                            HStack {
                                
                                Text("Category")
                                    .foregroundColor(Color("tx"))
                                    .font(.system(size: 14, weight: .regular))
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color("tx"))
                                    .font(.system(size: 16, weight: .regular))
                                
                                Spacer()
                            }
                            
                        } else {
                            
                            HStack {
                                
                                Text(viewModel.currentCategory)
                                    .foregroundColor(Color("tx"))
                                    .font(.system(size: 14, weight: .regular))
                                
                                Spacer()
                            }
                        }
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("tx")))

                    ZStack(alignment: .leading, content: {
                        
                        Text("$ Cost")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.pCost.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.pCost)
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 14, weight: .regular))
                            .keyboardType(.decimalPad)
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("tx")))
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Notes")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.pNotes.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.pNotes)
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 14, weight: .regular))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("tx")))

                    Button(action: {
                        
                        UIApplication.shared.endEditing()
                        
                        viewModel.pCategory = viewModel.currentCategory
                        
                        viewModel.addItem()
                        
                        viewModel.pTitle = ""
                        viewModel.pCost = ""
                        viewModel.pNotes = ""
                        viewModel.currentCategory = ""
                        
                        viewModel.fetchItems()
                        
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
                    .disabled(viewModel.pTitle.isEmpty || viewModel.pCost.isEmpty || viewModel.pNotes.isEmpty || viewModel.currentCategory.isEmpty ? true : false)
                    .opacity(viewModel.pTitle.isEmpty || viewModel.pCost.isEmpty || viewModel.pNotes.isEmpty || viewModel.currentCategory.isEmpty ? 0.5 : 1)
                    .padding(.top, 120)
                    .padding(.bottom, 30)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .bottom)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg"))                .ignoresSafeArea())
                .offset(y: viewModel.isAdd  ? 0 : UIScreen.main.bounds.height)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        )
        .sheet(isPresented: $viewModel.isCurrencies, content: {
            
            CurrencyPair(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            ItemDetail(viewModel: viewModel)
        })
    }
}

#Preview {
    PlanningView()
}

extension UIApplication {
    
    public func endEditing() {
        
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
