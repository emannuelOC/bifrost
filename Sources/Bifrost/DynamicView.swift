
import UIKit

public class DynamicView: NSObject {

    public func createView(dynamicsComponent: DynamicComponent,
                                  actionDelegate: DynamicActionDelegate) throws -> UIView {
        
        if let componentType = components[dynamicsComponent.type ?? ""] {
            let comp = componentType.init()
            return try comp.applyViewsFromJson(dynamicComponent: dynamicsComponent,
                                                actionDelegate: actionDelegate)
        } else {
            throw ParseError.invalidType
        }
    }
    
    public func registerComponent(name: String, type: BaseComponent.Type) {
        components[name] = type
    }
    
    private var components = [
        "text": LabelComponent.self,
        "button": ButtonComponent.self,
        "textField": TextFieldComponent.self,
        "elementGroup": ElementGroupComponent.self,
        "image": ImageComponent.self,
        "animation": LottieComponent.self,
        "elementList": ElementList.self,
        "frame": FrameComponent.self
    ]
    
}
