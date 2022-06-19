import Foundation

final class BundleClass {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
}
