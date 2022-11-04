//
//  Memory+CustomStringConvertible.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

extension Memory: CustomStringConvertible
{
  var description: String
  {
    var description =
    """
    # cosmOS
    ## Memory Contents
    
    """
    for i in (0..<Memory.size)
    {
      description +=
      """
      
      ### Frame \(i):
      \(Memory.contents[i])
      
      """
    }
    return description
  }
}
