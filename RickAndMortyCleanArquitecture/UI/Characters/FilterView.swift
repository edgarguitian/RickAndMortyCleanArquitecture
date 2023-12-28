//
//  FilterView.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 17/12/23.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject private var viewModel: CharacterListViewModel

    init(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Form {
            statusPicker
            genderPicker
            resetFiltersButton
        }
    }

    private var statusPicker: some View {
        Picker("Selecciona status", selection: $viewModel.selectedStatusIndex) {
            Text("Selecciona un status").tag(nil as Int?)
            ForEach(viewModel.charactersStatus.indices, id: \.self) { index in
                Text(viewModel.charactersStatus[index]).tag(index as Int?)
            }
        }
    }

    private var genderPicker: some View {
        Picker("Selecciona gender", selection: $viewModel.selectedGenderIndex) {
            Text("Selecciona un gender").tag(nil as Int?)
            ForEach(viewModel.charactersGender.indices, id: \.self) { index in
                Text(viewModel.charactersGender[index]).tag(index as Int?)
            }
        }
    }

    private var resetFiltersButton: some View {
        Button("Borrar filtros") {
            viewModel.resetFilters()
        }
    }
}
