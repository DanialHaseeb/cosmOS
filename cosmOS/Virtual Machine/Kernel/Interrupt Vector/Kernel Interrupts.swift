//
//  Kernel Interrupts.swift
//  cosmOS
//
//  Created by Danial Haseeb on 05/11/2022.
//

extension Kernel
{
  enum Interrupt: Handleable
  {
    case infiniteLoop
    
    var message: String
    { "Kernel: Possible infinite loop deteced." }
  }
}
