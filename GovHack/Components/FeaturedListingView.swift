//
//  FeaturedListingView.swift
//  GovHack
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI

struct FeaturedListingView: View {
    let image: String
    let address: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(address)
                .padding(.horizontal, 8)
        }
        .padding(.bottom, 8)
        .frame(width: 150)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct FeaturedListingView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedListingView(
            image: "office",
            address: "115 Cooper St, Surry Hills NSW"
        )
    }
}
