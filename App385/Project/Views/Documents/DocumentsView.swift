//
//  DocumentsView.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI

struct DocumentsView: View {
    
    @StateObject var viewModel = DocumentsViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Documents")
                    .foregroundColor(Color("tx"))
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 25)
                
                if viewModel.docs.isEmpty {
                    
                    VStack {
                        
                        Text("Empty")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 22, weight: .semibold))
                        
                        Text("You don’t have any documents here")
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
                            
                            Text("Add new document")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color("prim")))
                    })
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                            
                            ForEach(viewModel.docs, id: \.self) { index in
                                
                                VStack(alignment: .leading) {
                                    
                                    HStack {
                                        
                                        Text(index.docTitle ?? "")
                                            .foregroundColor(Color("tx"))
                                        
                                        Spacer()
                                     
                                        Menu(content: {
                                            
                                            Button(action: {
                                                
                                                viewModel.selectedDoc = index
                                                
                                                withAnimation(.spring()) {
                                                    
                                                    viewModel.isDelete = true
                                                }
                                                
                                            }, label: {
                                                
                                                Text("Delete")
                                            })
                                            
                                        }, label: {
                                            
                                            Text("...")
                                                .foregroundColor(Color("tx"))
                                                .font(.system(size: 16, weight: .semibold))
                                        })
                                    }
                                    
                                    Spacer()
                                    
                                    Text(index.docNumber ?? "")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 15, weight: .regular))
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 150)
                                .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                            }
                        })
                        
                    }
                }
            
            }
            .padding()
        }
        .onAppear{
            
            viewModel.fetchDocs()
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
                        
                        Text("Add new document")
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 16, weight: .medium))
                            .padding()
                        
                    }
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Document title")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.docTitle.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.docTitle)
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 14, weight: .regular))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("tx")))

                    ZStack(alignment: .leading, content: {
                        
                        Text("№")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.docNumber.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.docNumber)
                            .foregroundColor(Color("tx"))
                            .font(.system(size: 14, weight: .regular))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("tx")))
                    
                    Button(action: {
                                                
                        UIApplication.shared.endEditing()
                        
                        viewModel.addDoc()
                        
                        viewModel.docTitle = ""
                        viewModel.docNumber = ""
                        
                        viewModel.fetchDocs()
                        
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
                    .disabled(viewModel.docTitle.isEmpty || viewModel.docNumber.isEmpty ? true : false)
                    .opacity(viewModel.docTitle.isEmpty || viewModel.docNumber.isEmpty ? 0.5 : 1)
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
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        UIApplication.shared.endEditing()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            UIApplication.shared.endEditing()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Delete document")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    Text("Are you sure you want to delete? It will be permanently deleted")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        
                        UIApplication.shared.endEditing()
                        
                        CoreDataStack.shared.deleteDoc(withDocTitle: viewModel.selectedDoc?.docTitle ?? "", completion: {
                            
                            viewModel.fetchDocs()
                        })
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                            
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
                        
                        UIApplication.shared.endEditing()
                        
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
    DocumentsView()
}
