//
//  Breed.swift
//  Feed The Cat
//
//  Created by Robert Koval on 10.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import Foundation

struct Breed: Codable {
	var adaptability: Int
	var affectionLevel: Int
	var altNames: String?
	var cfaUrl: URL?
	var childFriendly: Int
	var countryCode: String
	var countryCodes: String
	var description: String
	var dogFriendly: Int
	var energyLevel: Int
	var experimental: Int
	var grooming: Int
	var hairless: Int
	var healthIssues: Int
	var hypoallergenic: Int
	var id: String
	var indoor: Int
	var intelligence: Int
	var lap: Int?
	var lifeSpan: String
	var name: String
	var natural: Int
	var origin: String
	var rare: Int
	var rex: Int
	var sheddingLevel: Int
	var shortLegs: Int
	var socialNeeds: Int
	var strangerFriendly: Int
	var suppressedTail: Int
	var temperament: String
	var vcahospitalsUrl: String?
	var vetstreetUrl: URL?
	var vocalisation: Int
	struct Weight: Codable {
		var imperial: String
		var metric: String
	}
	var weight: Weight
	var wikipediaUrl: URL?
	var bidability: Int?
	var catFriendly: Int?
	private enum CodingKeys: String, CodingKey {
		case adaptability
		case affectionLevel = "affection_level"
		case altNames = "alt_names"
		case cfaUrl = "cfa_url"
		case childFriendly = "child_friendly"
		case countryCode = "country_code"
		case countryCodes = "country_codes"
		case description
		case dogFriendly = "dog_friendly"
		case energyLevel = "energy_level"
		case experimental
		case grooming
		case hairless
		case healthIssues = "health_issues"
		case hypoallergenic
		case id
		case indoor
		case intelligence
		case lap
		case lifeSpan = "life_span"
		case name
		case natural
		case origin
		case rare
		case rex
		case sheddingLevel = "shedding_level"
		case shortLegs = "short_legs"
		case socialNeeds = "social_needs"
		case strangerFriendly = "stranger_friendly"
		case suppressedTail = "suppressed_tail"
		case temperament
		case vcahospitalsUrl = "vcahospitals_url"
		case vetstreetUrl = "vetstreet_url"
		case vocalisation
		case weight
		case wikipediaUrl = "wikipedia_url"
		case bidability
		case catFriendly = "cat_friendly"
	}
}
