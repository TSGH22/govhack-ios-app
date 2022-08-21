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
    @FocusState var locationFieldIsFocused: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    if viewModel.currentPage == 0 {
                        page1
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
