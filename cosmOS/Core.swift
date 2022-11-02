//
//  Core.swift
//  cosmOS
//
//  Created by Danial Haseeb on 29/10/2022.
//

/// The virtual machine's processing core.
class Core
{
  // MARK: Alias
  
  /// The container for a word value.
  typealias Register = Word
  
  // MARK: Stored Properties
  
  /// The current state of the virtual machine core.
  static var state = Process.State.ready
  
  /// The execution log of the virtual machine core.
  static var log: String = ""
  
  /// The virtual machine core's general-purpose registers.
  static var R: [Byte: Core.Register] =
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
  static var S: [Core.Register] =
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
}
