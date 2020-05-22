//
//  CatInformationView.swift
//  Feed The Cat
//
//  Created by Robert Koval on 10.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import SwiftUI

struct ScrollSizePreferenceKey: PreferenceKey {
	typealias Value = CGRect
	
	static var defaultValue: CGRect = .zero
	
	static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
	}
}

struct CatInformationView: View {
	@EnvironmentObject var viewModel: CatInformationViewModel
	
	var body: some View {
		GeometryReader { geometry in
			List {
				self.photoScroll(using: geometry)
				
				ScrollView {
					VStack(spacing: 8) {
						self.descriptionViews
						
						self.barViews
					}.fixedSize(horizontal: false, vertical: true)
					
				}
			}
			.onAppear {
				UITableView.appearance().separatorStyle = .none
			}
			.onDisappear {
				UITableView.appearance().separatorStyle = .singleLine
			}
		}
		.navigationBarTitle(viewModel.breed.name)
		.onAppear {
			if self.viewModel.images.isEmpty {
				self.viewModel.fetchImages()
			}
		}
		.onDisappear {
			if self.viewModel.isLoading {
				self.viewModel.cancelDownload()
			}
		}
	}
	
	var descriptionViews: some View {
		Group {
			if self.viewModel.breed.altNames != nil && !self.viewModel.breed.altNames!.isEmpty {
				HStack {
					VStack(alignment: .leading) {
						Text("Alternative name").font(.headline)
						Text(self.viewModel.breed.altNames ?? "-")
					}
					Spacer()
				}
			}
			HStack {
				VStack(alignment: .leading) {
					Text("Origin").font(.headline)
					Text(self.viewModel.breed.origin)
				}
				Spacer()
			}
			
			HStack {
				VStack(alignment: .leading) {
					Text("Life span").font(.headline)
					Text(self.viewModel.breed.lifeSpan)
				}
				Spacer()
			}
			
			HStack {
				VStack(alignment: .leading) {
					Text("Temperament").font(.headline)
					Text(self.viewModel.breed.temperament)
				}
				Spacer()
			}
		}.fixedSize(horizontal: false, vertical: true)
	}
	
	var barViews: some View {
		Group {
			VStack(alignment: .leading) {
				Text("Adaptability").font(.headline)
				BarView(value: CGFloat(self.viewModel.breed.adaptability), maxValue: 5)
			}
			VStack(alignment: .leading) {
				Text("Affection level").font(.headline)
				BarView(value: CGFloat(self.viewModel.breed.affectionLevel), maxValue: 5)
			}
			VStack(alignment: .leading) {
				Text("Child friendly").font(.headline)
				BarView(value: CGFloat(self.viewModel.breed.childFriendly), maxValue: 5)
			}
			VStack(alignment: .leading) {
				Text("Dog friendly").font(.headline)
				BarView(value: CGFloat(self.viewModel.breed.childFriendly), maxValue: 5)
			}
			VStack(alignment: .leading) {
				Text("Energy level").font(.headline)
				BarView(value: CGFloat(self.viewModel.breed.energyLevel), maxValue: 5)
			}
			VStack(alignment: .leading) {
				Text("Grooming").font(.headline)
				BarView(value: CGFloat(self.viewModel.breed.grooming), maxValue: 5)
			}
			VStack(alignment: .leading) {
				Text("Health issue").font(.headline)
				BarView(value: CGFloat(self.viewModel.breed.healthIssues), maxValue: 5)
			}
			VStack(alignment: .leading) {
				Text("Intelligence").font(.headline)
				BarView(value: CGFloat(self.viewModel.breed.intelligence), maxValue: 5)
			}
			VStack(alignment: .leading) {
				Text("Vocalisation").font(.headline)
				BarView(value: CGFloat(self.viewModel.breed.vocalisation), maxValue: 5)
			}
		}
	}
	
	func photoScroll(using geometry: GeometryProxy) -> some View {
		ScrollView(.horizontal) {
			HStack(spacing: 0) {
				ForEach(0..<self.viewModel.images.count, id: \.self) { index in
					Image(uiImage: self.viewModel.images[index]).resizable().scaledToFill()
						.frame(width: geometry.size.width, height: geometry.size.width).aspectRatio(1, contentMode: .fill).clipped()
				}
				
				if self.viewModel.images.isEmpty {
					Rectangle()
						.foregroundColor(Color.gray)
						.overlay(ActivityIndicator(isAnimating: self.$viewModel.isLoading, style: .large))
						.frame(width: geometry.size.width, height: geometry.size.width)
				}
			}
		}.padding([.leading, .trailing], -20)
			.background (
				GeometryReader { geometry in
					Rectangle().foregroundColor(.clear).preference(key: ScrollSizePreferenceKey.self, value: geometry.frame(in: .global))
				}
		)
	}
}

struct CatInformationView_Previews: PreviewProvider {
	static var previews: some View {
		CatInformationView().environmentObject(CatInformationViewModel(breed: Breed(adaptability: 0, affectionLevel: 0, altNames: "dsfs", cfaUrl: nil, childFriendly: 0, countryCode: "Ukr", countryCodes: "124", description: "f asf as asf asf ", dogFriendly: 4, energyLevel: 4, experimental: 4, grooming: 4, hairless: 4, healthIssues: 4, hypoallergenic: 4, id: "saffsa", indoor: 5, intelligence: 5, lap: 5, lifeSpan: "123", name: "Kek", natural: 5, origin: "asfasf", rare: 4, rex: 4, sheddingLevel: 4, shortLegs: 4, socialNeeds: 4, strangerFriendly: 4, suppressedTail: 4, temperament: "safasf", vcahospitalsUrl: nil, vetstreetUrl: nil, vocalisation: 5, weight: Breed.Weight(imperial: "saf", metric: "asf"), wikipediaUrl: nil, bidability: 4, catFriendly: 8), imageLoader: BreedImageLoader()))
	}
}
