//
//  Process.swift
//  cosmOS
//
//  Created by Danial Haseeb on 29/10/2022.
//

/// An instance of a programme that has been loaded into main memory.
class Process
{
  // MARK: Class Constant
  
  /// The size of the stack of each process defined by the virtual machine architecture.
  static let stackSize = 50
  
  // MARK: Stored Constants
  
  /// The file name of the programme of this process.
  let name: String
  
  /// The priority of this process.
  let priority: Byte
  
  /// A number used by **cosmOS** to uniquely identify this process.
  let ID: Process.ID
  
  /// The size of this process in bytes.
  ///
  /// |process| = |code| + |data| + |stack|
  let size: Int
  
  /// The page table of this process.
  let pageTable: PageTable
  
  // MARK: Stored Variables
  
  /// The state of this process.
  var state = State.new
  
  /// The core logs of this process.
  var log = ""
  
  /// The accounting information of this process.
  var time = (execution: 0, waiting: 0)
  
  /// The values of the general-purpose registers of this process.
  var R: [Byte: Core.Register] =
  [
    /*---------------------*/
    // code:  value // name
    /*---------------------*/
    0x0:    0,  //  R1
    0x1:    0,  //  R2
    0x2:    0,  //  R3
    0x3:    0,  //  R4
    0x4:    0,  //  R5
    0x5:    0,  //  R6
    0x6:    0,  //  R7
    0x7:    0,  //  R8
    0x8:    0,  //  R9
    0x9:    0,  //  R10
    0xA:    0,  //  R11
    0xB:    0,  //  R12
    0xC:    0,  //  R13
    0xD:    0,  //  R14
    0xE:    0,  //  R15
    0xF:    0,  //  R16
    /*---------------------*/
  ]
  
  // MARK: Initialisers
  
  /// The values of the special-purpose registers of this process.
  var S: [Word] = Array(repeating: 0, count: 16)
  
  /// Creates a process instance of the given programme.
  ///
  /// - Parameter programme: The given programme.
  init?(_ programme: Programme)
  {
    self.ID = programme.ID                      // store ID
    guard !(Kernel.IDs.contains(self.ID)) else  // if ID already in use:
    {
      Kernel.raise(Interrupt.invalidID)         //   raise interrupt
      return nil                                //   return nothing
    }
    self.size = programme.data.count + programme.code.count + Process.stackSize
    guard let pageTable = Kernel.allocate(size) else  // if memory is allocated:
    {
      Kernel.raise(Interrupt.noFreeFrames)            //   raise interrupt
      return nil                                      //   return nothing
    }
    self.pageTable = pageTable          // store page table
    self.name = programme.name          // store name
    self.priority = programme.priority  // store priority
    
    Kernel.IDs.insert(self.ID)  // mark ID as reserved
    
    /* Load programme into main memory. */
    
    let code  = Word(programme.code.count), // |code|
        data  = Word(programme.data.count), // |data|
        stack = Word(Process.stackSize)     // |stack|
    
    if (code == 0) && (data == 0)
    {
      let stackBase = stack - 1
      let stackCounter = stackBase + 1
      
      S[4] = stackBase
      S[6] = stackCounter
    }
    else if (code != 0) && (data == 0)
    {
      let codeLimit = code - 1
      let dataBase = codeLimit
      let dataLimit = dataBase
      let stackLimit = dataLimit + 1
      let stackBase = stackLimit + stack - 1
      let stackCounter = stackBase
      
      S[2] = codeLimit
      S[7] = dataBase
      S[8] = dataLimit
      S[5] = stackLimit
      S[4] = stackBase
      S[6] = stackCounter
      
      for address in (0...codeLimit)
      {
        let i = Int(address)
        let byte = programme.code[i]
        MMU.store(byte, at: address)
      }
    }
    else if (code == 0) && (data != 0)
    {
      let dataLimit = data - 1
      let stackLimit = dataLimit + 1
      let stackBase = stackLimit + stack - 1
      let stackCounter = stackBase
      
      S[8] = dataLimit
      S[5] = stackLimit
      S[4] = stackBase
      S[6] = stackCounter
      
      for address in (0...dataLimit)
      {
        let i = Int(address)
        let byte = programme.data[i]
        MMU.store(byte, at: address)
      }
    }
    else
    {
      let codeLimit = code - 1
      let dataBase = codeLimit + 1
      let dataLimit = dataBase + data - 1
      let stackLimit = dataLimit + 1
      let stackBase = stackLimit + stack - 1
      let stackCounter = stackBase
      
      S[2] = codeLimit
      S[7] = dataBase
      S[8] = dataLimit
      S[5] = stackLimit
      S[4] = stackBase
      S[6] = stackCounter
      
      for address in (0...codeLimit)
      {
        let i = Int(address)
        let byte = programme.code[i]
        MMU.store(byte, at: address)
      }
      
      for address in (dataBase...dataLimit)
      {
        let i = Int(address - dataBase)
        let byte = programme.code[i]
        MMU.store(byte, at: address)
      }
    }
  }
  
  /// Initialiser for the kernel task.
  init(_: Kernel)
  {
    self.ID = 0
    self.name = "cosmOS"
    
    self.priority = 0
    self.size = Memory.size
    self.state = .executing
    self.pageTable = Array(0..<Memory.size)
    self.S[8] = Word(Memory.size)
  }
}
