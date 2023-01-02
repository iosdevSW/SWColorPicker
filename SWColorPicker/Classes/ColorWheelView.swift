import UIKit

public class ColorWheelView: UIView {
    //MARK: - Properties
    private var length: CGFloat!
    private var point: CGPoint!
    private var pointerRadius: CGFloat = 12
    
    weak var delegate: ColorWheelViewDelegate?
    
    private let colorWheelLayer = CALayer()
    
    private let pointerLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = UIColor.lightGray.cgColor
        
        return layer
    }()
    
    //MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(colorWheelLayer)
        self.layer.addSublayer(pointerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        if colorWheelLayer.contents == nil {
            self.length = min(self.frame.width,self.frame.height) // 정사각형 이미지 길이 높이, 넓이 중 짧은면을 길이로 한다.
            colorWheelLayer.frame = CGRect(x: 0, y: 0, width: length, height: length)
            colorWheelLayer.contents = createColorWheelImage(self.frame.size)
        }
    }
    
    //MARK: - Touch Pointer
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        var tempPoint = touch.location(in: self)
        var hsv = self.getHSVAtPoint(tempPoint)
        
        if hsv.saturation > 0.99 {
            tempPoint = self.getPointAtHSV(hsv)
            hsv = self.getHSVAtPoint(tempPoint)
        }
        self.point = tempPoint
        delegate?.selectedColor(hsv)
        pointerLayer.fillColor = hsv.cgColor

        drawPointerLayer()
    }
    
    private func drawPointerLayer() {
        self.pointerRadius = length * 0.055
        let path = UIBezierPath(roundedRect: .init(x: point.x - pointerRadius,
                                                   y: point.y - pointerRadius,
                                                   width: pointerRadius*2,
                                                   height: pointerRadius*2),
                                cornerRadius: pointerRadius)
        path.move(to: CGPoint(x: point.x, y: point.y + pointerRadius))
        path.addLine(to: CGPoint(x: point.x , y: point.y + pointerRadius*2 + 4))
        
        self.pointerLayer.path = path.cgPath
    }
    
    // MARK: - ColorWheel CGImage 만드는 함수
    private func createColorWheelImage(_ size: CGSize) -> CGImage {
        let bufferSize = Int(length * length * 4)   // 버퍼 사이즈는 RGBA를 사용하므로 총 4개의 컴포넌트를 사용하므로 * 4 즉
        // 한 픽셀에 4바이트라는 말이다.
        let data = CFDataCreateMutable(kCFAllocatorDefault, 0)!
        CFDataSetLength(data, bufferSize) // 데이터 크기 설정
        let dataPtr = CFDataGetMutableBytePtr(data) // 데이터의 포인터변수
        
        for i in stride(from: CGFloat(0), to: CGFloat(length*length), by: 1.0) {
            let x = i.truncatingRemainder(dividingBy: length)
            let y = i / length
            
            let hsv = getHSVAtPoint(CGPoint(x: x, y: y))
            var rgb = RGB(red: 0, green: 0, blue: 0, alpha: 0)
            
            if hsv.saturation <= 1.0 { rgb = hsvToRGB(hsv) }
            if hsv.saturation <= 1.0 && hsv.saturation > 0.99 { rgb.alpha = (1.0 - hsv.saturation) * 100 }
            
            let ptr = Int(i*4)
            dataPtr?[ptr] = UInt8(rgb.red*255)
            dataPtr?[ptr+1] = UInt8(rgb.green*255)
            dataPtr?[ptr+2] = UInt8(rgb.blue*255)
            dataPtr?[ptr+3] = UInt8(rgb.alpha*255)
        }
        
        return CGImage(width: Int(length), // 생성할 이미지 넓이
                       height: Int(length), // 생성할 이미지 높이
                       bitsPerComponent: 8, // RGB는 0~255 개 총 8비트
                       bitsPerPixel: 32, // 한 픽셀에 8*4 = 32비트
                       bytesPerRow: Int(length)*4, // 한 행의 길이는 생성할 이미지 길이 * 컴포넌트 구성 수
                       space: CGColorSpaceCreateDeviceRGB(), // RGB로 색표현
                       bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue), // 알파 표현 여부
                       provider: CGDataProvider(data: data)!,
                       decode: nil,
                       shouldInterpolate: false,
                       intent: .defaultIntent)!
    }
    
    private func getHSVAtPoint(_ point: CGPoint) -> HSV {
        let center = length / 2 // 반지름이자. 중앙 x,y좌표
        let nx = (center - point.x) / center // 0~1.0값으로 표현하기 위해 반지름으로 다시 나누어준다.
        let ny = (center - point.y) / center
        let saturation = sqrt(CGFloat(nx*nx + ny*ny)) // 피타고라스 정리 s구하기
        var hue: CGFloat = saturation == 0 ? 0 : acos(nx/saturation) / CGFloat.pi / 2.0
        if ny < 0 { hue = 1.0 - hue }
        
        return HSV(hue: hue, saturation: saturation, value: 1, alpha: 1)
    }
    
    private func getPointAtHSV(_ hsv: HSV) -> CGPoint {
        let center = length / 2

        let x = center + center * -cos(hsv.hue * CGFloat.pi * 2) // 삼각비 이용
        let y = center + center * -sin(hsv.hue * CGFloat.pi * 2) // 삼각비 이용
        
        return CGPoint(x: x, y: y)
    }
}
