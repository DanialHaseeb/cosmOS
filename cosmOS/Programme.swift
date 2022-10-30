//
//  Programme.swift
//  cosmOS
//
//  Created by Danial Haseeb on 20/10/2022.
//

import Foundation


/// A valid sequence of bytes representing instructions that **cosmOS** can execute.
class Programme
{
  // MARK: Interrupts
  
  /// The possible errors that may occur during programme loading.
  enum Interrupt: Exception
  {
    /// |`Programme`| < 8
    case invalidSize
    
    /// `priority` ∉ [0, 31]
    case invalidPriority
    
    /// |`data`| > |`Programme`|
    case invalidDataSize
  }
  
  // MARK: Stored Constants
  
  /// The (file) name of this programme.
  let name: String
  
  /// The initial priority of the process instance of this programme.
  let priority: Byte
  
  /// The ID of the process instance of this programme.
  let ID: Word
  
  /// The raw bytes that represent the data that this programme uses.
  let data: [Byte]
  
  /// The raw bytes that represent the source code of this programme.
  let code: [Byte]

  // MARK: Designated Initialiser
  
  /// Creates a programme given its name and associated bytes.
  ///
  /// - Parameters:
  ///   - name: The name of this programme.
  ///   - bytes: The array of bytes of this programme.
  init?(_ name: String, _ bytes: [Byte])
  {
    // TODO: Error Handling
    
    guard (bytes.count >= 8) else         // if |programme| < 8:
    {
      Kernel.raise(Interrupt.invalidSize) //   raise interrupt
      return nil
    }
    
    priority = bytes[0] // priority <- first byte
    
    guard (0...31).contains(priority) else    // if priority ∉ [0, 31]:
    {
      Kernel.raise(Interrupt.invalidPriority) //   raise interrupt
      return nil
      
    }
    
    ID = Word(bytes[1], bytes[2]) // ID <- second & third byte
    
    let dataSize = Word(bytes[3], bytes[4])     // |data| <- fourth & fifth byte
    guard (dataSize  <=  bytes.count - 8) else  // if |data| > |programme| - 8:
    {
      Kernel.raise(Interrupt.invalidDataSize)   //   raise exception
      return nil
    }                              //   throw error
    
    if (dataSize == 0)          // if |data| = 0:
    {
      data = []                 //   data <- nothing
      code = Array(bytes[8...]) //   ∵ code starts after data
    }
    else                        // otherwise:
    {
      let size  = Int(dataSize) //   store |data|
      var base  = 8             //   ∵ data starts from ninth byte
      let bound = base + size   //   data bound index
      
      data = Array(bytes[base..<bound]) // store data
      base = bound + 1                  // ∵ code starts after data
      code = Array(bytes[base...])      // store code (if any)
    }
    
    self.name = name  // store name
  }
  
  // MARK: Convenience Initialisers
  
  /// Creates a programme given its name and associated ᴀsᴄɪɪ characters.
  ///
  /// - Parameters:
  ///   - name: The name of this programme.
  ///   - characters: The array of ᴀsᴄɪɪ characters of this programme.
  convenience init?(_ name: String, _ characters: [Character])
  {
    let bytes = characters.map { Byte($0) }
    self.init(name, bytes)
  }
  
  /// Creates a programme given its name and associated string of bytes.
  ///
  /// - Parameters:
  ///   - name: The name of this programme.
  ///   - byteString: The string of bytes of this programme.
  convenience init?(_ name: String, _ byteString: String)
  {
    let characters = Array(byteString)
    self.init(name, characters)
  }
  
  /// Creates a programme given its associated file ᴜʀʟ.
  ///
  /// - Parameters:
  ///   - ᴜʀʟ: The ᴜʀʟ of this programme's file.
  convenience init?(_ ᴜʀʟ: URL)
  {
    let name = ᴜʀʟ.lastPathComponent  // store name
    do
    {
      let byteString = try String(contentsOf: ᴜʀʟ, encoding: .ascii)
      self.init(name, byteString)
    }
    catch
    { return nil }
  }
}
