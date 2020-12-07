//
//  ARViewController.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 07.12.20.
//

import SwiftUI

struct ARViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ARSCNViewController {
        return ARSCNViewController()
    }
    func updateUIViewController(_ uiViewController: ARSCNViewController, context: UIViewControllerRepresentableContext<ARViewController>) {}
}
