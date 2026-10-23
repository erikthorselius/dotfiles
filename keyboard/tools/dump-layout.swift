import Carbon
import Foundation

let mods: [String: UInt32] = ["base": 0, "shift": 2, "caps": 4, "option": 8, "shiftOption": 10, "capsOption": 12, "control": 16]
let src = TISCopyCurrentKeyboardLayoutInputSource().takeRetainedValue()
let name = Unmanaged<CFString>.fromOpaque(TISGetInputSourceProperty(src, kTISPropertyLocalizedName)!).takeUnretainedValue() as String
let data = Unmanaged<CFData>.fromOpaque(TISGetInputSourceProperty(src, kTISPropertyUnicodeKeyLayoutData)!).takeUnretainedValue()
let layout = unsafeBitCast(CFDataGetBytePtr(data), to: UnsafePointer<UCKeyboardLayout>.self)

func translate(_ key: UInt16, _ mod: UInt32, _ state: UInt32) -> (String, UInt32) {
  var dead = state
  var len = 0
  var chars = [UniChar](repeating: 0, count: 8)
  UCKeyTranslate(layout, key, UInt16(kUCKeyActionDown), mod, UInt32(LMGetKbdType()), 0, &dead, 8, &len, &chars)
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
let out: [String: Any] = ["name": name, "keys": keys, "dead": dead]
FileHandle.standardOutput.write(try! JSONSerialization.data(withJSONObject: out, options: [.sortedKeys, .prettyPrinted]))
