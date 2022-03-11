//
//  RiveSlider.swift
//  RiveExample
//
//  Created by Zachary Duncan on 3/10/22.
//  Copyright © 2022 Rive. All rights reserved.
//

import SwiftUI
import RiveRuntime


struct RiveSlider: View {
    // TODO: Have this View in a Controller instead
    var controller: RiveController
    static let resource: String = "riveslider7"
    static let stateMachine: String = "Slide"
    
    var maxValue: Double
    var minValue: Double
    var currentValue: Double
    
    init(min: Double, max: Double, starting: Double, controller: RiveController = RiveController()) {
        self.controller = controller
        
        minValue = min
        maxValue = max
        currentValue = starting
    }
    
    init(min: Double, max: Double, controller: RiveController = RiveController()) {
        self.init(min: min, max: max, starting: max, controller: controller)
    }
    
    var body: some View {
//        VStack {
            RiveViewSwift(
                resource: RiveSlider.resource,
//                autoplay: true,
                stateMachine: RiveSlider.stateMachine)//,
//                controller: controller)
//                .frame(width: 300, height: 75)
//        }
    }
}

struct RiveSlider_Previews: PreviewProvider {
    static var previews: some View {
        RiveSlider(min: 0, max: 100)
    }
}


@IBDesignable class Card: UIButton {
    /// Use this to place elements inside of the Card
    var view: UIView = UIView()
    
    /// Use this to set the background color of the Card.
    /// Gradient and shadow will be set automatically
    var color: UIColor = .blue {
        didSet {
            backgroundColor = color
            setGradient()
            
            if hasShadow {
                var shColor: UIColor

                switch colorScheme {
                case .lightToDark:
                    shColor = color - 0.3
                case .darkToLight:
                    shColor = color - 0.2
                case .complementaryNatural:
                    shColor = color.complementary() - 0.2
                case .complementaryLight:
                    shColor = color.complementary()
                case .complementaryDark:
                    shColor = color.complementary() - 0.4
                }

                addShadow(radius: 0, dY: 2.5, dX: 0, color: shColor)
            }
        }
    }
    
    func set(height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// This is the background color's gradient. It will be set and used automatically
    private let gradientLayer = CAGradientLayer()
    var colorScheme: ColorScheme = .lightToDark
    var hasShadow: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradient()
    }
    
    private func sharedInit() {
        setTitle("", for: .normal)
        roundCorners(.card)
        color = #colorLiteral(red: 0, green: 0.6280093268, blue: 1, alpha: 1)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.roundCorners(.card)
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        layoutIfNeeded()
        
        isExclusiveTouch = true
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
        addTarget(self, action: #selector(touchDragEnter), for: .touchDragEnter)
        addTarget(self, action: #selector(touchCancel), for: .touchCancel)
    }
    
    private func setGradient() {
        gradientLayer.frame = bounds
        
        switch colorScheme {
        case .lightToDark:
            gradientLayer.colors = lightToDark()
        case .darkToLight:
            gradientLayer.colors = darkToLight()
        case .complementaryNatural:
            gradientLayer.colors = complementaryNatural()
        case .complementaryLight:
            gradientLayer.colors = complementaryLight()
        case .complementaryDark:
            gradientLayer.colors = complementaryDark()
        }
        
        gradientLayer.borderColor = layer.borderColor
        gradientLayer.borderWidth = layer.borderWidth
        gradientLayer.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// The action should be provided by the implementer of the Card
    ///
    /// super.touchUpInside() should always be called when overriding
    @objc func touchUpInside() {
        color += 0.1
    }
    
    @objc private func touchDown() {
        color -= 0.1
    }
    
    @objc private func touchDragExit() {
        color += 0.1
    }
    
    @objc private func touchDragEnter() {
        color -= 0.1
    }
    
    @objc private func touchCancel() {
        color += 0.1
    }
}

// MARK: -  Color gradients
extension Card {
    enum ColorScheme {
        case lightToDark
        case darkToLight
        case complementaryNatural
        case complementaryLight
        case complementaryDark
    }
    
    func lightToDark() -> [CGColor] {
        // Burn
        //return [color.cgColor, (color - 0.01).cgColor, (color - 0.05).cgColor, (color - 0.1).cgColor]
        
        // Saturation
        return [color.cgColor, color.saturated(by: 0.01).cgColor, color.saturated(by: 0.1).cgColor, color.saturated(by: 0.2).cgColor]
    }
    
    func darkToLight() -> [CGColor] {
        // Burn
        //return [(color - 0.2).cgColor, color.cgColor]
        
        // Saturation
        //return lightToDark().reversed()
        return [(color.saturated(by: 0.2)).cgColor, color.cgColor]
    }
    
    func complementaryNatural() -> [CGColor] {
        return [color.cgColor, color.complementary().cgColor]
    }
    
    func complementaryLight() -> [CGColor] {
        return [color.cgColor, (color.complementary() + 0.2).cgColor]
    }
    
    func complementaryDark() -> [CGColor] {
        return [color.cgColor, (color.complementary() - 0.2).cgColor]
    }
}

extension UIView {
    /// This will round the corners of your UIView or any subclass of UIView
    ///
    /// - Parameter radius: This will round the corners to their fullest if given nil
    @objc func roundCorners(radius: NSNumber?) {
        if self is UIImageView {
            clipsToBounds = true
        }
        
        if let radius = radius as? CGFloat {
            layer.cornerRadius = radius
        } else {
            layer.cornerRadius = frame.width > frame.height ? frame.height / 2 : frame.width / 2
        }
    }
    
    func roundCorners(_ level: Roundness) {
        if self is UIImageView {
            self.clipsToBounds = true
        }
        
        switch level {
        case .slight:
            layer.cornerRadius = 5.0
        case .card:
            layer.cornerRadius = 10.0
        case .oval:
            layer.cornerRadius = frame.width > frame.height ? frame.height / 2 : frame.width / 2
        }
    }
    enum Roundness {
        case slight
        case card
        case oval
    }
    
    /// Does all the work of creating the shadow and grooming the UIView for being able to support shadows.
    ///
    /// - Parameters:
    ///   - radius: Larger numbers yield fuzzier edges
    ///   - dY: How far below the view the shadow is offset
    ///   - dX: How far to the right the view the shadow is offset
    ///   - color: UIColor of the shadow
    func addShadow(radius: CGFloat, dY: CGFloat, dX: CGFloat, color: UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)) {
        layer.shadowOpacity = 1
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: dX, height: dY)
        layer.shadowColor = color.cgColor
    }
    
    func addBorders(width: CGFloat, color: CGColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color
    }
    
    func animateShow() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
        })
    }
    
    func animateHide() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        })
    }
    
    func pulseBackground() {
        backgroundColor! -= 0.1
        UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseInOut, .repeat, .allowUserInteraction], animations: {
            self.backgroundColor! += 0.1
        }, completion: nil)
    }
}

