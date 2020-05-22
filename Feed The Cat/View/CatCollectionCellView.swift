//
//  CatCollectionCellView.swift
//  Feed The Cat
//
//  Created by Robert Koval on 11.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import SwiftUI

struct CatCollectionCellView: View {
	@EnvironmentObject var viewModel: CatCollectionCellViewModel
	@State var name: String = ""
	@Binding var isLabelHidden: Bool
	
	var body: some View {
		VStack {
			Image(uiImage: viewModel.image).resizable().scaledToFill()
				.frame(minWidth: 60, minHeight: 60).clipped().overlay(
				ActivityIndicator(isAnimating: $viewModel.isLoading, style: .large)
			)
			Spacer()
			if (!isLabelHidden) {
				Text("\(viewModel.breedName)")
			}
		}.frame(minWidth:44)
	}
}

struct CatCollectionCellView_Previews: PreviewProvider {
	static var previews: some View {
		CatCollectionCellView(isLabelHidden: .constant(false))
	}
}
