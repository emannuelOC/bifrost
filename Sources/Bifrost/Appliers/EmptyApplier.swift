
import UIKit

class EmptyApplier<View: UIView>: TypedPropertyApplier {
    typealias ViewType = View
    typealias Model = Any
    
    func apply(value: Any, to: View) throws -> View { return to }
}
