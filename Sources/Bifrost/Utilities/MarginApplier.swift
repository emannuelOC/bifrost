
import UIKit

class MarginApplier {
    func tryApplyMargin(component: DynamicComponent, to view: UIView, in container: UIView) {
        let gravity = component.properties?.first(where: { $0.name == "margin" })?.value as? Margin ?? Margin(left: 0, right: 0, top: 0, bottom: 0)
        
        container
            .topAnchor(equalTo: view.topAnchor, constant: -gravity.top)
            .leadingAnchor(equalTo: view.leadingAnchor, constant: -gravity.left)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: gravity.right)
            .bottomAnchor(equalTo: view.bottomAnchor, constant: gravity.bottom)
    }
    
    func tryApplyMargin(margin: Margin, to view: UIView, in container: UIView) {
        view
            .topAnchor(equalTo: container.topAnchor, constant: margin.top)
            .leadingAnchor(equalTo: container.leadingAnchor, constant: margin.left)
            .trailingAnchor(equalTo: container.trailingAnchor, constant: -margin.right)
            .bottomAnchor(equalTo: container.bottomAnchor, constant: -margin.bottom)
    }
}
