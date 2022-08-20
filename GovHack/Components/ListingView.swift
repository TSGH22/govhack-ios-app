//
//  ListingView.swift
//  GovHack
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI

struct ListingView: View {
    var property: PropertyModel
    
    var body: some View {
        HStack {
            Image("office")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack {
                Text("\(property.location.streetAddress), \(property.location.suburb)")
                Text("\(property.location.streetAddress), \(property.location.suburb)")
                Text("\(property.location.streetAddress), \(property.location.suburb)")
                Text("\(property.overallRating)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 100)
        .padding(16)
        .background(Color.gray)
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView(property: .mock)
    }
}
