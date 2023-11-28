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
    
    @EnvironmentObject var modelli: Modelli
    
    @Binding var model: String?
    
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
                Image(uiImage: (modelli.findModello(name: model!))!.image!)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .padding(.top, 100)
                    .padding(.bottom, 100)
                Spacer()
            }
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.darkGray)
                        VStack(alignment: .leading) {
                            HStack {
                                Text((modelli.findModello(name: model!))!.name)
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                            }
                            .padding(.bottom)
                            
                            ScrollView {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Description")
                                            .font(.system(size: 25))
                                            .fontWeight(.bold)
                                    }
                                    .padding(.bottom)
                                    HStack {
                                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                                            .font(.body)
                                        
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
        .background(LinearGradient(colors: [.darkGray, .lightGray], startPoint: .top, endPoint: .bottom))
        .navigationBarBackButtonHidden(true)
    }
    

}
