
import UIKit

struct Margin {
    var left: CGFloat
    var right: CGFloat
    var top: CGFloat
    var bottom: CGFloat
}

public class MarginTypeConverter: TypedTypeConverter {
    typealias Model = Margin
    
    func validateForType(value: Any) -> Margin? {
        guard let stringValue = value as? String else {
            return nil
        }
        
        let margins = stringValue.split(separator: ",").compactMap({ stringValue -> CGFloat? in
            if let value = NumberFormatter().number(from: String(stringValue)) {
                return CGFloat(truncating: value)
            } else {
                return nil
            }
        })
        
        if margins.count == 1 {
            return Margin(left: margins[0], right: margins[0], top: margins[0], bottom: margins[0])
        } else if margins.count == 2 {
            return Margin(left: margins[0], right: margins[0], top: margins[1], bottom: margins[1])
        } else if margins.count == 4 {
            return Margin(left: margins[0], right: margins[2], top: margins[1], bottom: margins[3])
        }
        
        return nil
    }
}
