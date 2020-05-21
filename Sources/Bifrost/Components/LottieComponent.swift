
import UIKit
import Lottie

fileprivate enum LottieProperty: String {
    case value = "animate"
}

class LottieComponent: BaseComponent {
    
    fileprivate let kLottieComponentType = "animation"
    
    fileprivate var lottieView: AnimationView!
    
    override func applyViewsFromJson(dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) throws -> UIView {
    
            self.addProperties(dynamicComponent.properties)
            self.setUpAnimation()
        
            return self.lottieView
        
    }
}

// MARK: - Properties

extension LottieComponent {
    private func addProperties(_ properties: [DynamicProperty]?) {
        if let properties = properties {
            for property in properties {
                self.identifyAndApplyProperty(property)
            }
        }
    }
    
    private func identifyAndApplyProperty(_ property: DynamicProperty) {
        if let propertyValue = property.value as? String, let lottieProperty = LottieProperty(rawValue: property.name) {
            switch lottieProperty {
            case .value:
                setAnimationValue(propertyValue)
                break
            }
        }
    }
    
    private func setAnimationValue(_ value: String?) {
        guard let jsonString = value,
            let jsonData = jsonString.data(using: .utf8) else {
                return
        }
        let decoder = JSONDecoder()
        if let animation = try? decoder.decode(Animation.self, from: jsonData) {
            self.lottieView = AnimationView(animation: animation)
        }
    }
}

// MARK: - Animation

extension LottieComponent {
    private func setUpAnimation() {
        lottieView.loopMode = .loop
        lottieView.play()
    }
}

// MARK: - JSON

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
