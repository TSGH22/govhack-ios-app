//
//  FeaturedListingsCarouselView.swift
//  Spacey
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI

struct FeaturedListingsCarouselView: View {
    @State var featuredListings: [PropertyModel] = []
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(featuredListings, id: \.id) {
                    FeaturedListingView(image: "office", address: "\($0.location.streetAddress), \($0.location.suburb)")
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
