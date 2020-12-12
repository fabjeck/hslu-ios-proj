//
//  ARViewController.swift
//  ARLocationMessages
//
//  Created by Fabien Jeckelmann on 07.12.20.
//

import Foundation
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    var arView: ARSCNView {
        return self.view as! ARSCNView
    }
    
    func createMessageNode(_ message: String) -> SCNNode {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20),
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedString = NSAttributedString(string: message, attributes: attrs)
        
        let textWidth: CGFloat = 300
        let constraints = CGSize(width: textWidth, height: .greatestFiniteMagnitude)
        let rect = attributedString.boundingRect(with: constraints, options: .usesLineFragmentOrigin, context: nil)
        
        let padding: CGFloat = 30
        let imageWidth: CGFloat = (2 * padding) + textWidth
        let imageHeight: CGFloat = (2 * padding) + rect.height
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageWidth, height: imageHeight))
        let image = renderer.image { context in
            UIColor.white.setFill()
            context.fill(CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
            
            attributedString.draw(with: CGRect(x: padding, y: padding, width: textWidth, height: rect.height), options: .usesLineFragmentOrigin, context: nil)
        }
        
        let aspectRatio: CGFloat = imageWidth / imageHeight
        let boxWidth: CGFloat = 0.15
        let boxHeight: CGFloat = boxWidth / aspectRatio
        let box = SCNBox(width: boxWidth, height: boxHeight, length: 0.01, chamferRadius: 0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white
        
        let text = SCNMaterial()
        text.diffuse.contents = image
        
        box.materials = [text, material, material, material, material, material]
        
        let messageNode = SCNNode()
        messageNode.geometry = box
        messageNode.position = SCNVector3(0, 0, -0.3)
        return messageNode
    }
    
    // MARK: - UIViewController
    
    override func loadView() {
     self.view = ARSCNView(frame: .zero)
   }

    override func viewDidLoad() {
        super.viewDidLoad()
        arView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      let configuration = ARWorldTrackingConfiguration()
      arView.session.run(configuration)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      arView.session.pause()
   }
    
    // MARK: - ARSCNViewDelegate
    func sessionWasInterrupted(_ session: ARSession) {}

    func sessionInterruptionEnded(_ session: ARSession) {}
    func session(_ session: ARSession, didFailWithError error: Error)
    {}
    func session(_ session: ARSession, cameraDidChangeTrackingState
    camera: ARCamera) {}

}
