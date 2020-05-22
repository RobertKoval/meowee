//
//  CatCollectionViewModel.swift
//  Feed The Cat
//
//  Created by Robert Koval on 11.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import Foundation
import Combine

class CatCollectionViewModel: ObservableObject, CollectionViewDataSource{
	var isLoading: Published<Bool>.Publisher { $loading }
	var grid: Published<[[Int]]>.Publisher { $gridIndexes}
	
	@Published var dataSource: [Breed] = []
	@Published var numberOfColumns: Int = 2
	@Published var gridIndexes: [[Int]] = [[]]
	@Published var loading: Bool = true
	
	private var disposables = Set<AnyCancellable>()
	
	init() {
		TheCatApiFetcher().fetchBreeds()
			.receive(on: DispatchQueue.main)
			.replaceError(with: [])
			.handleEvents(
				receiveSubscription: { _ in self.loading = true },
				receiveOutput: { _ in self.loading = true},
				receiveCancel: { self.loading = true },
				receiveRequest: {_ in self.loading = true })
			.assign(to: \.dataSource, on: self)
			.store(in: &disposables)
		
		$dataSource.map({ (breeds)  in
			return (0..<breeds.count).publisher
				.collect(self.numberOfColumns)
				.collect()
				.handleEvents(
					receiveSubscription: {_ in self.loading = true },
					receiveOutput: { _ in self.loading = true },
					receiveRequest: { _ in self.loading = true })
		})
			.receive(on: DispatchQueue.main)
			.sink { (grid) in
				let _ = grid.sink { (grid) in
					self.loading = false
					self.gridIndexes = grid
				}
		}.store(in: &disposables)
	}
}
