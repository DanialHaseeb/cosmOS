//
//  Memory.swift
//  cosmOS
//
//  Created by Danial Haseeb on 29/10/2022.
//

/// The main (dynamic and random-access) memory.
///
/// Its size is predetermined by the address space and page size.
/// Both of these quantities are defined by the virtual machine architecture.
var memory = Array(repeating: Page(), count: (Address.space / Page.size))