extension UIColor {
    ///Returns a lighter color
    static func +(color: UIColor, modification: Double) -> UIColor {
        let ciColor = CIColor(color: color)
        return UIColor(red: ciColor.red + CGFloat(modification),
                       green: ciColor.green + CGFloat(modification),
                       blue: ciColor.blue + CGFloat(modification),
                       alpha: ciColor.alpha)
    }
    
    ///Returns a darker color
    static func -(color: UIColor, modification: Double) -> UIColor {
        return color + -modification
    }
    
    ///The color on the left side of the equals sign will be made lighter
    static func +=(color: inout UIColor, modification: Double) {
        color = color + modification
    }
    
    ///The color on the left side of the equals sign will be made darker
    static func -=(color: inout UIColor, modification: Double) {
        color = color - modification
    }
    
    ///Returns true if the left side of the comparison is lighter
    static func >(left: UIColor, right: UIColor) -> Bool {
        guard let lComponents = left.cgColor.components else { return false }
        guard let rComponents = right.cgColor.components else { return false }
        
        var lTotal: CGFloat = 0
        var rTotal: CGFloat = 0
        
        for i in 0 ..< lComponents.count {
            if i != lComponents.count - 1 {
                lTotal += lComponents[i]
            }
        }
        
        for i in 0 ..< rComponents.count {
            if i != rComponents.count - 1 {
                rTotal += rComponents[i]
            }
        }
        
        return lTotal > rTotal
    }
    
    ///Returns true if the left side of the comparison is darker
    static func <(left: UIColor, right: UIColor) -> Bool {
        return !(left > right)
    }
    
    
    ///Returns true if the both sides of the comparison are the same color
    static func ==(left: UIColor, right: UIColor) -> Bool {
        guard let lComponents = left.cgColor.components else { return false }
        guard let rComponents = right.cgColor.components else { return false }
        
        var lTotal: CGFloat = 0
        var rTotal: CGFloat = 0
        
        for i in 0 ..< lComponents.count {
            if i != lComponents.count - 1 {
                lTotal += lComponents[i]
            }
        }
        
        for i in 0 ..< rComponents.count {
            if i != rComponents.count - 1 {
                rTotal += rComponents[i]
            }
        }
        
        return lTotal == rTotal
    }
    
    func image() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), true, 0.0)
        self.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }
    
    func complementary() -> UIColor {
        let ciColor = CIColor(color: self)
        
        // Get the current values and make the difference from white
        let compRed: CGFloat = 1.0 - ciColor.red
        let compGreen: CGFloat = 1.0 - ciColor.green
        let compBlue: CGFloat = 1.0 - ciColor.blue
        
        return UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: ciColor.alpha)
    }
    
    func saturated(by modifier: CGFloat) -> UIColor {
        let ciColor = CIColor(color: self)
        var newRed: CGFloat = ciColor.red
        var newBlue: CGFloat = ciColor.blue
        var newGreen: CGFloat = ciColor.green
        
        if newRed > newBlue && newRed > newGreen {
            newBlue -= modifier
            newGreen -= modifier
        } else if newBlue > newGreen && newBlue > newRed {
            newRed -= modifier
            newGreen -= modifier
        } else {
            newRed -= modifier
            newBlue -= modifier
        }
        
        newRed = newRed < 0 ? 0 : newRed
        newBlue = newBlue < 0 ? 0 : newBlue
        newGreen = newGreen < 0 ? 0 : newGreen
        
        return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: ciColor.alpha)
        
//        if ciColor.red > ciColor.blue && ciColor.red > ciColor.green {
//            return UIColor(red: ciColor.red, green: ciColor.green - modifier, blue: ciColor.blue - modifier, alpha: ciColor.alpha)
//        } else if ciColor.blue > ciColor.green && ciColor.blue > ciColor.red {
//            return UIColor(red: ciColor.red - modifier, green: ciColor.green - modifier, blue: ciColor.blue, alpha: ciColor.alpha)
//        } else {
//            return UIColor(red: ciColor.red - modifier, green: ciColor.green + modifier, blue: ciColor.blue - modifier, alpha: ciColor.alpha)
//        }
    }
}
