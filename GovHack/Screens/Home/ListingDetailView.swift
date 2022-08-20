//
//  ListingDetailView.swift
//  Spacey
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI

struct ListingDetailView: View {
    var property: PropertyModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(property.images, id: \.self) {
                            AsyncImage(url: $0, content: { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 100, maxHeight: 250)
                            }, placeholder: {
                                ProgressView()
                            })
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                Text("Detail")
                    .padding(.horizontal, 16)
                
                Group {
                    Text("\(property.location.streetAddress), \(property.location.suburb)")
                    Text("$\(property.lowestPrice.formatted(.currency(code: "$")))")
                    Text("Occupancy: \(property.occupancy(for: PropertyModel.Space.Name.allCases))")
                    Text("\(property.location.streetAddress), \(property.location.suburb)")
                    Text("Rating: \(property.overallRating.formatted())")
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                
                
                
            }
        }
        .navigationTitle(property.location.streetAddress)
    }
}

struct ListingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetailView(property: .mock)
    }
}
