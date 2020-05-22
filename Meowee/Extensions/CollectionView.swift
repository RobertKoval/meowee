//
//  CollectionView.swift
//  Feed The Cat
//
//  Created by Robert Koval on 13.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import UIKit
import SwiftUI

protocol CollectionViewDataSource: ObservableObject {
	associatedtype Data
	
	var dataSource: [Data] { get set }
	var numberOfColumns: Int { get set }
	var isLoading: Published<Bool>.Publisher { get }
	var grid: Published<[[Int]]>.Publisher { get }
}

struct CollectionView<U: CollectionViewDataSource, Content: View>: View {
	@ObservedObject var viewModel: U
	
	var content: (U.Data) -> Content
	@State var isLoading: Bool = true
	@State var grid: [[Int]] = []
	var body: some View {
		let needColumns = self.viewModel.numberOfColumns
		
		return ScrollView {
			ForEach(0..<grid.count, id: \.self) { index in
				HStack {
					ForEach(self.grid[index], id: \.self) { index in
						self.content(self.viewModel.dataSource[index])
					}
					if (self.grid[index].count < self.viewModel.numberOfColumns) { // Add empty rectangle
						ForEach(0..<needColumns - self.grid[index].count, id: \.self) {_ in
							Rectangle().foregroundColor(.clear)
						}
					}
				}
			}
		}
		.overlay(
			ActivityIndicator(isAnimating: self.$isLoading, style: .large)
		)
			.onReceive(viewModel.isLoading) { (value) in
				self.isLoading = value
		}
		.onReceive(viewModel.grid) { (value) in
			self.grid = value
		}
	}
	
	
	init(viewModel: U, @ViewBuilder content: @escaping (U.Data) -> Content) {
		self.viewModel = viewModel
		self.content = content
	}
}
