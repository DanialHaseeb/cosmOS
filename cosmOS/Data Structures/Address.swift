//
//  Address.swift
//  cosmOS
//
//  Created by Danial Haseeb on 29/10/2022.
//

/// The standard address wrapper for all memory references in **cosmOS**.
struct Address
{
  // MARK: Class Constants
  
  /// The width of the address bus defined by the virtual machine architecture.
  ///
  /// Currently set to 16 bits.
  static let size = 16 // bits
  
  /// The total byte-addressable space in the main memory of our virtual machine.
  ///
  /// 16-bit addresses ⇒ 2¹⁶ uniquely addressable bytes.
  static let space = 1 << Address.size  // ∵ ∀n (1 << n  =  2ⁿ)
  
  // MARK: Stored Constants
  
  /// The page number reference of this address.
  let page: Int
  
  /// The offset of this adress.
  let offset: Int
  
  // MARK: Initialiser
  
  /// Converts the given word into a standard **cosmOS** address.
  ///
  /// - Parameter address: The word to be interpreted as an address.
  init(_ address: Word = 0)
  {
    let address = Int(address)          // convert the parameter into an integer
    page = address / Memory.Frame.size   // calculate and store page number
    offset = address % Memory.Frame.size // calculate and store offset
  }
}
