//
//  DynamicLayoutReceiver.swift
//  Pix
//
//  Created by Николай Красиков on 07.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//


protocol DynamicLayoutReceiver {
   var dynamicLayout: DynamicLayout! { get set }
   func setupDynamicLayout()
}
