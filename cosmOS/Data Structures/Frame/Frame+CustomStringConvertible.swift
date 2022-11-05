//
//  Frame+CustomStringConvertible.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

extension Memory.Frame: CustomStringConvertible
{
  var description: String
  {
    var description = ""
    for byte in self.bytes
    { description += byte.hex + " " }
    return description
  }
}
