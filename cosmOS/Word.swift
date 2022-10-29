//
//  Word.swift
//  cosmOS
//
//  Created by Danial Haseeb on 29/10/2022.
//

/// The natural unit of data defined by the virtual machine architecture.
///
/// It is a 16-bit datum handled as a unit by the ISA.
typealias Word = UInt16

extension Word
{
  /// Creates a new word from two given bytes.
  ///
  /// - Parameters:
  ///   - msb: The first (most significant) byte.
  ///   - lsb: The second (least significant) )byte.
  init(_ msb: Byte, _ lsb: Byte)
  {
    /* Convert input bytes into words. */
    let msb = Word(msb)
    let lsb = Word(lsb)
    
    /* Output. */
    self.init(256 * msb  +  lsb)
  }
  
  
}
