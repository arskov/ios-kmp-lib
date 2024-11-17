//
//  ServiceLocator.swift
//  ios-kmp
//
//  Created by Arseni Kavalchuk on 17.11.24.
//

import Foundation
import KmpLib

class ServiceLocator {
    static let sharedInstance = ServiceLocator()

    private let mutliplatformService: MultiplatformService!
    private let storeProvider: StoreProvider!

    private init() {
        // Swift implementation of the CryptoProvider protocol exposed from KMP
        let cryptoProvider = IosCryptoProvider()
        // KMP implementation of Stor
        storeProvider = InMemoryStoreProvider()
        mutliplatformService = MultiplatformService(
            cryptoProvider: cryptoProvider, storeProvider: storeProvider)
    }

    func getMultiplatformService() -> MultiplatformService {
        return self.mutliplatformService
    }

    func getStoreProvider() -> StoreProvider {
        return self.storeProvider
    }
}
