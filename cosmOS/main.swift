//
//  main.swift
//  cosmOS
//
//  Created by Danial Haseeb on 29/10/2022.
//

let p: Process.State = .terminated()


if case .terminated(let time, let error) = p
{
  print(time, error)
}
