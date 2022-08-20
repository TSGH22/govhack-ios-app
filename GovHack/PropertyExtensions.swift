//
//  PropertyExtensions.swift
//  GovSmack
//
//  Created by Mudasar Javed on 20/8/2022.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension PropertyModel {
    var overallRating: Double {
        let total = spaceRating.cleanliness + spaceRating.facilities + spaceRating.noiseLevel
        return Double(Double(total) / 3.0).rounded(toPlaces: 1)
    }
    
    var lowestPrice: Float {
        spaces.map { $0.dailyPrice }.min() ?? 0
    }
    
    func occupancy(for spaceTypes: [Space.Name]) -> Int {
        spaces.reduce(0) { partialResult, space in
            return spaceTypes.contains(space.name) ? partialResult + space.capacity : partialResult
        }
    }
}
