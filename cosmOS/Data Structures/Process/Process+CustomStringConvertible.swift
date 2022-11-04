//
//  Process+CustomStringConvertible.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

extension Process: CustomStringConvertible
{
  var description: String
  {
    let ᴘᴄʙ =
    """
    # cosmOS
    ## Process: \(name) | ID: \(self.ID)
    
    ### Page Table
    \(pageTable)
    
    ### General-Purpose Registers
    R1:  \(R[0]!.hex)    R9:  \(R[8]!.hex)
    R2:  \(R[0]!.hex)    R10: \(R[9]!.hex)
    R3:  \(R[2]!.hex)    R11: \(R[10]!.hex)
    R4:  \(R[3]!.hex)    R12: \(R[11]!.hex)
    R5:  \(R[4]!.hex)    R13: \(R[12]!.hex)
    R6:  \(R[5]!.hex)    R14: \(R[13]!.hex)
    R7:  \(R[6]!.hex)    R15: \(R[14]!.hex)
    R8:  \(R[7]!.hex)    R16: \(R[15]!.hex)
    
    ### Special-Purpose Registers
    
    #### Zero
    \(S[0].hex)
    
    #### Code
    Base: \(S[1].hex)    Limit: \(S[2].hex)    Counter: \(S[3].hex)
    
    #### Stack
    Base: \(S[4].hex)    Limit: \(S[5].hex)    Counter: \(S[6].hex)
    
    #### Data
    Base: \(S[7].hex)    Limit: \(S[8].hex)
    
    #### Flag
    \(S[9].hex)
    
    ------------------------------------------
    ### Log
    
    """
    
    return ᴘᴄʙ + log
  }
}
