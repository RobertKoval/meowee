//
//  CatCollectionView.swift
//  Feed The Cat
//
//  Created by Robert Koval on 10.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import SwiftUI
import Combine

struct CatCollectionView: View {
	@EnvironmentObject var viewModel: CatCollectionViewModel
	@State var isLabelHidden: Bool = false
	private let imageLoader = BreedImageLoader()
	
	var body: some View {
		CollectionView(viewModel: self.viewModel) { breed in
			NavigationLink(destination: CatInformationView()
				.environmentObject(CatInformationViewModel(breed: breed, imageLoader: self.imageLoader))) {
				CatCollectionCellView(isLabelHidden: self.$isLabelHidden)
					.environmentObject(CatCollectionCellViewModel(breedId: breed.id, breedName: breed.name, imageLoader: self.imageLoader))
					.aspectRatio(1, contentMode: .fit)
			}.buttonStyle(PlainButtonStyle())
		}.padding([.leading, .trailing])
			.navigationBarTitle("Meowees")
	}
}

struct CatCollectionView_Previews: PreviewProvider {
	static var previews: some View {
		CatCollectionView()
	}
}
