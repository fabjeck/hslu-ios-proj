//
//  ARView.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 07.12.20.
//

import SwiftUI

struct ARView: View {
    var body: some View {
        ARViewControllerRepresentable().edgesIgnoringSafeArea(.all)
    }
}

struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARView()
    }
}
