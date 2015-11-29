//
//  AppDelegate.swift
//  Colors
//
//  Created by Joey Hoer on 11/24/15.
//  Copyright © 2015 Joey Hoer. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSSquareStatusItemLength)
    let colorPanel = NSColorPanel.sharedColorPanel()
    let menu = NSMenu()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "Colors")
            button.action = Selector("pickColor:")


            // (Re)Declare Objective-C defined constants
            let NSLeftMouseDownMask  = 1 << 1
            let NSRightMouseDownMask = 1 << 3

            // Attach action to both left and right clicks
            button.sendActionOn(NSLeftMouseDownMask | NSRightMouseDownMask)

            // Display button as disabled
            //button.appearsDisabled = true

            // Do not hide color panel when application is switched
            colorPanel.hidesOnDeactivate = false

            // Do not highlight statu item when clicked
            statusItem.highlightMode = false

            // Set window level
            //colorPanel.level = Int(CGWindowLevelForKey(.NormalWindowLevelKey))

            // Setup menu items
            // Store application name
            let appName = NSBundle.mainBundle().infoDictionary?[kCFBundleNameKey as String] as? String
            // Setup "Quit" menu item
            menu.addItem(NSMenuItem(title: "Quit " + appName!, action: Selector("terminate:"), keyEquivalent: ""))

            // Set menu; will be shown when action is executed
            //statusItem.menu = menu

        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Nothing to do here
    }

    func pickColor(sender: NSMenuItem) {
        let flags = NSEvent.modifierFlags()

        if (flags == NSEventModifierFlags.AlternateKeyMask) {
            statusItem.highlightMode = true
            statusItem.popUpStatusItemMenu(menu)
            statusItem.highlightMode = false
        } else {
            // if (!colorPanel.visible) {

            // Focus application
            NSApplication.sharedApplication().activateIgnoringOtherApps(true)

            // Bring window to front
            colorPanel.makeKeyAndOrderFront(sender)

            // } else {
            //     // Close color panel
            //     colorPanel.close()
            // }
        }
    }

}
