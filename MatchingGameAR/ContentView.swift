//
//  ContentView.swift
//  MatchingGameAR
//
//  Created by Daniel O'Leary on 4/27/21.
//
import ARKit
import SwiftUI
import RealityKit

struct ContentView : View {

	// Dynamically get model name from bundle.
	private var appModels: [String] = {
		var availableModels: [String] = []
		let fileManager = FileManager.default
		guard let path = Bundle.main.resourcePath,
			  let files = try? fileManager.contentsOfDirectory(atPath: path)  else { return [] }

		for fileName in files where
			fileName.hasSuffix("usdz") {
			let modelName = fileName.replacingOccurrences(of: ".usdz", with: "")
			availableModels.append(modelName)
		}
		return availableModels
	}()
	@State private var selectionConfirmed = false
	@State private var selectedModel: String? = nil

    var body: some View {
		ZStack(alignment: .bottom) {
			ARViewContainer()
			VStack {
				ConfirmCancelButtons(selectionConfirmed: $selectionConfirmed)
				ModelPickerView(models: appModels, selectedModel: $selectedModel)
			}
		}
		.edgesIgnoringSafeArea(.all)
    }

	private func loadModel(_ arView: ARView, with name: String) {
		arView.scene.addAnchor(<#T##anchor: HasAnchoring##HasAnchoring#>)
	}

}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
		let arView = ARView(frame: .zero)

		let configuration = ARWorldTrackingConfiguration()
		configuration.planeDetection = .horizontal
		configuration.environmentTexturing = .automatic

		// For devices that support LIDAR
		if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
			configuration.sceneReconstruction = .mesh
		}



		#warning("Look up how to configure the session for a RealityKit built ARApp.")
		// you'll need arView.session.run(configuration)
        
        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}


    
}


struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
