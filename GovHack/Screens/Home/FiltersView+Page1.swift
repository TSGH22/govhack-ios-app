//
//  FiltersView+Page1.swift
//  Spacey
//
//  Created by Max Chuquimia on 21/8/2022.
//

import SwiftUI

extension FiltersView {
    var page1: some View {
        VStack(alignment: .leading) {
            HeadingView(title: "What", detail: "Space type")
            Group {
                HStack {
                    ToggleButton(text: "All", isSelected: $viewModel.spaceAll)
                    ToggleButton(text: "Whole Office", isSelected: $viewModel.spaceWholeOffice)
                    ToggleButton(text: "Meeting Rooms", isSelected: $viewModel.spaceMeetingRoom)
                }
                HStack {
                    ToggleButton(text: "Hot Desks", isSelected: $viewModel.spaceDesk)
                    ToggleButton(text: "Studio", isSelected: $viewModel.spaceStudio)
                }
            }

            HeadingView(title: "Where", detail: "City or Suburb")
            NiceTextField(icon: nil, placeholder: "Search for City or Suburb", text: $viewModel.searchText)
                .focused($locationFieldIsFocused)
            if !viewModel.resolvedLocation.isEmpty {
                HStack {
                    Image(uiImage: UIImage(named: "Location")!)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(viewModel.resolvedLocation)
                        .font(.urbanistBodyMedium)
                        .foregroundColor(.urbanGrey500)
                }
                .frame(height: 50)
                .background(Color.urbanGrey50)
                .onTapGesture {
                    locationFieldIsFocused = false
                    viewModel.forceDisplay(search: viewModel.resolvedLocation)
                }
            }
            CheckboxView(title: "Include nearby areas", isOn: $viewModel.showNearbyAreas)

            HeadingView(title: "When", detail: "Date & Time")
            HStack {
                NiceTextField(icon: UIImage(named: "Calendar"), placeholder: "From", text: .constant(viewModel.dateFromString))
                    .introspectTextField { field in
                        setupField(field, Date()) { date in
                            viewModel.dateFrom = date
                        }
                    }
                Spacer()
                    .frame(width: 24)
                NiceTextField(icon: UIImage(named: "Calendar"), placeholder: "To", text: .constant(viewModel.dateToString))
                    .introspectTextField { field in
                        setupField(field, viewModel.dateFrom ?? Date()) { date in
                            viewModel.dateTo = date
                        }
                    }
            }

            HeadingView(title: "Who", detail: "Occupancy")
            NiceTextField(icon: nil, placeholder: "Number of People", text: $viewModel.numberOfPeopleField)
                .keyboardType(.numberPad)
                .introspectTextField { field in
                    var color: UIColor = .black
                    if let c = Color.urbanPrimary.cgColor {
                        color = UIColor(cgColor: c)
                    }
                    let toolBar = UIToolbar()
                    toolBar.sizeToFit()
                    toolBar.tintColor = color
                    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                    let doneButton = UIBarButtonItem()
                    doneButton.tintColor = color
                    doneButton.primaryAction = UIAction(title: "Done", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off, handler: { _ in
                        field.endEditing(true)
                    })
                    toolBar.setItems([flexibleSpace, doneButton], animated: false)
                    field.inputAccessoryView = toolBar
                }
        }
    }
}

struct FiltersView_Page1_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(searchModel: .constant(nil)).page1
    }
}
