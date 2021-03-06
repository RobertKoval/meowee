//
//  ContentView.swift
//  Feed The Cat
//
//  Created by Robert Koval on 10.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	let viewModel: CatCollectionViewModel = CatCollectionViewModel()
    var body: some View {
		NavigationView {
			CatCollectionView().environmentObject(viewModel)
		}//.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
