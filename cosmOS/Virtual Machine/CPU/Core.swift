//
//  Core.swift
//  cosmOS
//
//  Created by Danial Haseeb on 29/10/2022.
//

/// The virtual machine's processing core.
class Core
{
  /// The virtual machine core's general-purpose registers.
  static var R: [Byte: Register] =
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
  
  /// The virtual machine core's special-purpose registers.
  static var S: [Register] =
  [
    /*-----------------------------*/
    //             Zero
    /*-----------------------------*/
    //               0
                     0
    /*-----------------------------*/
        
                    
    /*-----------------------------*/
    //             Code
    /*-----------------------------*/
    //  Base   ,  Limit  , Counter
    //    1         2         3
     ,    0    ,    0    ,    0    ,
    /*-----------------------------*/
                    
                    
    /*-----------------------------*/
    //            Stack
    /*-----------------------------*/
    //  Base   ,  Limit  , Counter
    //    4         5         6
          0    ,    0    ,    0
    /*-----------------------------*/
                    
            
    /*-----------------------------*/
    //             Data
    /*-----------------------------*/
    //      Base     ,    Limit
    //       7              8
     ,       0       ,      0      ,
    /*-----------------------------*/
                    
    /*------------------------------------------------------*/
    //                         Flag
    /*------------------------------------------------------*/
    //                          9
    // ----------------------------------------------------
    //  Unused  | Overflow |   Sign   |   Zero   |   Carry
    //  15 – 4        3          2          1          0
           0__________0__________0__________0__________0
    /*------------------------------------------------------*/
                     
    /*------------------------------------------------------*/
    //                       Reserved
    //  10        11        12        13        14        15
     ,   0    ,    0    ,    0    ,    0    ,    0    ,    0
    /*------------------------------------------------------*/
  ]
  /// The current state of the virtual machine core.
  static var state = Process.State.new
  
  /// The current instruction to be executed by the virtual machine core.
  static var execute: Instruction = { }
  
  /// Copies the process control block of the given process into the virtual machine core's registers.
  static func load(_ process: Process)
  {
    MMU.pageTable = process.pageTable
    state = process.state
    R = process.R
    S = process.S
    execute = process.instruction
    process.log += "Loaded into Core at \(Clock.time).\n"
  }
  
  static func run()
  {
    Kernel.currentProcess.log += "\n\(Clock.time)\nState: \(state)\n"
    func fetch()
    {
      guard let opcode: Byte = MMU.next() else
      { return }
      Kernel.currentProcess.log += "Opcode: \(opcode.hex)\n"
      guard let instruction = ISA[opcode] else
      {
        Kernel.raise(Interrupt.invalidOpcode)
        return
      }
      
      execute = instruction
    }
    
    switch state
    {
      case .fetch:
        state = .execute
        fetch()
      case .execute:
        state = .fetch
        execute()
      default:
        return
    }
  }
}
