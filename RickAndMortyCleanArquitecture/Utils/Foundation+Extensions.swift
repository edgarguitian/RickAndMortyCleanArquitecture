//
//  Foundation+Extensions.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 15/12/23.
//

import Foundation

extension Result {
    var failureValue: Error? {
        switch self {
        case .failure(let error):
            return error
        case .success:
            return nil
        }
    }
}

extension Double {
    func toCurrency() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        return formatter.string(from: NSNumber(floatLiteral: self))
    }
}

extension Array {
    func elementsForPage(_ currentPage: Int, elementsPerPage: Int) -> ArraySlice<Element> {
        let startIndex = currentPage * elementsPerPage
        let endIndex = Swift.min(startIndex + elementsPerPage, count)

        // Asegúrate de que el rango esté dentro de los límites del array
        guard startIndex < count && endIndex <= count else {
            print("El índice está fuera de los límites del array.")
            return []
        }

        return self[startIndex..<endIndex]
    }
}
