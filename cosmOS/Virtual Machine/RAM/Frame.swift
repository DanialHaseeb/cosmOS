//
//  Frame.swift
//  cosmOS
//
//  Created by Danial Haseeb on 03/11/2022.
//

extension Memory
{
  /// A fixed-length, contiguous block of memory.
  ///
  /// It is the smallest unit of data for memory management by **cosmOS**.
  struct Frame
  {
    /// The page size defined by the virtual machine architecture.
    ///
    /// Currently set to 128 bytes.
    static let size = 128 // bytes
    
    /// The contiguous and sequential array of bytes stored in this page.
    ///
    /// Since **cosmOS** uses byte-addressable memory, each element is a `Byte`.
    var bytes = Array(repeating: Byte(), count: Frame.size)
    
    
    subscript(index: Int) -> Byte
    {
      get { bytes[index] }
      set { bytes[index] = newValue }
    }
  }
}
