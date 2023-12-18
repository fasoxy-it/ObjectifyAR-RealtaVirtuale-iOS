//
//  DetailView.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 08/11/23.
//

import SwiftUI
import RealityKit

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var model: Modello?
    @State var description: String = ""
    @State private var presentAlert = false
    
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: "arrow.backward.square.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)
                    .onTapGesture {
                        dismiss()
                    }
                    .padding(.leading, 10)
                    .padding(.top, 10)
                Spacer()
            }
            
            HStack {
                Spacer()
                Image(uiImage: model!.image!)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .padding(.top, 75)
                    .padding(.bottom, 100)
                Spacer()
            }
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.darkGray)
                        VStack(alignment: .leading) {
                            HStack {
                                Text(model!.name)
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                            }
                            .padding(.bottom)
                            
                            ScrollView {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Dimensions")
                                            .font(.system(size: 25))
                                            .fontWeight(.bold)
                                    }
                                    .padding(.bottom)
                                    HStack {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                HStack(alignment: .center) {
                                                    Image(systemName: "circle.fill")
                                                        .font(.system(size: 10))
                                                }
                                                
                                                Text("Width: \(String(format: "%.2f", model!.dimensions!.x * 100)) Cm")
                                                    .font(.body)
                                            }
                                            HStack {
                                                HStack(alignment: .center) {
                                                    Image(systemName: "circle.fill")
                                                        .font(.system(size: 10))
                                                }
                                                
                                                Text("Height: \(String(format: "%.2f", model!.dimensions!.y * 100)) Cm")
                                                    .font(.body)
                                            }
                                            HStack {
                                                HStack(alignment: .center) {
                                                    Image(systemName: "circle.fill")
                                                        .font(.system(size: 10))
                                                }
                                                
                                                Text("Depth: \(String(format: "%.2f", model!.dimensions!.z * 100)) Cm")
                                                    .font(.body)
                                            }
                                   
                                        }
                                    }
                                    .padding(.bottom)
                                    HStack {
                                        Text("Description")
                                            .font(.system(size: 25))
                                            .fontWeight(.bold)
                                        Spacer()
                                        Button {
                                            presentAlert = true
                                            description = model?.description ?? ""
                                        } label: {
                                            Image(systemName: "square.and.pencil")
                                                .font(.system(size: 20))
                                        }
                                        .alert("Description", isPresented: $presentAlert, actions: {
                                            TextField("Provide a description...", text: $description)
                                            Button("Ok", action: {model?.changeDescription(description: description)})
                                        })
                                    }
                                    .padding(.bottom)
                                    HStack {
                                        model?.description != nil ?
                                            Text((model?.description)!)
                                                .font(.body) :
                                            Text("No description yet...")
                                                .font(.body)
                                                .italic()
                                        }
                                    Spacer()
                                }
                                
                            }
                            
                        }
                        .padding(.all, 30)
                    
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
        
        }
        .background(LinearGradient(colors: [.darkGray, .midGray], startPoint: .top, endPoint: .bottom))
        .navigationBarBackButtonHidden(true)
    }
    

}
