//
//  ImageCache.swift
//  Feed The Cat
//
//  Created by Robert Koval on 14.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import UIKit

struct ImageCache {
	private let cache: NSCache<NSURL, UIImage> = NSCache<NSURL, UIImage>()
	
	subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}
