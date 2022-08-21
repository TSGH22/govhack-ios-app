//
//  FiltersView+Page1.swift
//  Spacey
//
//  Created by Max Chuquimia on 21/8/2022.
//

import SwiftUI

extension FiltersView {
    var page2: some View {
        VStack(alignment: .leading) {
            Group {
                HeadingView(title: "Facilities", detail: "Select all desired")
                CheckboxView(title: "Computer Screens", isOn: $viewModel.facMonitors)
                CheckboxView(title: "Wifi", isOn: $viewModel.facWifi)
                CheckboxView(title: "Whiteboard", isOn: $viewModel.facWhiteboard)
                CheckboxView(title: "Standing Desks", isOn: $viewModel.facStandingDesks)
                CheckboxView(title: "Kitchen Access", isOn: $viewModel.facKitchen)
                CheckboxView(title: "Toilets", isOn: $viewModel.facToilet)
                CheckboxView(title: "Showers", isOn: $viewModel.facShowers)
                CheckboxView(title: "Car Parking", isOn: $viewModel.facParking)
                CheckboxView(title: "Aircon", isOn: $viewModel.facAircon)
            }
            HeadingView(title: "Accessibility", detail: "Learn more")
            HStack {
                ToggleButton(text: "Wheelchair accessible", isSelected: $viewModel.facAccessibleAccess)
            }
        }
    }
}

struct FiltersView_Page2_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(searchModel: .constant(nil), viewModel: FiltersViewModel()).page2
    }
}
