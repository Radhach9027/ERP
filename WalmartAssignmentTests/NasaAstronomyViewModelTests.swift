//
//  NasaAstronomyViewModelTests.swift
//  WalmartAssignmentTests
//
//  Created by radha chilamkurthy on 25/04/22.
//

import XCTest
@testable import WalmartAssignment
import Combine
import NetworkClient

final class NasaAstronomyViewModelTests: XCTestCase {
    private var sut: NasaAstronomyViewModelProtocol!
    private var cancellable = Set<AnyCancellable>()

    func test_fetchAstronomy_thenMockApiSuccess_shouldReceiveModel() {
        
            // GIVEN
        let mockNetwork = MockNetwork(isSuccess: true)
        let expectedModel = mockNetwork.expectedAstronomyModel
        let service = AstronomyService(network: mockNetwork)
        sut = NasaAstronomyViewModel(service: service)
        
        
            // WHEN
        sut.fetchAstronomy(on: .main)
        
            // THEN
        sut.subject
            .compactMap{$0}
            .sink { result in
                switch result {
                    case .failure(let error):
                        XCTAssertThrowsError(error.localizedDescription)
                    case .finished:
                        XCTAssertTrue(true)
                }
            } receiveValue: { model in
                XCTAssertNotNil(model)
                XCTAssertEqual(model, expectedModel)
            }.store(in: &cancellable)
    }
    
    func test_fetchAstronomy_thenMockApiFailure_shouldReceiveError() {
        
            // GIVEN
        let mockNetwork = MockNetwork(isSuccess: false,
                                      errorType: .badUrl)
        
        let service = AstronomyService(network: mockNetwork)
        sut = NasaAstronomyViewModel(service: service)
        
            // WHEN
        sut.fetchAstronomy(on: .main)
        
            // THEN
        sut.subject
            .compactMap{$0}
            .sink { result in
                switch result {
                    case .failure(let error):
                        XCTAssertEqual(error.localizedDescription, "Bad Request, Please check your request and try again.")
                    default:
                        break
                }
            } receiveValue: { model in
                XCTAssertNil(model)
            }.store(in: &cancellable)
    }
}
