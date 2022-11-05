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
  
  /// The value of this word textually represented as 16 binary digits.
  var binary: String
  {
    var bitString = String(self, radix: 2)  // convert from decimal to binary
    while (bitString.count < 16)            // while it has less than 16 digits
    { bitString = "0" + bitString }         // keep prepending zeros
    return bitString                        // return 16-bit string
  }
  
  /// A size-16 array of the individual bits of this word.
  var bits: [Bool]
  {
    get
    {
      var output = Array<Bool>(repeating: false, count: 16) // initialise output
      var character = Array(binary)                         // character array
      character = character.reversed()                      // indices at right
      for i in (0..<character.count)                        // loop characters:
      { output[i] = (character[i] == "0") ? false : true }  //   set output bit
      return output                                         // return output
    }
    
    set
    {
      var newWord = Word()          // initialise new word to compute
      for i in (0..<newValue.count) // loop through the new bits
      {
        if newValue[i]              // if the ith bit is 1
        { newWord += 1 << i }       // then add 2^i to the new word
        else                        // otherwise
        { continue }                // go on to the next bit
      }
      self = newWord                // set this word's value to the new word
    }
  }
  
  /// The two individual bytes of which this word is composed.
  var bytes: [Byte]
  {
    let (msb, lsb) = quotientAndRemainder(dividingBy: 256)
    return [Byte(lsb), Byte(msb)]
  }
  
  /// The value of this word textually represented as 4 hexadecimal digits.
  var hex: String
  {
    let msb = bytes.last!.hex
    let lsb = bytes.first!.hex
    return msb + lsb
  }
}
