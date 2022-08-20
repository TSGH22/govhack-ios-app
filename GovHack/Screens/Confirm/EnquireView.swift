//
//  ConfirmView.swift
//  GovSmack
//
//  Created by Max Chuquimia on 20/8/2022.
//

import SwiftUI

struct EnquireView: View {

    let space: PropertyModel.Space
    let property: PropertyModel

    @State var message = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Summary")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("asdasdas")

                Text("Date")

                Text("Free text")
                TextEditor(text: $message)
                    .frame(width: .infinity, height: 100, alignment: .leading)
                    .border(.green)
            }
        }
        .padding(.horizontal, 16)
        .overlay {
            VStack {
                Spacer()
                ZStack {
                    Color.red
                    HStack {
                        Button("Submit") {
                            
                        }
                    }
                }
                .frame(width: .infinity, height: 50)
            }
        }
        .navigationTitle("Request Booking")
    }
}

struct EnquireView_Previews: PreviewProvider {
    static var previews: some View {
        EnquireView(
            space: .mock, property: .mock)
    }
}
