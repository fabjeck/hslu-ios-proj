//
//  ARViewRepresentable.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 07.12.20.
//

import SwiftUI

struct ARViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ARViewController {
        return ARViewController()
    }
    func updateUIViewController(_ uiViewController: ARViewController, context: UIViewControllerRepresentableContext<ARViewControllerRepresentable>) {}
}
