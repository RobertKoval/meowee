//
//  TheCatApiFetcher.swift
//  Feed The Cat
//
//  Created by Robert Koval on 11.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import Combine
import Foundation

enum TheCatApiFetcherError: Error {
	case invalidURL
	case response(description: String)
}

class TheCatApiFetcher {
	let session: URLSession
	
	func fetchBreeds() -> AnyPublisher<[Breed], Error> {
		guard let url = Endpoint.allBreeds.url else {
			return Fail(error: TheCatApiFetcherError.invalidURL).eraseToAnyPublisher()
		}
		let request = TheCatApiRequest.getRequest(with: url)
		return session.dataTaskPublisher(for: request)
			.mapError { TheCatApiFetcherError.response(description: $0.localizedDescription) }
			.tryMap {
				try JSONDecoder().decode([Breed].self, from: $0.data)
		}.eraseToAnyPublisher()
	}
	
	
	init(with session: URLSession = .shared) {
		self.session = session
	}
}
