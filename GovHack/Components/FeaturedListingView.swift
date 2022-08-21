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
    let space: PropertyModel.Space
    
    var body: some View {
        NavigationLink {
            ListingDetailView(property: property)
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                Lozenge(text: space.type.rawValue)
                    .frame(maxWidth: .infinity, alignment: .center)
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: property.images[0], content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 154, height: 154)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }, placeholder: {
                        ProgressView()
                    })
                    HStack(spacing: .zero) {
                        Image("treeIcon")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text(property.greenRating.formatted())
                            .font(.urbanistBodySemiboldSmall)
                            .foregroundColor(.urbanPrimary300)
                    }
                    .padding(4)
                    .background(
                        RoundedRectangle(cornerRadius: 100).fill(Color.transparentWhite)
                    )
                    .padding(12)
                }
                Text(space.type.rawValue)
                    .font(.urbanistHeading6.bold())
                Text("\(property.location.streetAddress), \(property.location.suburb)")
                    .font(.urbanistBodyXSmall)
                
                HStack {
                    Text("From  ")
                        .font(.urbanistBodyBoldXSmall)
                        .foregroundColor(.urbanPrimary300) +
                    Text("$\(property.lowestPrice.formatted()) ")
                        .font(.urbanistHeading5.bold())
                        .foregroundColor(.urbanPrimary300) +
                    Text("/ hour")
                        .font(.urbanistBodyXSmall)
                        .foregroundColor(.urbanPrimary300)
                    Spacer()
                    Image("heartIcon")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.urbanPrimary300)
                }
            }
            .padding(14)
            .frame(width: 182)
            .background(RoundedRectangle(cornerRadius: 28).fill(Color.white))
        }
        .buttonStyle(.plain)
    }
}

struct FeaturedListingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ZStack {
                Color.gray.edgesIgnoringSafeArea(.all)
                FeaturedListingView(
                    image: "office",
                    property: .mock,
                    space: .mock
                )
            }
        }
    }
}
