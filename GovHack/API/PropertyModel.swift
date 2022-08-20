//
//  PropertyModel.swift
//  GovHack
//
//  Created by Max Chuquimia on 20/8/2022.
//

import Foundation

struct PropertyModel: Codable {
    let id: String
    let images: [URL]
    let floorPlan: URL
    let decription: String
    let facilities: Facilities
    let owner: Owner
    let location: Location
    let greenRating: Int
    let dressCode: DressCode
    let houseRules: String
    let spaceRating: SpaceRating
    let spaces: [Space]
}

extension PropertyModel {

    struct Facilities: Codable {
        let lift: Bool?
        let shower: Bool?
        let monitors: Bool?
        let projector: Bool?
        let stairs: Bool?
        let accessibleAccess: Bool?
        let parking: Bool?
        let contactlessAccess: Bool?
    }

    struct Owner: Codable {
        let company: String
        let name: String
        let email: String
    }

    struct Location: Codable {
        let lat: Double
        let long: Double
        let streetAddress: String
        let suburb: String
    }

    enum DressCode: String, Codable {
        case casual, smart_casual, formal
    }

    struct SpaceRating: Codable {
        let cleanliness: Int
        let noiseLevel: Int
        let facilities: Int
    }

    struct Space: Codable {
        let id: String
        let name: Name
        let capacity: Int
        let dailyPrice: Float
        let availabilty: Availability

        enum Name: String, Codable {
            case boardroom, desk, meeting_room
        }
    }

    struct Availability: Codable {
        let startDate: String
        let endDate: String
    }

}
