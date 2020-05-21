
public enum DynamicPropertyError: Error {
    case invalidJSONFormat
    case invalidValue(type: String, value: Any)
    case unknownType(type: String)
}
