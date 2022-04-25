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
    private var service: AstronomyServiceProtocol
    private var cancellable = Set<AnyCancellable>()
    var subject: CurrentValueSubject<NasaAstronomy?, NetworkError> = .init(nil)

    init(service: AstronomyServiceProtocol = AstronomyService()) {
        self.service = service
    }

    func fetchAstronomy(on receive: DispatchQueue) {
        service.fetchAstronomyFromServer(endpoint: .fetch,
                                         receive: .main)
            .sink { [weak self] result in
                switch result {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.subject.send(completion: .failure(error))
                }
            } receiveValue: { [weak self] model in
                self?.subject.send(model)
            }.store(in: &cancellable)
    }
}
