import UIKit

public class ColorWheel: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: .init(x: 0, y: 0, width: 240, height: 240))
        let image = UIImage(named: "ColorWheel")
        let imageView = UIImageView(image: image)
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
    }
        required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
