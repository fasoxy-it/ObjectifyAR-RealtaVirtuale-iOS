//
//  DocumentationView.swift
//  ObjectifyAR
//
//  Created by Mattia Fasoli on 18/12/23.
//

import SwiftUI

struct DocumentationView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Documentation")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                Spacer()
            }
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.lightGray)
                                .frame(width: 100, height: 100)
                            Image(.tapGesture)
                        }
                        VStack(alignment: .leading) {
                            Text("Tap Gesture")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                            Text("Briefly touch surface with fingertip.")
                                .font(.body)
                        }
                        .padding(.leading, 15)
                        Spacer()
                    }
                    HStack(alignment: .top) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.lightGray)
                                .frame(width: 100, height: 100)
                            Image(.longPressGesture)
                        }
                        VStack(alignment: .leading) {
                            Text("Long-Press Gesture")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                            Text("Touch surface for extender period of time.")
                                .font(.body)
                        }
                        .padding(.leading, 15)
                        Spacer()
                    }
                    HStack(alignment: .top) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.lightGray)
                                .frame(width: 100, height: 100)
                            Image(.panGesture)
                        }
                        VStack(alignment: .leading) {
                            Text("Pan Gesture")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                            Text("Move fingerprint over surface without losing contact.")
                                .font(.body)
                        }
                        .padding(.leading, 15)
                        Spacer()
                    }
                    HStack(alignment: .top) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.lightGray)
                                .frame(width: 100, height: 100)
                            Image(.pinchGesture)
                        }
                        VStack(alignment: .leading) {
                            Text("Pinch Gesture")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                            Text("Touch surface with two fingers and bring them closer together.")
                                .font(.body)
                        }
                        .padding(.leading, 15)
                        Spacer()
                    }
                    HStack(alignment: .top) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.lightGray)
                                .frame(width: 100, height: 100)
                            Image(.rotationGesture)
                        }
                        VStack(alignment: .leading) {
                            Text("Rotation Gesture")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                            Text("Touch surface with two fingers and move them in a clockwise or counterclockwise direction.")
                                .font(.body)
                        }
                        .padding(.leading, 15)
                        Spacer()
                    }
                }
                
            }
            Spacer()
        }
        .padding(.horizontal)
        
    }
}
