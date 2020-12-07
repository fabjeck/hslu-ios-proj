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
    
    // MARK: - UIViewController
    
    override func loadView() {
     self.view = ARSCNView(frame: .zero)
   }

    override func viewDidLoad() {
        super.viewDidLoad()
        arView.delegate = self
        arView.scene = SCNScene()
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
