//
//  ModelPickerView.swift
//  MatchingGameAR
//
//  Created by Daniel O'Leary on 5/3/21.
//

import SwiftUI

struct ModelPickerView: View {
	// TODO: need a binding here to get the name of the model selected.
	var models: [String]

	@Binding var selectedModel: String?

	var body: some View {
		ScrollView(.horizontal, showsIndicators: true) {
			HStack(spacing: 30) {
				ForEach(0 ..< models.count) { index in
					Button {
						selectedModel = models[index]
					} label: {
						Image(uiImage: UIImage(named: models[index])!)
							.resizable()
							.frame(height: 80)
							.aspectRatio(1/1, contentMode: .fit)
							.cornerRadius(12)
							.shadow(radius: 3)
							.padding()
					}
				}
			}
			.background(Color.green.opacity(0.3))
		}.padding(.bottom)
	}
}

struct ModelPickerView_Previews: PreviewProvider {
    static var previews: some View {
		ModelPickerView(models: ["robot"], selectedModel: .constant("robot"))
    }
}
