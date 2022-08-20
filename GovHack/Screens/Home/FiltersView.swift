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
    @ObservedObject var viewModel = FiltersViewModel()
    @FocusState private var locationFieldIsFocused: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Where do you want to work?")
                TextField("Suburb", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.alphabet)
                    .focused($locationFieldIsFocused)
                Text(viewModel.resolvedLocation)
                    .onTapGesture {
                        locationFieldIsFocused = false
                        viewModel.forceDisplay(search: viewModel.resolvedLocation)
                    }
                
                Text("Maximum Day Rate: $\(viewModel.maxPrice)")
                HStack {
                    Text("$10")
                    Slider(value: $viewModel.maxPrice, in: .init(uncheckedBounds: (10, 1000))) { _ in }
                        .tint(.white)
                    Text("$1000")
                }
                Text("Space")
                VStack {
                    HStack {
                        Toggle("Desks", isOn: $viewModel.spaceDesk)
                            .toggleStyle(.button)
                        Toggle("Meeting Rooms", isOn: $viewModel.spaceMeetingRoom)
                            .toggleStyle(.button)
                        Toggle("Boardrooms", isOn: $viewModel.spaceBoardroom)
                            .toggleStyle(.button)
                    }
                }
                .frame(maxWidth: .infinity)
                
                Text("Facilities")
                VStack {
                    HStack {
                        Toggle("Wifi", isOn: $viewModel.facWifi)
                            .toggleStyle(.button)
                        Toggle("Monitors", isOn: $viewModel.facMonitors)
                            .toggleStyle(.button)
                        Toggle("Projector", isOn: $viewModel.facProjector)
                            .toggleStyle(.button)
                    }
                    HStack {
                        Toggle("Accessible Access", isOn: $viewModel.facAccessibleAccess)
                            .toggleStyle(.button)
                        Toggle("Parking Available", isOn: $viewModel.facParking)
                            .toggleStyle(.button)
                    }
                    HStack {
                        Toggle("Instant Entry", isOn: $viewModel.facContactlessAccess)
                            .toggleStyle(.button)
                        Toggle("Showers", isOn: $viewModel.facShowers)
                            .toggleStyle(.button)
                    }
                }
                .frame(maxWidth: .infinity)

                Button("Search") {

                }
            }
        }
        .padding(.horizontal, 16)
        .background(Color.gray.edgesIgnoringSafeArea(.all))
        .onAppear {
            locationFieldIsFocused = true
        }
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(searchModel: .constant(nil))
    }
}
