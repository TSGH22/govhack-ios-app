//
//  FiltersView.swift
//  GovHack
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI

enum Facility: String, CaseIterable {
    case lift
    case shower
    case monitors
    case projector
    case stairs
    case accessibleAccess = "Accessible Access"
    case parking
    case contactlessAccess = "Contactless Access"
}

struct FiltersView: View {
    @Binding var searchModel: SearchRequestModel?
    
    @State var lat: String = ""
    @State var long: String = ""
    @State var maxPrice: Float = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Tell us what you need")
                TextField("Latitude", text: $lat)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                
                TextField("Longitude", text: $long)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                
                TextField("Radius", text: $long)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                
                Text("Max price")
                Slider(value: $maxPrice, in: .init(uncheckedBounds: (0, 1000))) {
                    Text("Max price")
                }
                
                Text("Facilities")
                
            }
        }
        .padding(.horizontal, 16)
        .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(searchModel: .constant(nil))
    }
}
