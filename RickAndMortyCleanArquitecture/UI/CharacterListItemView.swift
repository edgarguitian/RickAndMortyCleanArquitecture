//
//  CharacterListItemView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import SwiftUI

struct CharacterListItemView: View {
    let item: CharacterListPresentableItem

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: item.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
            } placeholder: {
                ProgressView()
            }

            Text(item.name)
                .font(.title2)
                .lineLimit(1)

            Spacer()
        }.padding()
    }
}

#Preview {
    CharacterListItemView(item: 
        CharacterListPresentableItem(id: "1", name: "Test Name 1", status: "Test Status 1", species: "Test Species 1", type: "Test Type 1", gender: "Test Gender 1", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
    )
}
