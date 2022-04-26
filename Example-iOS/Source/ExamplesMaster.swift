//
//  ExamplesMaster.swift
//  RiveExample
//
//  Created by Zachary Duncan on 4/19/22.
//  Copyright © 2022 Rive. All rights reserved.
//

import SwiftUI
import RiveRuntime

class ExamplesMasterTableViewController: UITableViewController {
    
    
    // MARK: Storyboard Examples
    /// Sourced from the `Main` storyboard
    private let storyboardIDs: [String] = [
        "Simple Animation",
        "Layout",
        "MultipleAnimations",
        "State Machine",
        "Blend Mode",
        "Slider Widget"
    ]
    
    
    // MARK: SwiftUI View Examples
    /// Made from custom `Views`
    private lazy var swiftViews: [(String, AnyView)] = [
        ("Touch Events!",       typeErased(dismissableView: SwiftTouchEvents())),
        //("Lighthouse",          typeErased(dismissableView: SwiftSwitchEvent())),
        ("Widget Collection",   typeErased(dismissableView: SwiftWidgets())),
        ("Simple Animation",    typeErased(dismissableView: SwiftSimpleAnimation())),
        ("Layout",              typeErased(dismissableView: SwiftLayout())),
        ("MultipleAnimations",  typeErased(dismissableView: SwiftMultipleAnimations())),
        ("Loop Mode",           typeErased(dismissableView: SwiftLoopMode())),
        ("State Machine",       typeErased(dismissableView: SwiftStateMachine())),
        ("Mesh Animation",      typeErased(dismissableView: SwiftMeshAnimation()))
    ]
    
    
    // MARK: ViewModel Examples
    /// Made from `RiveViewModels`' default `.view()` method
    private let viewModels: [(String, RiveViewModel)] = [
        ("Slider Widget",       RiveSlider())
    ]
}

extension ExamplesMasterTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        // ViewControllers made from Storyboard IDs
        if indexPath.section == 0 {
            cell.textLabel?.text = storyboardIDs[indexPath.row]
        }
        
        // Views made by custom SwiftUI Views
        else if indexPath.section == 1 {
            cell.textLabel?.text = swiftViews[indexPath.row].0
        }
        
        // Views made by the ViewModels
        else if indexPath.section == 2 {
            cell.textLabel?.text = viewModels[indexPath.row].0
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var controller: UIViewController
        
        // ViewControllers made from Storyboard IDs
        if indexPath.section == 0 {
            controller = storyboard!.instantiateViewController(withIdentifier: storyboardIDs[indexPath.row])
        }
        
        // Views made by custom SwiftUI Views
        else if indexPath.section == 1 {
            controller = UIHostingController(rootView: swiftViews[indexPath.row].1)
        }
        
        // Views made by the ViewModels
        else if indexPath.section == 2 {
            let anyView = AnyView(viewModels[indexPath.row].1.view())
            controller = UIHostingController(rootView: anyView)
        }
        
        // Too many sections
        else { fatalError() }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Storyboard Examples"
        case 1: return "SwiftUI Examples"
        case 2: return "ViewModel Examples"
        default: fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return storyboardIDs.count
        case 1: return swiftViews.count
        case 2: return viewModels.count
        default: fatalError()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    private func typeErased<Content: DismissableView>(dismissableView: Content) -> AnyView {
        var view = dismissableView
        view.dismiss = {
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        
        return AnyView(view)
    }
}

public protocol DismissableView: View {
    init()
    var dismiss: () -> Void { get set }
}
