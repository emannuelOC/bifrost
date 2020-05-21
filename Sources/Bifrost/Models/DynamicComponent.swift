
import UIKit

public class DynamicComponent: NSObject, BaseModelProtocol {

    // MARK: Constants
    
    fileprivate static let kType = "type"
    fileprivate static let kChildren = "children"
    fileprivate static let kProperties = "properties"
    
    // MARK: Properties
    
    var type: String?
    var children: [DynamicComponent]?
    var properties: [DynamicProperty]?
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    init(type: String?, children: [DynamicComponent]?, properties: [DynamicProperty]?) {
        self.type = type
        self.children = children
        self.properties = properties
    }
    
    public static func parse(dictionary: [String: Any]) throws -> DynamicComponent {
        let dynamicComponent = DynamicComponent()
        dynamicComponent.children = try self.parseChildrenArray(dictionary: dictionary)
        dynamicComponent.properties = try self.parsePropertiesArray(dictionary: dictionary)
        fillWithDictionary(&dynamicComponent.type, key: kType, dictionary: dictionary)
        return dynamicComponent
    }
    
    static private func parseChildrenArray(dictionary: [String: Any]) throws -> [DynamicComponent] {
        var childrenArray = [DynamicComponent]()
        if let childrenDictionary = dictionary[kChildren] as? [[String : Any]] {
            for item in childrenDictionary {
                let child = try DynamicComponent.parse(dictionary: item)
                childrenArray.append(child)
            }
        }
        return childrenArray
    }
    
    static private func parsePropertiesArray(dictionary: [String: Any]) throws -> [DynamicProperty] {
        if let propertiesDictionary = dictionary[kProperties] as? [[String : Any]] {
           return try propertiesDictionary.compactMap({
                return try DynamicProperty(dictionary: $0)
            })
        }
        return []
    }
    
}
