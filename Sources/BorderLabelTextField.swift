//
//  BorderLabelTextField.swift
//
//  Created by Marcel Kulina on 09.11.19.
//  Copyright © 2019 Broken Bytes. See LICENSE
//

import UIKit

@IBDesignable
/// Draws a bordered TextField with a label above the input that breaks the border
class BorderedLabelTextField: UITextField {
    // MARK: Constants
    enum Texts: String {
        case placeholder = "Placeholder"
    }
    enum Floats: CGFloat {
        case margin = 12
        case borderMargin = 6
        case textPadding = 10
    }
    
    // MARK: Border Inpectables
    /// The width of the border
    @IBInspectable var borderWidth: CGFloat = 2
    /// The radius to use, sets layer.cornerRadius
    @IBInspectable var borderRadius: CGFloat = 0
    /// The color of the border
    @IBInspectable var borderColor: UIColor = .black
    /// The size of the label
    @IBInspectable var labelFontSize: CGFloat = 12 {
        didSet {
            label.font = self.font?.withSize(labelFontSize)
        }
    }
    
    // MARK: Label Inspectables
    /// The color of the label
    @IBInspectable var labelColor: UIColor = .black {
        didSet {
            self.label.textColor = self.labelColor
        }
    }
    
    /// The text this label displays
    @IBInspectable var labelText: String = "Placeholder" {
        didSet {
            self.label.text = self.labelText
        }
    }
    
    // MARK: SecureText Properties
    /// Indicates whether the icon for showing clear text in a secure textfield should be enabled or not
    @IBInspectable var showClearTextIcon: Bool = false {
        didSet {
            if self.showClearTextIcon {
                self.textContentType = .password
                self.isSecureTextEntry = true
                self.rightViewMode = .always
                let clearTextBtn = UIButton()
                self.rightView = clearTextBtn
                self.rightView?.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
                clearTextBtn.setBackgroundImage(self.clearTextIcon, for: .normal)
                clearTextBtn.addTarget(self, action: #selector(toggleClearText), for: .touchDown)
            } else {
                self.rightView = nil
            }
        }
    }
    
    /// The icon that will be displayed for toggling clear text mode
    @IBInspectable var clearTextIcon: UIImage? = nil {
        didSet {
            if self.clearTextIcon == nil {
                self.showClearTextIcon = false
                return
            }
            if let toggleBtn = self.rightView as? UIButton {
                toggleBtn.setBackgroundImage(self.clearTextIcon, for: .normal)
            }
        }
    }
    
    /// The font used
    override var font: UIFont? {
        didSet {
            label.font = self.font?.withSize(labelFontSize)
        }
    }
    
    /// The color of the text. Does also override the clear text icon color
    override var textColor: UIColor? {
        didSet {
            self.tintColor = self.textColor
        }
    }
    
    // MARK: Runtime UI Components
    private var rect: CGRect!
    private var intersectionRect: CGRect!
    private var label: UILabel = UILabel()
    private var drawingContext: CGContext?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        createLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isOpaque = false
        self.backgroundColor = .clear
        createLabel()
    }
    
    // MARK: Overrides
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.rect = rect
        drawingContext = UIGraphicsGetCurrentContext()
        drawingContext?.clear(rect)
        UIColor.clear.setFill()
        UIRectFill(rect)
        drawBorder()
        drawLabel()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let clearTextIconMargin = rightViewRect(forBounds: bounds).width + Floats.margin.rawValue
        return bounds
            .offsetBy(dx: Floats.textPadding.rawValue, dy: labelFontSize)
            .inset(by: UIEdgeInsets(top: 0,
                                    left: 0,
                                    bottom: labelFontSize + borderWidth,
                                    right: Floats.textPadding.rawValue +
                                        ((showClearTextIcon) ? clearTextIconMargin : 0)))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        if showClearTextIcon {
            return super.rightViewRect(forBounds: bounds)
                .offsetBy(dx: -Floats.borderMargin.rawValue,
                          dy: labelFontSize / 2 - borderWidth / 2)
        }
        return CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    
    
    // MARK: OBJC Methods
    @objc func toggleClearText() {
        isSecureTextEntry = !isSecureTextEntry
        self.becomeFirstResponder()
    }
    
    /// Draws the border around the TextField
    private func drawBorder() {
        // Get the rect the label covers
        intersectionRect = CGRect(x: borderWidth / 2,
                                  y: (borderWidth / 2) + (labelFontSize / 2),
                                  width: rect.width - (self.borderWidth),
                                  height: rect.height - (self.borderWidth) - (labelFontSize / 2))
        borderColor.setStroke()
        // Get the inner rect as BezierPath so the rounded edges are smooth inside the TextField as well
        let innerClipPath = UIBezierPath(roundedRect: intersectionRect,
                                         cornerRadius: borderRadius).cgPath
        // Draw the border
        drawingContext?.setLineWidth(borderWidth)
        drawingContext?.addPath(innerClipPath)
        drawingContext?.closePath()
        drawingContext?.strokePath()
    }
    
    
    /// Draws the label and removes the label rect from the border
    private func drawLabel() {
        label.frame.origin = CGPoint(x: rect.origin.x + Floats.margin.rawValue,
                                     y: rect.origin.y)
        // Resize this label to its minimal possible size
        label.sizeToFit()
        // Add the margins to the label frame
        label.frame = CGRect(x: label.frame.origin.x,
                             y: label.frame.origin.y,
                             width: label.frame.width + Floats.borderMargin.rawValue,
                             height: labelFontSize)
        // Remove the label from the rect
        UIColor.clear.setFill()
        let labelIntersection = self.rect.intersection(label.frame)
        UIRectFill(labelIntersection)
        // Draw the label in the current context
        self.label.drawText(in: labelIntersection)
    }
    
    
    /// Creates the label and sets initial values
    private func createLabel() {
        label.font = self.font?.withSize(labelFontSize)
        label.textAlignment = .center
        label.text = labelText
        label.textColor = labelColor
    }
}

extension BorderedLabelTextField: UITextFieldDelegate {
    override func resignFirstResponder() -> Bool {
        if showClearTextIcon {
            self.isSecureTextEntry = true
        }
        return true
    }
}
