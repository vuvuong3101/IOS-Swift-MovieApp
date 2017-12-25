// BCAExtention

import Foundation
import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideButtonWhenTapAround(TF: UITextField, Contant: NSLayoutConstraint){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        Contant.constant = 0
    }
    
    
    
    
}

extension UIView {
    
    class func fromNib<T : UIView>() -> T {
        
        guard let view = Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as? T else {
            return T()
        }
        
        return view
    }
    
    func setGradientBackground(startColor: UIColor, endColor: UIColor) {
        
        let colorTop =  startColor.cgColor
        let colorBottom = endColor.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = UIScreen.main.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    @IBDesignable class GradientView: UIView {
        
        @IBInspectable var startColor: UIColor = .blue {
            didSet {
                setNeedsLayout()
            }
        }
        
        @IBInspectable var endColor: UIColor = .green {
            didSet {
                setNeedsLayout()
            }
        }
        
        @IBInspectable var shadowColorA: UIColor = UIColor.black {
            didSet {
                setNeedsLayout()
            }
        }
        
        @IBInspectable var shadowX: CGFloat = 0 {
            didSet {
                setNeedsLayout()
            }
        }
        
        @IBInspectable var shadowY: CGFloat = -3 {
            didSet {
                setNeedsLayout()
            }
        }
        
        @IBInspectable var shadowBlur: CGFloat = 3 {
            didSet {
                setNeedsLayout()
            }
        }
        
        @IBInspectable var startPointX: CGFloat = 0 {
            didSet {
                setNeedsLayout()
            }
        }
        
        @IBInspectable var startPointY: CGFloat = 0 {
            didSet {
                setNeedsLayout()
            }
        }
        
        @IBInspectable var endPointX: CGFloat = 0 {
            didSet {
                setNeedsLayout()
            }
        }
        
        @IBInspectable var endPointY: CGFloat = 0 {
            didSet {
                setNeedsLayout()
            }
        }
        
        
        
        override class var layerClass: AnyClass {
            return CAGradientLayer.self
        }
        
        override func layoutSubviews() {
            let gradientLayer = layer as! CAGradientLayer
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
            gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
            layer.cornerRadius = cornerRadius
            layer.shadowColor = shadowColor?.cgColor
            layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
            layer.shadowRadius = shadowBlur
            layer.shadowOpacity = 1
        }
    }
    @IBInspectable
    var cornerRadius: CGFloat {
        
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        
        get {
            return layer.shadowRadius
        }
        
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        
        get {
            return layer.shadowOpacity
        }
        
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        
        get {
            return layer.shadowOffset
        }
        
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    static func mainColor() -> UIColor {
        return UIColor(netHex: 0x005059)
    }
    
    
}

enum PhoneNumberFormattingError: Error {
    case wrongCharactersInNumber
    case numberLongerThanPatternAllowes
}

enum PhoneNumberFormattingPatterns: String {
    case accountNo = "xxx-xxx-xxxx"
}

extension String {
    
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    func length() -> Int {
        return self.count
    }
    
    /**
     Formats a phone-number to correct format
     - Parameter pattern: The pattern to format the phone-number.
     - Example:
     - x: Says that this should be a digit.
     - y: Says that this digit cannot be a "0".
     - The length of the pattern restricts also the length of allowed phone-number digits.
     - phone-number: "1234567890"
     - pattern: "xxx-xxx-xxxx"
     - result: "123-456-7890"
     
     - Throws:
     - PhoneNumberFormattingError
     - wrongCharactersInPhoneNumber: if phone-number contains other characters than digits.
     - phoneNumberLongerThanPatternAllowes: if phone-number is longer than pattern allows.
     - Returns:
     - The formatted phone-number due to the pattern.
     */
    func vpToFormattedNumber(withPattern pattern: PhoneNumberFormattingPatterns) throws -> String {
        let phoneNumber = self.replacingOccurrences(of: "+", with: "")
        var retVal: String = ""
        var index = 0
        for char in pattern.rawValue.lowercased() {
            guard index < phoneNumber.count else {
                return retVal
            }
            
            if char == "x" {
                let charIndex = phoneNumber.index(phoneNumber.startIndex, offsetBy: index)
                let phoneChar = phoneNumber[charIndex]
                guard "0"..."9" ~= phoneChar else {
                    throw PhoneNumberFormattingError.wrongCharactersInNumber
                }
                retVal.append(phoneChar)
                index += 1
            } else if char == "y" {
                var charIndex = phoneNumber.index(phoneNumber.startIndex, offsetBy: index)
                var indexTemp = 1
                while phoneNumber[charIndex] == "0" {
                    charIndex = phoneNumber.index(phoneNumber.startIndex, offsetBy: index + indexTemp)
                    indexTemp += 1
                }
                
                let phoneChar = phoneNumber[charIndex]
                guard "0"..."9" ~= phoneChar else {
                    throw PhoneNumberFormattingError.wrongCharactersInNumber
                }
                retVal.append(phoneChar)
                index += indexTemp
            } else {
                retVal.append(char)
            }
        }
        
        if phoneNumber.endIndex > phoneNumber.index(phoneNumber.startIndex, offsetBy: index) {
            throw PhoneNumberFormattingError.numberLongerThanPatternAllowes
        }
        
        return retVal
    }
    
    func containsCharactersInRegexString(regexString: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regexString,
                                                options: NSRegularExpression.Options(rawValue: 0))
            let matches = regex.numberOfMatches(in: self,
                                                options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                range: NSMakeRange(0, self.count))
            return (matches > 0)
        } catch let error {
            print(error)
            return false
        }
    }
    
    func isPhoneNumber() -> Bool {
        return containsCharactersInRegexString(regexString:"([+]?1+[-]?)?+([(]?+([0-9]{3})?+[)]?)?+[-]?+[0-9]{3}+[-]?+[0-9]{4}")
    }
}

extension NSDictionary {
    
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return "?" + parts.joined(separator: "&")
    }
}

