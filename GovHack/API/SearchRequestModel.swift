//
//  SearchRequestModel.swift
//  GovHack
//
//  Created by Max Chuquimia on 20/8/2022.
//

import Foundation

struct SearchRequestModel: Codable, Equatable {

    let latitude: Double
    let longitude: Double
    let radius: Int

    let maxPrice: Int?
    let facilities: [String: Bool]
    let spaces: [PropertyModel.Space.Name]
    let capacity: Int?
}

/*
 {
 Lat: Int
 Long: Int
 Radius: Int # metres
 MaxPrice: Float?
 IncludedFacilities: Facility?
 SpaceNames: [Spaces.Name]?
 Capacity: Int?
 }

 */
