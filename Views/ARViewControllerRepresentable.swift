//
//  ARViewRepresentable.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 07.12.20.
//

import SwiftUI

struct ARViewControllerRepresentable: UIViewControllerRepresentable {
    @EnvironmentObject var locationManager: LocationManager
    
    func makeUIViewController(context: Context) -> ARViewController {
        return ARViewController()
    }
    func updateUIViewController(_ uiViewController: ARViewController, context: UIViewControllerRepresentableContext<ARViewControllerRepresentable>) {
        uiViewController.arView.scene.rootNode.enumerateChildNodes({(node, stop) in node.removeFromParentNode()})
        if !locationManager.availableMessage.isEmpty {
            uiViewController.arView.scene.rootNode.addChildNode(uiViewController.createMessageNode(locationManager.availableMessage))
        }
    }
}
