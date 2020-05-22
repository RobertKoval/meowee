//
//  CatCollectionCellViewModel.swift
//  Feed The Cat
//
//  Created by Robert Koval on 12.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import Combine
import UIKit

class CatCollectionCellViewModel: ObservableObject {
	private var imageLoader: BreedImageLoader
	
	@Published var breedId: String
	@Published var breedName: String
	@Published var image: UIImage = UIImage()
	@Published var isLoading: Bool = true
	private var cancelable: AnyCancellable?
	
	init(breedId: String, breedName: String, imageLoader: BreedImageLoader) {
		self.breedId = breedId
		self.breedName = breedName
		self.imageLoader = imageLoader
		
		self.loadImage()		
	}
	
	func loadImage() {
		cancelable = imageLoader.loadImage(breedId: breedId)
			.receive(on: DispatchQueue.main)
			.replaceError(with: UIImage())
			.handleEvents(
				receiveOutput: { _ in self.isLoading = false },
				receiveCancel: { self.isLoading = true },
				receiveRequest: { _ in self.isLoading = true })
			.assign(to: \.image, on: self)
	}
	
	func cancelDownload() {
		cancelable?.cancel()
	}
}
