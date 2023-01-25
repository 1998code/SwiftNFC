# SwiftNFC 📱🏷️ - Powerful Read+Write within few lines of Coding
### Accelerated by Apple SwiftUI & Backed with CoreNFC

<img width="350px" src="https://user-images.githubusercontent.com/54872601/214478735-473777e6-942b-4c91-b1b3-9ea14e6b493d.gif" />

## Aims
Provide a super-easy way for Apple Developers to Read and Write Tags on SwiftUI.

## Version
![GitHub release (latest by date)](https://img.shields.io/github/v/release/1998code/SwiftNFC?color=g&label=STABLE&style=for-the-badge)
![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/1998code/SwiftNFC?color=green&include_prereleases&label=BETA&style=for-the-badge)

## Environment

![CleanShot 2023-01-25 at 11 58 02@2x](https://user-images.githubusercontent.com/54872601/214476769-06b41017-f682-44d0-860a-3c01e0dc7eea.png)

### Xcode Local
Tested on | Latest | Compatible
--------- | ------ | ----------
iOS       | 16     | > 14

*Apple Watch is well-known not supported. iPad / Mac is compatible with CoreNFC but there is no hardware to support this feature. 😂*

### Xcode Cloud ☁️
Compatible ✅
*Xcode Cloud requires Apple Developer Program membership.*

## Guide
Full Tutorial on Medium

<img width="1194" alt="CleanShot 2023-01-25 at 12 23 13@2x" src="https://user-images.githubusercontent.com/54872601/214479471-65e1469c-613f-45dd-ac1f-a8383b746a93.png">

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

## Demo
Path: `./Demo` (Xcode Project in SwiftUI)

## License
MIT

## FAQ
Q1. How can I contribute to the project?<br/>
A1. Simply pull a request, and someone will review your code. If everything is okay, your changes will be merged and reflected in the next minor version.<br/>
Q2. Can I use it in Educational (includ. Student's Homework, Class's demo) or NGO or Commerical Project?<br/>
A2. YES. This project is under license of MIT. Feel free to use it :)
