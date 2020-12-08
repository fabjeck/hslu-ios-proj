//
//  CustomButtonStyle.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 08.12.20.
//

import SwiftUI

enum DisplayStyle {
    case primary
    case secondary
    
    var foregroundColor: Color {
        switch self {
        case .primary:
            return Color.white
        case .secondary:
            return Color.blue
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .primary:
            return Color.blue
        case .secondary:
            return Color.white
        }
    }
    
    var borderColor: Color {
        return Color.blue
    }

}

struct CustomButtonStyle: ButtonStyle {
    private var display: DisplayStyle
    
    init(_ display: DisplayStyle) {
        self.display = display
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(display.foregroundColor)
            .background(display.backgroundColor)
            .border(display.borderColor)
    }
}
