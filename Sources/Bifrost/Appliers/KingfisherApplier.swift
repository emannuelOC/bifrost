
import UIKit
import Kingfisher

public class KingfisherApplier: TypedPropertyApplier {
    typealias ViewType = UIImageView
    
    func apply(value: URL, to: UIImageView) throws -> UIImageView {
        to.kf.setImage(with: value)
        return to
    }
}
