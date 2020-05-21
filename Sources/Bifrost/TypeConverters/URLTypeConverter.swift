
import UIKit

public class URLTypeConverter: TypeConverter {
    
    func validate(value: Any) -> Any? {
        guard let stringValue = value as? String else {
            return nil
        }
        
        return URL(string: stringValue)
    }
}
