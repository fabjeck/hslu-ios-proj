//
//  MessageView.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 08.12.20.
//

import SwiftUI

struct MessageView: View {
    var vm: MessageViewModel
    
    @State var message: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                Group {
                    Text("Nachricht")
                        .bold()
                    TextField("Nachricht eingeben...", text: $message)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .padding(.vertical, 10)
                        .padding(.horizontal, 5)
                        .border(Color.black)
                }
                Spacer()
                Button("Speichern") {
                    
                }.buttonStyle(CustomButtonStyle(.primary))
            }.padding()
                .navigationBarTitle("Message erfassen", displayMode: .large)
                .navigationBarItems(leading: Button("Cancel") {
                    vm.toggleModal()
                })
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(vm: MessageView.MessageViewModel(showMessageView: .constant(true)))
    }
}
