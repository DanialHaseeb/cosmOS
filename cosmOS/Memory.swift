//
//  Memory.swift
//  cosmOS
//
//  Created by Danial Haseeb on 29/10/2022.
//

/// The main (dynamic and random-access) memory.
class Memory
{
  // MARK: Page
  
  /// A fixed-length, contiguous block of memory.
  ///
  /// It is the smallest unit of data for memory management by **cosmOS**.
  struct Page
  {
    /// The page size defined by the virtual machine architecture.
    ///
    /// Currently set to 128 bytes.
    static let size = 128 // bytes
    
    /// The contiguous and sequential array of bytes stored in this page.
    ///
    /// Since **cosmOS** uses byte-addressable memory, each element is a `Byte`.
    var bytes = Array(repeating: Byte(), count: Page.size)
    
    
    subscript(index: Int) -> Byte
    {
      get { bytes[index] }
      set { bytes[index] = newValue }
    }
  }
  
  // MARK: Class Properties
  
  /// The number of pages in the main memory.
  ///
  /// This property is determined by the address space and page size,
  /// both of which are defined by the virtual machine architecture.
  static let size = Address.space / Memory.Page.size
  
  /// The main memory contents.
  static var contents = Array(repeating: Page(), count: Memory.size)
}
