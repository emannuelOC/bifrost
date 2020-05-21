
import UIKit

@objc public protocol DynamicActionDelegate: class {
    func callAction(sender: String)
}

protocol ComponentDelegate: class {
    func applyViewsFromJson(dynamicComponent: DynamicComponent,
                            actionDelegate: DynamicActionDelegate) throws -> UIView
}
