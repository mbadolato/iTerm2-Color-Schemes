#!/usr/bin/env swift

import AppKit

enum iTermColors: String {
  case Ansi0 = "Ansi 0 Color"
  case Ansi1 = "Ansi 1 Color"
  case Ansi2 = "Ansi 2 Color"
  case Ansi3 = "Ansi 3 Color"
  case Ansi4 = "Ansi 4 Color"
  case Ansi5 = "Ansi 5 Color"
  case Ansi6 = "Ansi 6 Color"
  case Ansi7 = "Ansi 7 Color"
  case Ansi8 = "Ansi 8 Color"
  case Ansi9 = "Ansi 9 Color"
  case Ansi10 = "Ansi 10 Color"
  case Ansi11 = "Ansi 11 Color"
  case Ansi12 = "Ansi 12 Color"
  case Ansi13 = "Ansi 13 Color"
  case Ansi14 = "Ansi 14 Color"
  case Ansi15 = "Ansi 15 Color"
  case CursorText = "Cursor Text Color"
  case SelectedText = "Selected Text Color"
  case Foreground = "Foreground Color"
  case Background = "Background Color"
  case Bold = "Bold Color"
  case Selection = "Selection Color"
  case Cursor = "Cursor Color"
}

enum TerminalColors: String {
  case AnsiBlack           = "ANSIBlackColor"
  case AnsiRed             = "ANSIRedColor"
  case AnsiGreen           = "ANSIGreenColor"
  case AnsiYellow          = "ANSIYellowColor"
  case AnsiBlue            = "ANSIBlueColor"
  case AnsiMagenta         = "ANSIMagentaColor"
  case AnsiCyan            = "ANSICyanColor"
  case AnsiWhite           = "ANSIWhiteColor"
  case AnsiBrightBlack     = "ANSIBrightBlackColor"
  case AnsiBrightRed       = "ANSIBrightRedColor"
  case AnsiBrightGreen     = "ANSIBrightGreenColor"
  case AnsiBrightYellow    = "ANSIBrightYellowColor"
  case AnsiBrightBlue      = "ANSIBrightBlueColor"
  case AnsiBrightMagenta   = "ANSIBrightMagentaColor"
  case AnsiBrightCyan      = "ANSIBrightCyanColor"
  case AnsiBrightWhite     = "ANSIBrightWhiteColor"
  case Background          = "BackgroundColor"
  case Text                = "TextColor"
  case BoldText            = "TextBoldColor"
  case Selection           = "SelectionColor"
  case Cursor              = "CursorColor"
}

let iTermColor2TerminalColor = [
  iTermColors.Ansi0: TerminalColors.AnsiBlack,
  iTermColors.Ansi1: TerminalColors.AnsiRed,
  iTermColors.Ansi2: TerminalColors.AnsiGreen,
  iTermColors.Ansi3: TerminalColors.AnsiYellow,
  iTermColors.Ansi4: TerminalColors.AnsiBlue,
  iTermColors.Ansi5: TerminalColors.AnsiMagenta,
  iTermColors.Ansi6: TerminalColors.AnsiCyan,
  iTermColors.Ansi7: TerminalColors.AnsiWhite,
  iTermColors.Ansi8: TerminalColors.AnsiBrightBlack,
  iTermColors.Ansi9: TerminalColors.AnsiBrightRed,
  iTermColors.Ansi10: TerminalColors.AnsiBrightGreen,
  iTermColors.Ansi11: TerminalColors.AnsiBrightYellow,
  iTermColors.Ansi12: TerminalColors.AnsiBrightBlue,
  iTermColors.Ansi13: TerminalColors.AnsiBrightMagenta,
  iTermColors.Ansi14: TerminalColors.AnsiBrightCyan,
  iTermColors.Ansi15: TerminalColors.AnsiBrightWhite,
  iTermColors.Background: TerminalColors.Background,
  iTermColors.Foreground: TerminalColors.Text,
  iTermColors.Selection: TerminalColors.Selection,
  iTermColors.Bold: TerminalColors.BoldText,
  iTermColors.Cursor: TerminalColors.Cursor,
]

struct iTermColorComponent {
  static let Red = "Red Component"
  static let Green = "Green Component"
  static let Blue = "Blue Component"
}

func itermColorSchemeToTerminalColorScheme(_ itermColorScheme: NSDictionary, name: String) -> NSDictionary {
  var terminalColorScheme: [String: AnyObject] = [
    "name" : name as AnyObject,
    "type" : "Window Settings" as AnyObject,
    "ProfileCurrentVersion" : 2.04 as AnyObject,
    "columnCount": 90 as AnyObject,
    "rowCount": 50 as AnyObject,
    ]
  if let font = archivedFontWithName("PragmataPro", size: 14) {
    terminalColorScheme["Font"] = font as AnyObject?
  }
  for (rawKey, rawValue) in itermColorScheme {
    if let name = rawKey as? String {
      if let key = iTermColors(rawValue: name) {
        if let terminalKey = iTermColor2TerminalColor[key] {
          if let itermDict = rawValue as? [String: AnyObject] {
            let (r, g, b) = (
              floatValue(itermDict[iTermColorComponent.Red]),
              floatValue(itermDict[iTermColorComponent.Green]),
              floatValue(itermDict[iTermColorComponent.Blue]))
            let color = NSColor(deviceRed: r, green: g, blue: b, alpha: 1)
            let colorData = NSKeyedArchiver.archivedData(withRootObject: color)
            terminalColorScheme[terminalKey.rawValue] = colorData as AnyObject
          }
        }
      }
    }
  }
  return terminalColorScheme as NSDictionary
}

func archivedFontWithName(_ name: String, size: CGFloat) -> Data? {
  if let font = NSFont(name: name, size: size) {
    return NSKeyedArchiver.archivedData(withRootObject: font)
  }
  return nil
}

func floatValue(_ value: AnyObject?) -> CGFloat {
  if let num = value as? CGFloat {
    return num
  }
  return 0
}

func convertToTerminalColors(_ itermFile: String, terminalFile: NSString) {
  if let itermScheme = NSDictionary(contentsOfFile: itermFile) {
    print("converting \(itermFile) -> \(terminalFile)")
    let terminalName = ((terminalFile.lastPathComponent) as NSString).deletingPathExtension
    let terminalScheme = itermColorSchemeToTerminalColorScheme(itermScheme, name: terminalName)
    terminalScheme.write(toFile: terminalFile as String, atomically: true)
  } else {
    print("unable to load \(itermFile)")
  }
}

if CommandLine.argc > 1 {
  for itermFile in CommandLine.arguments {
    let terminalFilePath = (itermFile as NSString).deletingPathExtension + ".terminal"
    convertToTerminalColors(itermFile, terminalFile: terminalFilePath as NSString)
  }
} else {
  print("usage: iTermColorsToTerminalColors FILE.itermcolors [...]")
}

