//
//  ARViewRepresentable.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 07.12.20.
//

import SwiftUI

struct ARViewControllerRepresentable: UIViewControllerRepresentable {
    @EnvironmentObject var locationManager: LocationManager
    
    @FetchRequest(
        entity: Message.entity(),
        sortDescriptors: []
    ) var messages: FetchedResults<Message>
    
    func makeUIViewController(context: Context) -> ARViewController {
        return ARViewController()
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: UIViewControllerRepresentableContext<ARViewControllerRepresentable>) {
        let availableMessage = locationManager.getClosestMessageInRange(messages: Array(messages))
        uiViewController.arView.scene.rootNode.enumerateChildNodes {(node, _) in node.removeFromParentNode()}
        if (!availableMessage.isEmpty) {
            uiViewController.arView.scene.rootNode.addChildNode(uiViewController.createMessageNode(availableMessage))
        }
    }
}
