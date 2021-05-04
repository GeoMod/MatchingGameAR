//
//  ConfirmCancelButtons.swift
//  MatchingGameAR
//
//  Created by Daniel O'Leary on 5/3/21.
//

import SwiftUI

struct AROverlayButton: View {
	let systemImageName: String
	let color: Color
	let fontSize: Font
	let action: () -> Void

	var body: some View {
		Button(action: action, label: {
			Image(systemName: systemImageName)
				.font(fontSize)
				.foregroundColor(color)
		})
	}
}

struct ConfirmCancelButtons: View {
	@Binding var selectionConfirmed: Bool

    var body: some View {
		HStack(spacing: 75) {
			Spacer()
			AROverlayButton(systemImageName: "xmark.octagon.fill", color: .red, fontSize: .largeTitle) {
				selectionConfirmed = false
			}

			AROverlayButton(systemImageName: "checkmark.circle.fill", color: .green, fontSize: .largeTitle) {
				selectionConfirmed = true
			}
			Spacer()
		}
	}
}

struct ConfirmCancelButtons_Previews: PreviewProvider {
    static var previews: some View {
		ConfirmCancelButtons(selectionConfirmed: .constant(false))
    }
}
