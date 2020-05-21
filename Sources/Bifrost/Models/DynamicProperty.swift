
import UIKit

class DynamicProperty: NSObject, BaseModelProtocol {
    
    static var typeConverters: [String: TypeConverter] = ["dimen" : FloatTypeConverter(),
                                                          "string" : ConcreteTypeConverter<String>(),
                                                          "color" : ColorTypeConverter(),
                                                          "url" : URLTypeConverter(),
                                                          "fontWeight": FontWeightTypeConverter(),
                                                          "gravity": GravityTypeConverter(),
                                                          "margin": MarginTypeConverter()]
    
    // MARK: Constants
    
    fileprivate static let kName = "name"
    fileprivate static let kType = "type"
    fileprivate static let kValue = "value"
    
    // MARK: Properties
    
    var name: String
    var type: String
    var value: Any
    
    // MARK: Initializers
    
    init(dictionary: [String: Any]) throws {
        guard let name = dictionary[DynamicProperty.kName] as? String,
            let type = dictionary[DynamicProperty.kType] as? String,
            let value = dictionary[DynamicProperty.kValue] as? String else {
                throw DynamicPropertyError.invalidJSONFormat
        }
        
        guard let typeConverter = DynamicProperty.typeConverters[type] else {
            throw DynamicPropertyError.unknownType(type: type)
        }
        
        guard let convertedValue = typeConverter.validate(value: value) else {
            throw DynamicPropertyError.invalidValue(type: type, value: value)
        }
        
        self.name = name
        self.type = type
        self.value = convertedValue
    }
}

extension DynamicProperty {
    
    override var debugDescription: String {
        let name = self.name
        let type = self.type
        let value = self.value
        return "DynamicProperty:\n\tname: \(name)\n\ttype: \(type)\n\tvalue: \(value)"
    }
    
}
