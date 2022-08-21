//
//  ListingDetailView.swift
//  Spacey
//
//  Created by Mudasar Javed on 20/8/2022.
//

import SwiftUI
import MapKit

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ListingDetailView: View {
    var property: PropertyModel
    @Environment(\.dismiss) var dismiss: DismissAction
    
    private var header: some View {
        HStack {
            Image("backIcon").onTapGesture {
                dismiss()
            }
            Spacer()
            Image("heartIcon")
            Image("planeIcon")
        }.padding(.horizontal, 24)
    }
    
    private var galleryCarousel: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(property.images, id: \.self) {
                    AsyncImage(url: $0, content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 460)
                    }, placeholder: {
                        ProgressView()
                            .frame(maxHeight: 460)
                    })
                }
            }
        }
    }
    
    private func facilityIcon(icon: String, name: String) -> some View {
        VStack(alignment: .center) {
            Image(icon)
                .resizable()
                .frame(width: 28, height: 28)
                .background(
                    Circle()
                        .fill(Color.urbanPurple)
                        .frame(width: 60, height: 60)
                )
                .frame(width: 60, height: 60)
            Text(name)
                .font(.urbanistBodySemiboldSmall)
        }.frame(maxWidth: .infinity)
    }
    
    private func headingSubheadingView(title: String, subheading: String, icon: String) -> some View {
        HStack {
            Text(title)
                .font(.urbanistHeading5.bold())
            Spacer()
            Text(subheading)
                .font(.urbanistBodyMedium)
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
    
    private func mediaCell(title: String, icon: String) -> some View {
        VStack {
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24)
            Text(title)
                .font(.urbanistBodyBoldLarge)
                .foregroundColor(.urbanPrimary500)
        }
        .frame(width: 118, height: 118)
        .background(RoundedRectangle(cornerRadius: 30).fill(Color.urbanPurple))
    }
    
    private var facilities: some View {
        VStack {
            HStack {
                facilityIcon(icon: "screens", name: "Screens")
                facilityIcon(icon: "wifi", name: "Wifi")
                facilityIcon(icon: "whiteboard", name: "Whiteboard")
                facilityIcon(icon: "toilet", name: "Toilet")
            }
            HStack {
                facilityIcon(icon: "carSpot", name: "1 Car Spot")
                facilityIcon(icon: "petFriendly", name: "Pet Friendly")
                facilityIcon(icon: "aircon", name: "Air con")
                facilityIcon(icon: "conferencing", name: "Conferencing")
            }
        }
    }
    
    private var heading: some View {
        Group {
            galleryCarousel
            Text("Space Name")
                .font(.urbanistHeading3)
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 16)
            
            HStack {
                Lozenge(
                    text: "Up to 12 people",
                    font: .urbanistBodySemiboldMedium,
                    backgroundColor: .urbanPurple,
                    textColor: .urbanGrey900,
                    image: Image("expandIcon")
                )
                Lozenge(
                    text: "4.2",
                    font: .urbanistBodySemiboldMedium,
                    backgroundColor: .urbanPurple,
                    textColor: .urbanGrey900,
                    image: Image("starIcon")
                )
                Lozenge(
                    text: "4.8",
                    font: .urbanistBodySemiboldMedium,
                    backgroundColor: .urbanPurple,
                    textColor: .urbanGrey900,
                    image: Image("treeIcon")
                )
            }
            .padding(.horizontal, 24)
            
            Divider().padding(24)
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    heading
                    HStack {
                        Image("ownerPicture")
                            .resizable()
                            .frame(width: 80, height: 80)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Space Owner")
                                .font(.urbanistBodyMedium)
                            Text("Natasya Wilodra")
                                .font(.urbanistHeading6.bold())
                            HStack(spacing: 4) {
                                Image("policeCheckIcon")
                                Text("Police Check Verified")
                                    .font(.urbanistBodyMedium)
                                    .lineLimit(1)
                            }
                        }
                        Spacer()
                        Image("chatIcon")
                        Spacer()
                        Image("callIcon")
                    }
                    .padding(.horizontal, 24)
                    
                    Group {
                        Text("Overview")
                            .font(.urbanistHeading5.bold())
                            .padding(.top, 24)
                        Text("""
Industrial style office and creative space in Surry Hills featuring hot desks and meetings rooms for rent.

All hot desks are equippeped with the essentials to plug and play your computer.

We are family orienated office and encourage community space renters to join in our social perks plus  Read more...
"""
                        )
                        .font(.urbanistBodyLarge)
                        .padding(.top, 12)
                    }.padding(.horizontal, 24)
                    
                    Group {
                        Text("Facilities")
                            .font(.urbanistHeading5.bold())
                            .padding(.vertical, 24)
                        facilities
                    }.padding(.horizontal, 24)
                    
                    VStack(spacing: 24) {
                        headingSubheadingView(title: "Access Type", subheading: "Contactless Entry", icon: "qrIcon")
                        headingSubheadingView(title: "Accessibility", subheading: "Wheelchair Accessible", icon: "wheelChairIcon")
                    }.padding(24)
                    
                    Group {
                        Text("Location")
                            .font(.urbanistHeading5.bold())
                        HStack {
                            Image("Location")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            Text("Level 1, 115 Cooper Street, Surry Hills, 2010 NSW")
                                .font(.urbanistBodyMedium)
                                .foregroundColor(.urbanGrey700)
                        }.padding(.vertical, 20)
                        NormalMapView(
                            places: [],
                            selectedPlace: .constant(nil),
                            displayedRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -33.8865505412147, longitude: 151.21161037477057), latitudinalMeters: 1400, longitudinalMeters: 1400))
                        )
                        .frame(height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                    }.padding(.horizontal, 24)
                    
                    Group {
                        Text("Other Media")
                            .font(.urbanistHeading5.bold())
                            .padding(.vertical, 24)
                        HStack(spacing: 12) {
                            mediaCell(title: "Floor Plan", icon: "floorPlanIcon")
                            mediaCell(title: "Virtual Tour", icon: "virtualTour")
                        }
                    }.padding(.horizontal, 24)
                    
                    Group {
                        Text("Rules of Engagement")
                            .font(.urbanistHeading5.bold())
                            .padding(.horizontal, 24)
                            .padding(.top, 24)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("- All those entering into the space must be COVID vaccinated (at least double)")
                                    .font(.urbanistBodyLarge)
                                    .foregroundColor(.urbanGrey700)
                                Image("covidIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 55, height: 55)
                            }
                            Text("- Anything goes dress code")
                                .font(.urbanistBodyLarge)
                                .foregroundColor(.urbanGrey700)
                            Text("- Keep noise to a minimum and be respectful of others around you sharing the space")
                                .font(.urbanistBodyLarge)
                                .foregroundColor(.urbanGrey700)
                            Text("- Say hi to people around you in our office")
                                .font(.urbanistBodyLarge)
                                .foregroundColor(.urbanGrey700)
                        }
                        .padding(.horizontal, 24)
                    }
                    
                    Group {
                        Text("Ratings & Reviews")
                            .font(.urbanistHeading5.bold())
                            .padding(.vertical, 24)
                        
                        VStack(spacing: 24) {
                            HStack {
                                Image("starIcon")
                                Text("4.2")
                                    .font(.urbanistBodyBoldLarge)
                                Text("202 Reviews")
                                    .foregroundColor(.urbanGrey900)
                                    .font(.urbanistBodySemiboldLarge)
                                Spacer()
                                Text("See Reviews")
                                    .foregroundColor(.urbanPrimary500)
                            }
                            HStack {
                                Image("treeIcon")
                                Text("4.8")
                                    .font(.urbanistBodyBoldLarge)
                                Text("Green Score")
                                    .foregroundColor(.urbanGrey900)
                                    .font(.urbanistBodySemiboldLarge)
                                Spacer()
                                Text("More Info")
                                    .foregroundColor(.urbanPrimary500)
                            }
                        }
                        .padding(20)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.urbanPurple))
                    }.padding(.horizontal, 24)
                }
            }
            .edgesIgnoringSafeArea(.top)
            
            header
            VStack(spacing: 0) {
                Spacer()
                HStack(spacing: 8) {
                    Text("$85")
                        .font(.urbanistHeading3.bold())
                        .foregroundColor(.urbanPrimary300) +
                    Text("/ hour")
                        .font(.urbanistBodyMedium)
                        .foregroundColor(.urbanGrey700)
                    
                    Text("$255")
                        .font(.urbanistHeading3.bold())
                        .foregroundColor(.urbanPrimary300) +
                    Text("3 hours")
                        .font(.urbanistBodyMedium)
                        .foregroundColor(.urbanGrey700)
                    TallFilledButton(text: "Book", style: .darker, width: 100, action: {})
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 18)
                .background(Color.urbanGrey50)
            }
        }
        .navigationBarHidden(true)
    }
}

struct ListingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetailView(property: .mock)
    }
}
