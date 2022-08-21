//
//  FiltersView+Page3.swift
//  Spacey
//
//  Created by Max Chuquimia on 21/8/2022.
//

import SwiftUI

extension FiltersView {
    var page3: some View {
        VStack(alignment: .leading) {
            Group {
                HeadingView(title: "Space privacy", detail: "Select")
                HStack {
                    ToggleButton(text: "Any", isSelected: $viewModel.privacyAny)
                    ToggleButton(text: "Shared", isSelected: $viewModel.privacyShared)
                    ToggleButton(text: "Private", isSelected: $viewModel.privacyPrivate)
                }

            }
            HeadingView(title: "Building access", detail: "How to enter")
            HStack {
                ToggleButton(text: "Contactless Entry", isSelected: $viewModel.facContactlessAccess)
                ToggleButton(text: "Ring Doorbell", isSelected: $viewModel.facOfficeManagerAccess)
            }
            HeadingView(title: "Price range", detail: "per day")
            RangedSliderView(value: $viewModel.priceRangeSlider, bounds: 0...200)
                .frame(height: 30)

            HeadingView(title: "Space rating", detail: "")
            HStack {
                ToggleButton(image: UIImage(named: "Star"), text: "All", isSelected: $viewModel.ratingAll)
                ToggleButton(image: UIImage(named: "Star"), text: "1", isSelected: $viewModel.rating1)
                ToggleButton(image: UIImage(named: "Star"), text: "2", isSelected: $viewModel.rating2)
                ToggleButton(image: UIImage(named: "Star"), text: "3", isSelected: $viewModel.rating3)
                ToggleButton(image: UIImage(named: "Star"), text: "4", isSelected: $viewModel.rating4)
                ToggleButton(image: UIImage(named: "Star"), text: "5", isSelected: $viewModel.rating5)
            }

            HeadingView(title: "Message for the space owner", detail: "")

            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.urbanGrey50)
                Text("Tell the space owner more about you and what you need the space for.")
                    .padding(4)
                    .font(.urbanistBodyMedium)
                    .foregroundColor(.urbanGrey500)
            }
                .frame(height: 85, alignment: .leading)
                .background(Color.urbanGrey50)
                .cornerRadius(16)
        }
    }
}

struct FiltersView_Page3_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(searchModel: .constant(nil)).page3
    }
}
