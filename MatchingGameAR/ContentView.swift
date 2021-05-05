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
			ARViewContainer(modelAddedToScene: $selectedModel)
			VStack {
//				ConfirmCancelButtons(selectionConfirmed: $selectionConfirmed)
				ModelPickerView(models: appModels, selectedModel: $selectedModel)
			}
		}
		.edgesIgnoringSafeArea(.all)
    }


}

struct ARViewContainer: UIViewRepresentable {
	@Binding var modelAddedToScene: String?

	let arView = ARView(frame: .zero)

    func makeUIView(context: Context) -> ARView {

		let configuration = ARWorldTrackingConfiguration()
		configuration.planeDetection = .horizontal
		configuration.environmentTexturing = .automatic

		// For devices that support LIDAR
		if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
			configuration.sceneReconstruction = .mesh
		}

        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
		#warning("This is only running once and I need it, or something, to get called with each tap gesture.")
		let recognizer = UITapGestureRecognizer()
		let point = recognizer.location(in: uiView)

		guard let rayCastQuery = uiView.makeRaycastQuery(from: point, allowing: .existingPlaneInfinite, alignment: .horizontal) else { return }
		let result = uiView.raycast(from: point, allowing: .existingPlaneInfinite, alignment: rayCastQuery.targetAlignment)

		if let modelName = modelAddedToScene {
			let fileName = modelName + ".usdz"
			let modelEntity = try! ModelEntity.loadModel(named: fileName)
			let anchor = AnchorEntity(raycastResult: result.first!)
			anchor.addChild(modelEntity)
			uiView.scene.anchors.append(anchor)
		}
	}


    
}


struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
