
import UIKit

fileprivate enum FrameProperty: String {
    case width = "width"
    case height = "height"
    case backgroundColor = "backgroundColor"
    case margin = "margin"
}

class FrameComponent: BaseComponent {
    
    fileprivate let kFrameComponentType = "frame"
    
    var view: UIView?
    var superview = UIView()
    
    private var propertyDictionary: [FrameProperty: AnyPropertyApplier<UIView>] = [
        .width: AnyPropertyApplier(SelfConstraintApplier<UIView>(dimension: .width)),
        .height: AnyPropertyApplier(SelfConstraintApplier<UIView>(dimension: .height)),
        .backgroundColor: AnyPropertyApplier(KeyPathApplier(\UIView.backgroundColor))
    ]
    
    override func applyViewsFromJson(dynamicComponent: DynamicComponent,
                                     actionDelegate: DynamicActionDelegate) throws -> UIView {
        let view = try FrameComponentView(items: dynamicComponent.children ?? [], delegate: actionDelegate)
        self.view = view
        superview.addSubview(view)
        superview.translatesAutoresizingMaskIntoConstraints = false
        try addProperties(properties: dynamicComponent.properties)
        return superview
        
    }
}

extension FrameComponent {
    private func addProperties(properties: [DynamicProperty]?) throws {
        addMargin(properties: properties ?? [])
        try properties?.filter({ $0.name != FrameProperty.margin.rawValue }).forEach({
            try self.identityAndApplyProperties(property: $0)
        })
    }
    
    private func addMargin(properties: [DynamicProperty]) {
        let marginApplier = MarginApplier()
        guard let margin = properties.first(where: { $0.name == FrameProperty.margin.rawValue })?.value as? Margin else {
            return
        }
        marginApplier.tryApplyMargin(margin: margin, to: view, in: superview)
    }
    
    private func identityAndApplyProperties(property: DynamicProperty) throws {
        guard let textViewProperty = FrameProperty(rawValue: property.name),
            let applier = propertyDictionary[textViewProperty] else {
                throw ParseError.unknownProperty("\(property.name) of type \(property.type) and value: \(property.value)")
        }
        
        guard let view = self.view else { return }
        _ = try applier.apply(value: property.value, to: view)
    }
}

private class FrameComponentView: UIView {
    
    var components: [DynamicComponent]
    var delegate: DynamicActionDelegate

    init(items: [DynamicComponent], delegate: DynamicActionDelegate) throws {
        self.components = items
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
        try setupChilds()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupChilds() throws {
        for component in components {
            let childView = try DynamicView.createView(dynamicsComponent: component, actionDelegate: delegate)
            self.addSubview(childView)
            
            let gravity = component.properties?.first(where: { $0.name == "gravity" })?.value as? Gravity ?? Gravity()
            
            childView.translatesAutoresizingMaskIntoConstraints = false
            
            switch gravity.vertical {
            case .bottom:
                childView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                childView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor).isActive = true
            case .top:
                childView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
                childView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            case .center:
                childView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor).isActive = true
                childView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
                childView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            }
            
            switch gravity.horizontal {
            case .left:
                childView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                childView.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor).isActive = true
            case .right:
                childView.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor).isActive = true
                childView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            case .center:
                childView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
                childView.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor).isActive = true
                childView.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor).isActive = true
                
            }
        }
    }
}
