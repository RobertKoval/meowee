//
//  BreedImageLoader.swift
//  Feed The Cat
//
//  Created by Robert Koval on 12.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import UIKit
import Combine

class BreedImageLoader: ObservableObject {
	@Published var image: UIImage?
	@Published var isLoading: Bool = false
	private let queue = DispatchQueue(label: "image.download", qos: .utility)
	var cache = ImageCache()
	
	private func images(from request: URLRequest) -> AnyPublisher<[UIImage], Error> {
		URLSession.shared.dataTaskPublisher(for: request)
			.tryMap({ data in
				try JSONDecoder().decode([BreadImage].self, from: data.data)
			})
			.map({ $0.map { $0.url } })
			.tryMap({ $0.map { try! Data(contentsOf: $0) } })
			.map({ $0.map {UIImage(data: $0)!} })
			.subscribe(on: queue)
			.eraseToAnyPublisher()
	}
	
	func loadImage(breedId: String) -> AnyPublisher<UIImage, Error> {
		guard let url = Endpoint.thumbnail(breedId: breedId).url else {
			fatalError("Invalid URL for - \(breedId) -> \(#function)")
		}
		
		if let image = cache[url] {
			self.image = image
		}
		
		let request = TheCatApiRequest.getRequest(with: url)
		
		return images(from: request)
			.map { $0.first }
			.compactMap{ $0 }
			.handleEvents(receiveOutput: { self.cache[url] = $0 })
			.eraseToAnyPublisher()
		
	}
	
	
	func loadImages(breedId: String) -> AnyPublisher<[UIImage], Error> {
		guard let url = Endpoint.images(breedId: breedId).url else {
			fatalError("Invalid URL for - \(breedId) -> \(#function)")
		}
		
		let request = TheCatApiRequest.getRequest(with: url)
		return images(from: request)
	}
}
