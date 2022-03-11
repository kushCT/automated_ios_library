//
//  RiveProgressBar.swift
//  RiveExample
//
//  Created by Matt Sullivan on 5/14/21.
//  Copyright © 2021 Rive. All rights reserved.
//

import SwiftUI
import RiveRuntime

//fileprivate var resource: String = "life_bar"
//fileprivate var stateMachine: String = "Life Machine"
//
//struct RiveProgressBar: View {
//    var controller: RiveController
//
//    @Binding var health: Double
//
//    var body: some View {
//        VStack {
//            RiveViewSwift(resource: resource, autoplay: true, stateMachine: stateMachine, controller: controller)
//                .frame(width: 300, height: 75)
//        }
//    }
//}
//
//
//struct RiveProgressBar_Previews: PreviewProvider {
//    static var previews: some View {
//        RiveProgressBar(controller: RiveController(), health: Binding.constant(50.0))
//    }
//}


struct RiveProgressBar: View {
    var resource: String = "riveslider7"
    var controller: RiveController

    @Binding var health: Double

    var body: some View {
        VStack {
            RiveViewSwift(resource: resource, autoplay: true, stateMachine: "Slide", controller: controller)
                .frame(width: 300, height: 75)
        }
    }
}


struct RiveProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        RiveProgressBar(resource: "riveslider7", controller: RiveController(), health: Binding.constant(50.0))
    }
}
