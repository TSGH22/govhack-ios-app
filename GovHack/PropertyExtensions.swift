//
//  PropertyExtensions.swift
//  GovSmack
//
//  Created by Mudasar Javed on 20/8/2022.
//

import Foundation

extension PropertyModel {
    var overallRating: Double {
        Double((spaceRating.cleanliness + spaceRating.facilities + spaceRating.noiseLevel) / 3)
    }
    
    func occupancy(for spaceTypes: [Space.Name]) -> Int? {
        spaces.reduce(0) { partialResult, space in
            return spaceTypes.contains(space.name) ? partialResult + space.capacity : partialResult
        }
    }
    
}
