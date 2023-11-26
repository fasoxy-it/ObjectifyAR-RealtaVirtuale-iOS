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
    
    var model: String?
    
    var m: Modello?
    
    var modelli: Modelli
    
    let ragno = Color(red: 0.109803921568627, green: 0.109803921568627, blue: 0.117647058823529)
    let serpente = Color(red: 0.356862745098039, green: 0.356862745098039, blue: 0.356862745098039)

    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Image(uiImage: (modelli.findModello(name: model!))!.image)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .padding(.vertical, 100)
                Spacer()
            }
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(ragno)
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                Text((modelli.findModello(name: model!))!.name)
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                            }
                            .padding(.bottom)
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
                        .padding(.all, 30)
    
                    }
                    
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
        
        }
        .background(LinearGradient(colors: [ragno, serpente], startPoint: .top, endPoint: .bottom))
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden, for: .automatic)
        
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "arrow.backward.square.fill")
                    .font(.system(size: 38))
                    .foregroundColor(.blue)
                    .onTapGesture {
                        dismiss()
                    }
                    .padding(.top, 30)
                    .padding(.leading, -10)
                
            }
        }
        
        
    
        
        
    }
    

}
