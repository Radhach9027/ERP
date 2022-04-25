//
//  NasaAstronomyViewModel.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import Foundation
import Combine

protocol NasaAstronomyViewModelProtocol {
    func fetchAstronomy(on receive: DispatchQueue)
    var subject: CurrentValueSubject<NasaAstronomy?, NetworkError> { get }
}

final class NasaAstronomyViewModel: NasaAstronomyViewModelProtocol {
    var subject: CurrentValueSubject<NasaAstronomy?, NetworkError> = .init(nil)

    func fetchAstronomy(on receive: DispatchQueue) {
    }
}
