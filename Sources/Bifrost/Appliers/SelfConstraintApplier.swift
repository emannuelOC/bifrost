
import UIKit

enum Dimension {
    case width
    case height
    case aspectRatio
}

public class SelfConstraintApplier<V: UIView>: TypedPropertyApplier {
    
    typealias ViewType = V
    
    let dimension: Dimension
    
    init(dimension: Dimension) {
        self.dimension = dimension
    }
    
    func apply(value: CGFloat, to view: V) throws -> V {
        switch self.dimension {
        case .width:
            view.widthAnchor.constraint(equalToConstant: value).isActive = true
        case .height:
            view.heightAnchor.constraint(equalToConstant: value).isActive = true
        case .aspectRatio:
            view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: value).isActive = true
        }
        
        return view
    }
}
