import Foundation

/// A crossplatform representation of color
/// Can generate css and hex representation of color
public class Color: Hashable, Equatable {
    
    public private(set) var red: Float
    public private(set) var green: Float
    public private(set) var blue: Float
    public private(set) var alpha: Float
    
    public private(set) var isDisplayP3Space: Bool
    
    public private(set) var dark: Color?
    
    /// Creates a color object using the specified opacity and RGB component values.
    public init(red: Float, green: Float, blue: Float, alpha: Float = 1) {
        self.red = red
        self.blue = blue
        self.green = green
        self.alpha = alpha
        self.isDisplayP3Space = false
        self.dark = nil
    }
    
    /// Creates a color object using the specified opacity and RGB component values in the Display P3 color space.
    public init(displayP3Red red: Float, green: Float, blue: Float, alpha: Float = 1) {
        self.red = red
        self.blue = blue
        self.green = green
        self.alpha = alpha
        self.isDisplayP3Space = true
        self.dark = nil
    }
    
    /// Init color from hex. Only 6 digit supports.
    public convenience init(hex: String) {
        var hexadecimal = hex
            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            .uppercased()
        
        if hexadecimal.hasPrefix("#") {
            hexadecimal = String(hexadecimal.dropFirst())
        }
        
        guard hexadecimal.count == 6 else {
            fatalError("Incorrect hex")
        }
        
        var rgbValue: UInt64 = 0
        
        Scanner(string: hexadecimal).scanHexInt64(&rgbValue)
        
        self.init(
            red: Float((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: Float((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: Float(rgbValue & 0x0000FF) / 255.0,
            alpha: 1
        )
    }
    
    /// Return hex representation of color in format: `#000000`
    public var hex: String {
        return String(
            format: "#%02X%02X%02X",
            Int(self.red * 0xff),
            Int(self.green * 0xff),
            Int(self.blue * 0xff)
        )
    }
    
    /// Return hex representation of color in format: `#00000000`
    public var hexWithAlpha: String {
        return String(
            format: "#%02X%02X%02X%02X",
            Int(self.red * 0xff),
            Int(self.green * 0xff),
            Int(self.blue * 0xff),
            Int(self.alpha * 0xff)
        )
    }
    
    /// Return css representation of color in format: `rgba(red, green, blue, alpha)`
    /// If color has display p3 color space, that will generate in next format: `color(display-p3 red green blue / alpha)`
    public var rgbaDescription: String {
        if isDisplayP3Space {
            return String(format: "color(display-p3 %g %g %g / %g)", self.red, self.green, self.blue, self.alpha)
        } else {
            return String(format: "rgba(%.0f, %.0f, %.0f, %g)",
                          self.red * 255,
                          self.green * 255,
                          self.blue * 255,
                          self.alpha)
        }
    }
    
    /// Create color with opacity
    public func opacity(_ alpha: Float) -> Color {
        let copy = self.copy()
        copy.alpha = alpha
        return copy
    }
    
    /// Create color with dark theme support
    public func adaptiveToDarkTheme(_ darkColor: Color) -> Color {
        let copy = self.copy()
        copy.dark = darkColor
        return copy
    }
    
    func copy() -> Color {
        let color = Color(red: self.red, green: self.green, blue: self.blue, alpha: self.alpha)
        color.isDisplayP3Space = self.isDisplayP3Space
        return color
    }
    
    // MARK: Hashable
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.red)
        hasher.combine(self.green)
        hasher.combine(self.blue)
        hasher.combine(self.alpha)
        hasher.combine(self.isDisplayP3Space)
        hasher.combine(self.dark)
    }
    
    // MARK: Equatable
    
    public static func == (lhs: Color, rhs: Color) -> Bool {
        return lhs.hexWithAlpha == rhs.hexWithAlpha
    }
}

public extension Color {
    
    /// A color that support dark mode.
    /// - Note: Equals UIColor.systemRed
    static var red: Color {
        return Color(hex: "#ff3b30").adaptiveToDarkTheme(Color(hex: "#ff453a"))
    }
    
    /// A color that support dark mode.
    /// - Note: Equals UIColor.systemBlue
    static var blue: Color {
        return Color(hex: "#007aff").adaptiveToDarkTheme(Color(hex: "#0a84ff"))
    }
    
    /// A color that support dark mode.
    /// - Note: Equals UIColor.systemGreen
    static var green: Color {
        return Color(hex: "#34c759").adaptiveToDarkTheme(Color(hex: "#30d158"))
    }
    
    /// A color that support dark mode.
    /// - Note: Equals UIColor.systemTeal
    static var teal: Color {
        return Color(hex: "#5ac8fa").adaptiveToDarkTheme(Color(hex: "#64d2ff"))
    }
    
    /// A color that support dark mode.
    /// - Note: Equals UIColor.systemYellow
    static var yellow: Color {
        return Color(hex: "#ffcc00").adaptiveToDarkTheme(Color(hex: "#ffd60a"))
    }
    
    /// A color that support dark mode.
    /// - Note: Equals UIColor.systemPink
    static var pink: Color {
        return Color(hex: "#ff2d55").adaptiveToDarkTheme(Color(hex: "#ff375f"))
    }
    
    /// A color that support dark mode.
    /// - Note: Equals UIColor.systemPurple
    static var purple: Color {
        return Color(hex: "#af52de").adaptiveToDarkTheme(Color(hex: "#bf5af2"))
    }
    
    /// A color that support dark mode.
    /// - Note: Equals UIColor.systemOrange
    static var orange: Color {
        return Color(hex: "#ff9500").adaptiveToDarkTheme(Color(hex: "#ff9f0aff"))
    }
    
    /// A color that support dark mode.
    /// - Note: Equals UIColor.systemIndigo
    static var indigo: Color {
        return Color(hex: "#5856d6").adaptiveToDarkTheme(Color(hex: "#5e5ce6ff"))
    }
}

