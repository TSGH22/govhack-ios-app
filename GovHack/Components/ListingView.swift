//
//  ListingView.swift
//  GovHack
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI

struct ListingView: View {
    var property: PropertyModel
    var spaceTypes: [PropertyModel.Space.Name]
    
    var body: some View {
        HStack(spacing: .zero) {
            Image("office")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack {
                Group {
                    Text("\(property.location.streetAddress), \(property.location.suburb)")
                    Text("$\(property.lowestPrice.formatted(.currency(code: "$")))")
                    Text("Occupancy: \(property.occupancy(for: spaceTypes))")
                    Text("\(property.location.streetAddress), \(property.location.suburb)")
                    Text("Rating: \(property.overallRating.formatted())")
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 8)
            .padding(.trailing, 16)
        }
        .frame(height: 115)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView(property: .mock, spaceTypes: [.boardroom, .desk])
            .padding(.horizontal, 16)
    }
}
