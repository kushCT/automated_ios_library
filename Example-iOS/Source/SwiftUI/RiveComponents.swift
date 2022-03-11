//
//  ExampleStateMachineView.swift
//  RiveExample
//
//  Created by Matt Sullivan on 5/12/21.
//  Copyright © 2021 Rive. All rights reserved.
//

import SwiftUI
import RiveRuntime

fileprivate let kSM_Name: String = "Life Machine"

struct RiveComponents: View {
    
    /// lets UIKit bind to this to trigger dismiss events
    var dismiss: () -> Void = {}
    
    @State var sliderController: RiveController = RiveController()
    
    /// Plays or pauses the button's Rive animation
    @State var play: Bool = false
    
    /// Tracks the health value coming from the slide for the progress bar
    @State var health: Double = 100 {
        didSet {
            let nonZeroHealth = health == 0 ? Double.leastNonzeroMagnitude : health
            progressPercent = floor((nonZeroHealth / kMaxHealth) * 100)
        }
    }
    
    @State var progressPercent: Double = 100
    
    private let kMaxHealth: Double = 100
    private let kMinHealth: Double = 0
    private var progressPercentString: String { return "\(Int(progressPercent))" }
    
    var body: some View {
        VStack {
            HStack {
                Text("RiveButton:")
                RiveButton(resource: "pull") {
                    print("Button tapped")
                }
            }
            HStack {
                Text("RiveSwitch:")
                RiveSwitch(resource: "switch") { on in
                    print("switch is \(on ? "on" : "off")")
                }
            }
//            VStack {
//                Text("RiveSlider:")
//                RiveSlider(min: 0, max: 100, controller: sliderController)//(resource: "life_bar", controller: sliderController, health: $progressPercent)
//            }
            VStack {
                Text("RiveProgressBar:")
                RiveProgressBar(resource: "life_bar", controller: sliderController, health: $progressPercent)
            }
            Slider(value: Binding(get: {
                progressPercent
            }, set: { (newVal) in
                health = newVal
                print(progressPercentString)
                try? sliderController.setBooleanState(kSM_Name, inputName: progressPercentString, value: true)

//                try? self.sliderController.setBooleanState(kSM_Name, inputName: "100", value: true)
//                try? self.sliderController.setBooleanState(kSM_Name, inputName: "75", value: newVal < 100)
//                try? self.sliderController.setBooleanState(kSM_Name, inputName: "50", value: newVal <= 66)
//                try? self.sliderController.setBooleanState(kSM_Name, inputName: "25", value: newVal <= 33)
//                try? self.sliderController.setBooleanState(kSM_Name, inputName: "0", value: newVal <= 0)
            }), in: kMinHealth...kMaxHealth)
            .padding()
        }
    }
}

 
struct ExampleStateMachineView_Previews: PreviewProvider {
    static var previews: some View {
        RiveComponents()
    }
}
