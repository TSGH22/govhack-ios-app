//
//  FeaturedListingView.swift
//  GovHack
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI

struct FeaturedListingView: View {
    let image: String
    let property: PropertyModel
    
    var body: some View {
        NavigationLink {
            ListingDetailView(property: property)
        } label: {
            VStack(alignment: .leading) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("\(property.location.streetAddress), \(property.location.suburb)")
                    .padding(.horizontal, 8)
            }
            .padding(.bottom, 8)
            .frame(width: 150)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(.plain)
    }
}

struct FeaturedListingView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedListingView(
            image: "office",
            property: .mock
        )
    }
}
