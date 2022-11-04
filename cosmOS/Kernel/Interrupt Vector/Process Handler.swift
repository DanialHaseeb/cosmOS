//
//  Process Handler.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

extension Process.Interrupt: Handleable
{
  var message: String
  {
    switch self
    {
      case .invalidID:
        return "Process ID already in use."
      case .noFreeFrames:
        return "Memory full."
    }
  }
}
