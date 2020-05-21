
public class ConcreteTypeConverter<T>: TypedTypeConverter {
    typealias Model = T
    
    func validateForType(value: Any) -> T? {
        return value as? T
    }
}
