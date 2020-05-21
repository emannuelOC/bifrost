
import UIKit

class KeyPathApplier<View: UIView, ValueType>: TypedPropertyApplier {
    
    typealias ViewType = View
    typealias Model = ValueType
    
    private let keyPath: ReferenceWritableKeyPath<View, ValueType>
    init(_ keyPath: ReferenceWritableKeyPath<View, ValueType>) {
        self.keyPath = keyPath
    }
    
    func apply(value: ValueType, to view: View) throws -> View {
        view[keyPath: self.keyPath] = value
        return view
    }
}
