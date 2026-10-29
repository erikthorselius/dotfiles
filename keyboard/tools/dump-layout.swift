import Carbon
import Foundation

func fail(_ message: String) -> Never {
  FileHandle.standardError.write(Data("error: \(message)\n".utf8))
  exit(1)
}

let mods: [String: UInt32] = ["base": 0, "shift": 2, "caps": 4, "option": 8, "shiftOption": 10, "capsOption": 12, "control": 16]
let src = TISCopyCurrentKeyboardLayoutInputSource().takeRetainedValue()
guard let nameProperty = TISGetInputSourceProperty(src, kTISPropertyLocalizedName),
      let sourceIDProperty = TISGetInputSourceProperty(src, kTISPropertyInputSourceID),
      let dataProperty = TISGetInputSourceProperty(src, kTISPropertyUnicodeKeyLayoutData) else {
  fail("the current input source does not expose a Unicode keyboard layout")
}
let name = Unmanaged<CFString>.fromOpaque(nameProperty).takeUnretainedValue() as String
let sourceID = Unmanaged<CFString>.fromOpaque(sourceIDProperty).takeUnretainedValue() as String
guard sourceID == "com.apple.keylayout.US" else {
  fail("select the U.S. input source before dumping; current source is \(name) (\(sourceID))")
}
let data = Unmanaged<CFData>.fromOpaque(dataProperty).takeUnretainedValue()
let layout = unsafeBitCast(CFDataGetBytePtr(data), to: UnsafePointer<UCKeyboardLayout>.self)

func translate(_ key: UInt16, _ mod: UInt32, _ state: UInt32) -> (String, UInt32) {
  var dead = state
  var len = 0
  var chars = [UniChar](repeating: 0, count: 8)
  let status = UCKeyTranslate(layout, key, UInt16(kUCKeyActionDown), mod, UInt32(LMGetKbdType()), 0, &dead, 8, &len, &chars)
  guard status == noErr else { fail("could not translate key \(key) (status \(status))") }
  return (String(utf16CodeUnits: chars, count: len), dead)
}

var keys: [String: [String: Any]] = [:]
var deadStates: [UInt32: String] = [:]
for k in 0..<128 {
  for (m, v) in mods {
    let (s, d) = translate(UInt16(k), v, 0)
    if d != 0 {
      deadStates[d] = deadStates[d] ?? "dead\(deadStates.count)"
      keys["\(k)", default: [:]][m] = ["dead": deadStates[d]!]
    } else {
      keys["\(k)", default: [:]][m] = s
    }
  }
}
var dead: [String: [String: Any]] = [:]
for (d, id) in deadStates {
  let terminator = translate(49, 0, d).0
  var compose: [String: [String: String]] = [:]
  for k in 0..<128 {
    for (m, v) in mods where m != "control" {
      let (s, _) = translate(UInt16(k), v, d)
      guard case let plain as String = keys["\(k)"]?[m] else { continue }
      if !s.isEmpty && s != terminator + plain { compose["\(k)", default: [:]][m] = s }
    }
  }
  dead[id] = ["terminator": terminator, "compose": compose]
}
let out: [String: Any] = ["id": sourceID, "name": name, "keys": keys, "dead": dead]
do {
  FileHandle.standardOutput.write(try JSONSerialization.data(withJSONObject: out, options: [.sortedKeys, .prettyPrinted]))
} catch {
  fail("could not encode layout as JSON: \(error)")
}
