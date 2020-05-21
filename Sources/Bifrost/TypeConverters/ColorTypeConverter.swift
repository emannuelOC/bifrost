
import UIKit

public class ColorTypeConverter: TypeConverter {
    
    func validate(value: Any) -> Any? {
        guard let stringValue = value as? String else {
            return nil
        }
        
        return UIColor(hexadecimalString: stringValue)
    }
}
