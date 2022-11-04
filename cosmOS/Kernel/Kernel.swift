//
//  Kernel.swift
//  cosmOS
//
//  Created by Danial Haseeb on 30/10/2022.
//

/// The virtual machine's operating system.
class Kernel
{
  static var logo =
  """

  -----------------------
  ┌─┐┌─┐┌─┐┌┬┐╔═╗╔═╗✨1.0
  │  │ │└─┐│││║ ║╚═╗
  └─┘└─┘└─┘┴ ┴╚═╝╚═╝
  -----------------------
  
  """
  
  /// The process at the core of **cosmOS**.
  ///
  /// It has complete control over everything in the virtual machine architecture.
  static var task = Process(Kernel())
}
