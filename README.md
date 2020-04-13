# PublishColorUtils

A cross-platfrom color object, can generate `Hex` and `CSS` representation of color.

## Usage

You can instantiate your color object using hex or RGBA/sRGBA component values.

```swift
Color(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)

Color(hex: "#ff00ff")

Color(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
```

### Hex and CSS representation

To get a hex representation or hex with alpha, just call:

```swift
let color = Color(red: 255/255, green: 0/255, blue: 255/255, alpha: 1)

color.hex // #FF00FF

color.hexWithAlpha // #FF00FFFF
```

If you need a css representation of color:

```swift
// RGB 
let color = Color(red: 255/255, green: 0/255, blue: 255/255, alpha: 1)

color.rgbaDescription // rgba(255, 0, 255, 1)

/// sRGB

let p3Color = Color(displayP3Red: 255/255, green: 0/255, blue: 255/255, alpha: 1)

p3Color.rgbaDescription // color(display-p3 1 0 1 / 1)
```

### Dark mode

Also, this color supports dark mode:

```swift
let color = Color(hex: "#efefef").adaptiveToDarkTheme(Color(hex: "#111111"))
color.dark.hex // #111111
```

### iOS Colors

We also supports iOS 13 system colors

```swift

Color.red == UIColor.systemRed

Color.pink == UIColor.systemPink

```


