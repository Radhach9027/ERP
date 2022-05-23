//
//  Bundle.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 23/05/22.
//

import Foundation

final class BundleClass {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
}
