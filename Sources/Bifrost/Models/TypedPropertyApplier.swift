
protocol TypedPropertyApplier: PropertyApplier {
    associatedtype Model
    
    func apply(value: Model, to: ViewType) throws -> ViewType
}

extension TypedPropertyApplier {
    func apply(value: Any, to view: ViewType) throws -> ViewType {
        guard let model = value as? Model else {
            throw ParseError.invalidType
        }
        
        return try self.apply(value: model, to: view)
    }
}
