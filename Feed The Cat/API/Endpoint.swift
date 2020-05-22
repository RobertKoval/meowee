//
//  Endpoint.swift
//  Feed The Cat
//
//  Created by Robert Koval on 10.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import Foundation

fileprivate let base = "https://api.thecatapi.com/v1"

enum Endpoint {
	case allBreeds
	case thumbnail(breedId: String)
	case images(breedId: String)

	var toString: String {
		switch self {
		case .allBreeds:
			return "\(base)/breeds"
		case .thumbnail(breedId: let id):
			return "\(base)/images/search?breed_id=\(id)&limit=1"
		case .images(breedId: let id):
			return "\(base)/images/search?breed_id=\(id)&limit=10"
		}
	}
	
	var url: URL? {
		URL(string: self.toString)
	}
}

