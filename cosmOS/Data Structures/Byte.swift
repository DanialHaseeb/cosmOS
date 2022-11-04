//
//  Byte.swift
//  cosmOS
//
//  Created by Danial Haseeb on 29/10/2022.
//

/// The smallest addressable unit of memory in **cosmOS**.
///
/// A byte is an unsigned integer in the range [0, 255].
/// Equivalent to `unsigned char` in C.
typealias Byte = UInt8

extension Byte
{
  /// Creates a byte from the given character's ᴀsᴄɪɪ value.
  ///
  /// - Parameter character: The given character to be converted.
  init(_ character: Character)
  {
    let unicode = character.unicodeScalars  // store unicode scalars
    let firstCharacter = unicode.first!     // extract first character
    let ᴀsᴄɪɪValue = firstCharacter.value   // store ᴀsᴄɪɪ value
    self.init(ᴀsᴄɪɪValue)                   // output
  }
  
  /// A two digit hexadecimal representation of this byte.
  var hex: String
  {
    let hexString = String(self, radix: 16, uppercase: true)  // store hex
    
    guard (self > 0xF) else       // if this byte has only one hex digit:
    { return ("0" + hexString) }  //   prepend "0" to hex, then output
    
    return hexString  // output
  }
}
