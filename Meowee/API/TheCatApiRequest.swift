//
//  TheCatApiRequest.swift
//  Feed The Cat
//
//  Created by Robert Koval on 11.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import Foundation

fileprivate enum HeaderFields: String {
	case apiKey = "x-api-key"
}

final class TheCatApiRequest {
	private static let key = "030711bc-dfea-4398-93be-184ede442cde"

	static func getRequest(with url: URL) -> URLRequest {
		var request = URLRequest(url: url)
		request.addValue(key, forHTTPHeaderField: HeaderFields.apiKey.rawValue)
		return request
	}
}
