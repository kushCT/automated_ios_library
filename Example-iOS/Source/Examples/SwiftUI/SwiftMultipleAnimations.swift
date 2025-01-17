//
//  MultipleAnimations.swift
//  RiveExample
//
//  Created by Maxwell Talbot on 01/03/2022.
//  Copyright © 2022 Rive. All rights reserved.
//

import SwiftUI
import RiveRuntime

/// This shows how to utilize one animation file to show content in different artboards and
/// different animations within those artboards
struct SwiftMultipleAnimations: DismissableView {
    private let fileName = "artboard_animations"
    var dismiss: () -> Void = {}
    
    var body: some View {
        ScrollView{
            VStack {
                Text("Square - go around")
                RiveViewModel(fileName: fileName, artboardName: "Square", animationName: "goaround").view()
                    .frame(height:200)
                
                Text("Square - roll around")
                RiveViewModel(fileName: fileName, artboardName: "Square", animationName: "rollaround").view()
                    .frame(height:200)
                
                Text("Circle")
                RiveViewModel(fileName: fileName, artboardName: "Circle").view()
                    .frame(height:200)
                
                Text("Star")
                RiveViewModel(fileName: fileName, artboardName: "Star").view()
                    .frame(height:200)
            }
        }
    }
}

