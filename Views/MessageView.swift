//
//  MessageView.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 08.12.20.
//

import SwiftUI

struct MessageView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var message: String = ""
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                ZStack(alignment: .topLeading) {
                    if message.isEmpty {
                        TextEditor(text: .constant("Erfasse deine Message..."))
                            .foregroundColor(Color(UIColor.placeholderText))
                    }
                    TextEditor(text: $message)
                }
                Spacer()
                Button(action: {
                    MessageService.saveMessage(message, managedObjectContext: viewContext)
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Speichern")
                }).buttonStyle(CustomButtonStyle(.primary))
            }.padding()
                .navigationBarTitle("Message", displayMode: .large)
                .navigationBarItems(leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                })
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
