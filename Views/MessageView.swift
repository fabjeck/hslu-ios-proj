//
//  MessageView.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 08.12.20.
//

import SwiftUI

struct MessageView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @EnvironmentObject var locationManager: LocationManager
    
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
                        TextEditor(text: .constant(NSLocalizedString("write_your_message", comment: "")))
                            .foregroundColor(Color(UIColor.placeholderText))
                    }
                    TextEditor(text: $message)
                }
                Spacer()
                Button(action: {
                    MessageService.saveMessage(message, location: locationManager.location, managedObjectContext: viewContext)
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text(NSLocalizedString("save_msg", comment: ""))
                }).buttonStyle(CustomButtonStyle(.primary))
                .disabled(message.isEmpty)
            }.padding()
            .navigationBarTitle(NSLocalizedString("message", comment: ""), displayMode: .large)
            .navigationBarItems(leading: Button(NSLocalizedString("cancel", comment: "")) {presentationMode.wrappedValue.dismiss()})
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
