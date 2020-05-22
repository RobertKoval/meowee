//
//  BarView.swift
//  Feed The Cat
//
//  Created by Robert Koval on 20.05.2020.
//  Copyright © 2020 Robert Koval. All rights reserved.
//

import SwiftUI

struct BarView: View {
	var value: CGFloat
	var maxValue: CGFloat
	
    var body: some View {
		GeometryReader { geometry in
				ZStack(alignment: .leading) {
					Rectangle().foregroundColor(.gray)
					Rectangle().foregroundColor(.blue).frame(width: geometry.size.width * (self.value / self.maxValue))
				}.frame(height: 8).cornerRadius(4)
		}
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
		BarView(value: 0.5, maxValue: 1)
    }
}
