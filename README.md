# SwiftNFC 📱🏷️ - Powerful Read+Write Content
### Accelerated by Apple SwiftUI & Backed with CoreNFC

<img width="1513" alt="NewCover" src="https://github.com/user-attachments/assets/4123ab55-6acd-4e61-9092-a7d180b95621" />

## Aims
Provide a super-easy way for Apple Developers to Read and Write NFC Tags on SwiftUI.

<img height="500px" src="https://user-images.githubusercontent.com/54872601/214478735-473777e6-942b-4c91-b1b3-9ea14e6b493d.gif" />

## Version
![GitHub release (latest by date)](https://img.shields.io/github/v/release/1998code/SwiftNFC?color=g&label=STABLE&style=for-the-badge)
![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/1998code/SwiftNFC?color=green&include_prereleases&label=BETA&style=for-the-badge)

<img width="128px" src="https://user-images.githubusercontent.com/54872601/214541974-765d5cc5-97d1-4f31-9cde-eafc27213280.png" />

## Environment

### Xcode Local
Tested on | Latest | Compatible
--------- | ------ | ----------
iOS       | 16     | > 14

*Apple Watch is well-known not supported. iPad / Mac is compatible with CoreNFC but there is no hardware to support this feature. 😂*

### Xcode Cloud ☁️
Compatible ✅

*Xcode Cloud requires Apple Developer Program membership.*

## Guide
[Full Tutorial](https://post.1998.media/how-to-create-a-simple-nfc-app-with-swiftui/)

## Preparation
1. Add to your project via Package Manager.
<img width="1194" alt="CleanShot 2023-01-25 at 12 23 13@2x" src="https://user-images.githubusercontent.com/54872601/214479471-65e1469c-613f-45dd-ac1f-a8383b746a93.png">

2. Add ```Near Field Communication Tag Reading``` (aka NFC) into the Project's Combilities.
<img width="793" alt="CleanShot 2023-01-25 at 12 30 23@2x" src="https://user-images.githubusercontent.com/54872601/214480669-01f352f0-ab74-42cd-a117-a39c50427acf.png">

3. Add NFC Privacy into ```Info.plist```
<img width="737" alt="CleanShot 2023-01-25 at 18 35 58@2x" src="https://user-images.githubusercontent.com/54872601/214542015-48aa77b1-70b6-4dc1-b953-712282a651e3.png">

## Basic Usage

1. Import first.
```swift
import SwiftNFC
```

2. Add ObservedObject before ```body``` or any ```some View```.

### Read
```swift
@ObservedObject var NFCR = NFCReader()
```

### Write
```swift
@ObservedObject var NFCW = NFCWriter()
```

### Functions
```swift
func read() {
    NFCR.read()
}
func write() {
    NFCW.msg = NFCR.msg
    NFCW.write()
}
```

## Reactive Properties

Both `NFCReader` and `NFCWriter` classes use `@Published` properties for automatic SwiftUI view updates:

### NFCReader Properties
- `startAlert` - Alert message shown when scanning starts
- `endAlert` - Custom alert message after scanning (optional)
- `msg` - Decoded NFC message content (updates after scan)
- `raw` - Raw NFC data with type, identifier, and payload information

### NFCWriter Properties
- `startAlert` - Alert message shown when writing starts
- `endAlert` - Custom alert message after writing (optional)
- `msg` - Content to write to the NFC tag
- `type` - Record type: "T" for text (default) or "U" for URI

These properties automatically trigger view updates when changed, enabling seamless SwiftUI integration with two-way bindings:

```swift
// Example: Bind to a TextField
TextField("Message", text: $NFCW.msg)

// Example: Display scan results
Text(NFCR.msg)
```

## Demo
Path: `./Demo` (Xcode Project in SwiftUI)

## License
MIT

## FAQ
Q1. How can I contribute to the project?<br/>
A1. Simply pull a request, and someone will review your code. If everything is okay, your changes will be merged and reflected in the next minor version.<br/>
Q2. Can I use it in Educational (includ. Student's Homework, Class's demo) or NGO or Commerical Project?<br/>
A2. YES. This project is under license of MIT. Feel free to use it :)
