//
//  Mocks.swift
//  GovHack
//
//  Created by Mudasar Javed on 20/8/2022.
//

import Foundation

extension Array where Element == PropertyModel {
    static var mock: [Element] {
        .init(repeating: .mock, count: 5)
    }
    
    static var mockFeatured: [Element] {
        .init(repeating: .mock, count: 5)
    }
}

extension PropertyModel {
    static var mock: Self {
        .init(
            id: UUID().uuidString,
            images: [],
            floorPlan: .init(string: "https://wpmedia.roomsketcher.com/content/uploads/2022/01/06145940/What-is-a-floor-plan-with-dimensions.png")!,
            decription: "description",
            facilities: .init(lift: true, shower: nil, monitors: true, projector: nil, stairs: true, accessibleAccess: nil, parking: nil, contactlessAccess: nil),
            owner: .init(company: "Tigerspike", name: "Tigerspike", email: "tigerspike@tigerspike.com"),
            location: .init(lat: -33.8866647, long: 151.2115884, streetAddress: "115 Cooper St", suburb: "Surry Hills"),
            greenRating: 4,
            dressCode: .casual,
            houseRules: "dont be a dumdum",
            spaceRating: .init(cleanliness: 4, noiseLevel: 3, facilities: 5),
            spaces: [.init(id: UUID().uuidString, name: .boardroom, capacity: 5, dailyPrice: 50, availabilty: .init(startDate: "10/10/2022", endDate: "11/11/2022"))]
        )
    }
}
