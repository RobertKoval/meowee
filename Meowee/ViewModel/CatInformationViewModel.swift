//
//  CatInformationViewModel.swift
//  Feed The Cat
//
//  Created by Robert Koval on 12.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import UIKit
import Combine

class CatInformationViewModel: ObservableObject {
	let breed: Breed
	private var imageLoader: BreedImageLoader
	private var cancelable: AnyCancellable?

	@Published var images: [UIImage] = []
	@Published var isLoading: Bool = true
	
	init(breed: Breed, imageLoader: BreedImageLoader) {
		self.breed = breed
		self.imageLoader = imageLoader
	}
	
	func fetchImages() {
		cancelable = imageLoader.loadImages(breedId: breed.id)
		.receive(on: DispatchQueue.main)
		.replaceError(with: [])
		.handleEvents(
			receiveOutput: { _ in self.isLoading = false },
			receiveCancel: { self.isLoading = true },
			receiveRequest: { _ in self.isLoading = true })
		.assign(to: \.images, on: self)
	}
	
	func cancelDownload() {
		cancelable?.cancel()
	}
}
