
import UIKit

public class DynamicView: NSObject {

    public static func createView(dynamicsComponent: DynamicComponent,
                                  actionDelegate: DynamicActionDelegate) throws -> UIView {
        
        if let componentType = components[dynamicsComponent.type ?? ""] {
            let comp = componentType.init()
            return try! comp.applyViewsFromJson(dynamicComponent: dynamicsComponent,
                                    actionDelegate: actionDelegate)
        } else {
            throw ParseError.invalidType
        }
    }
    
    private static let components = [
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
