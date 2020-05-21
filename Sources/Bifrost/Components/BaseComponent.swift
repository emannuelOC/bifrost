
import UIKit

class BaseComponent: NSObject, ComponentDelegate {
    
    var topPadding: CGFloat?
    var bottomPadding: CGFloat?
    var leadingPadding: CGFloat?
    var trailingPadding: CGFloat?
    
    override required init() {
        super.init()
    }
    
    func applyViewsFromJson(dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) throws -> UIView { fatalError("Must be overriden") }
}
