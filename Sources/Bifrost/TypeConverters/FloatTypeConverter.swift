
import UIKit

public class FloatTypeConverter: ConcreteTypeConverter<CGFloat> {
    override func validateForType(value: Any) -> CGFloat? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        if let stringValue = value as? String, let value = formatter.number(from: stringValue) {
            return CGFloat(truncating: value)
        }
        
        if let intValue = value as? Int {
            return CGFloat(intValue)
        }
        
        return super.validateForType(value: value)
    }
}
