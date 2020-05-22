//
//  BreedImage.swift
//  Feed The Cat
//
//  Created by Robert Koval on 12.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import Foundation

struct BreadImage: Codable {
    var id: String
    var url: URL
    var width: Int
    var height: Int
}
