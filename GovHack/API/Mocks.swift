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
            images: [
                .init(string: "https://i1.au.reastatic.net/712x480,smart=85,r=33,g=40,b=46,quality=60,progressive/e10142aab6cd20c94081d2df660c7d933a085933fd73c74a5c20c9fc4993cc7d/image1.jpg")!,
                .init(string: "https://fastly.4sqi.net/img/general/600x600/124333_pMpKajVem-U3a6jNRApfsJvzgBZ54Y00T7x61Vfhyrs.jpg")!,
                .init(string: "https://fastly.4sqi.net/img/general/600x600/33980157_TA9SdMo9evEl30aNV7-THETBFS4mUj8Q0odZ1Sc5stw.jpg")!,
            ],
            floorPlan: .init(string: "https://wpmedia.roomsketcher.com/content/uploads/2022/01/06145940/What-is-a-floor-plan-with-dimensions.png")!,
            description: "description",
            facilities: .init(lift: true, shower: nil, monitors: true, projector: nil, stairs: true, accessibleAccess: nil, parking: nil, contactlessAccess: nil),
            owner: .init(company: "Tigerspike", contactName: "Tigerspike", contactEmail: "tigerspike@tigerspike.com"),
            location: .init(latitude: -33.8866647, longitude: 151.2115884, streetAddress: "115 Cooper St", suburb: "Surry Hills"),
            greenRating: 4,
            dressCode: .casual,
            houseRules: "dont be a dumdum",
            spaceRating: .init(cleanliness: 3, noiseLevel: 9, facilities: 5),
            spaces: [
                .init(type: .boardroom, capacity: 5, dailyPrice: 50, availability: [.init(startDate: 999, endDate: 99999)]),
                .init(type: .desk, capacity: 3, dailyPrice: 10, availability: [.init(startDate: 999, endDate: 9999999)])
            ]
        )
    }
}

extension PropertyModel.Space {

    static var mock: Self {
        .init(type: .boardroom, capacity: 5, dailyPrice: 50, availability: [.init(startDate: 999999, endDate: 999999)])
    }

}
