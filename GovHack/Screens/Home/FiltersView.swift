//
//  FiltersView.swift
//  GovHack
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI
import Introspect

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
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HeadingView(title: "What", detail: "Space type")
                    HStack {
                        ToggleButton(text: "All", isSelected: $viewModel.spaceAll)
                        ToggleButton(text: "Whole Office", isSelected: $viewModel.spaceWholeOffice)
                        ToggleButton(text: "Meeting Rooms", isSelected: $viewModel.spaceMeetingRoom)
                    }
                    HStack {
                        ToggleButton(text: "Hot Desks", isSelected: $viewModel.spaceDesk)
                        ToggleButton(text: "Studio", isSelected: $viewModel.spaceStudio)
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

                }
            }
            .padding(.horizontal, 16)
            .onAppear {
                locationFieldIsFocused = true
            }
            .navigationTitle("Filters")
        }
    }
}

extension FiltersView {

    func setupField(_ field: UITextField, _ min: Date, save: @escaping (Date) -> ()) {
        var color: UIColor = .black
        if let c = Color.urbanPrimary.cgColor {
            color = UIColor(cgColor: c)
        }

        let datePicker = UIDatePicker()
        field.inputView = datePicker
        datePicker.maximumDate = .distantFuture
        datePicker.minimumDate = min
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.tintColor = color
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.tintColor = color
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem()
        doneButton.tintColor = color
        doneButton.primaryAction = UIAction(title: "Done", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off, handler: { _ in
            save(datePicker.date)
            field.endEditing(true)
        })
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        field.inputAccessoryView = toolBar
    }

}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(searchModel: .constant(nil))
    }
}
