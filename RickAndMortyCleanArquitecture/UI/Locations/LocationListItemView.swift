//
//  LocationListItemView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import SwiftUI

struct LocationListItemView: View {
    let item: LocationListPresentableItem

    var body: some View {
        HStack {

            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.title3)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)

                Text(item.type)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .fontWeight(.medium)
                    .padding(.vertical, 2)

                Text("# \(item.id)")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .fontWeight(.medium)
                    .padding(.vertical, 2)
            }

            Spacer()

            HStack {
                Image(systemName: "chevron.right")
                Spacer().frame(width: 10)
            }
        }
        .padding(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("CellBackgroundColor"))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 4.0, x: 0.0, y: 4.0)
        .padding(.vertical)
        .frame(height: 140)
    }
}

#Preview {
    LocationListItemView(item: LocationListPresentableItem(id: "1", name: "Earth", type: "Planet", dimension: "Dimension C-137", residents: [], url: "", created: ""))
}
