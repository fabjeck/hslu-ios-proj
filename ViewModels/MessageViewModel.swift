//
//  MessageViewModel.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 08.12.20.
//

import SwiftUI

extension MessageView {
    class MessageViewModel {
        var showMessageView: Binding<Bool>
        
        init(showMessageView: Binding<Bool>) {
            self.showMessageView = showMessageView
        }
        
        func toggleModal(){
            self.showMessageView.wrappedValue.toggle()
        }
    }
}

