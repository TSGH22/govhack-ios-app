//
//  FeaturedListingsCarouselView.swift
//  Spacey
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI

struct FeaturedListingsCarouselView: View {
    var featuredListings: [PropertyModel] = []
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(featuredListings, id: \.id) {
                    FeaturedListingView(image: "office", property: $0)
                }
            }.padding(.leading, 16)
        }
    }
}

struct FeaturedListingsCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedListingsCarouselView(featuredListings: .mockFeatured)
    }
}
