#!/bin/bash
# Set default applications for file types and URL schemes.
# run_onchange_ means chezmoi only re-runs this when the script contents change.

swift - <<'SWIFT'
import Foundation
import UniformTypeIdentifiers

let vscodeInsiders = "com.microsoft.VSCodeInsiders" as NSString as CFString
let ghostty = "com.mitchellh.ghostty" as NSString as CFString

// --- VS Code Insiders: text/code files ---
let editorExtensions = [
    "conf", "css", "html", "js", "json", "jsx", "md",
    "nix", "rs", "sh", "toml", "ts", "tsx", "txt",
    "yaml", "yml",
]

for ext in editorExtensions {
    if let uttype = UTType(filenameExtension: ext) {
        LSSetDefaultRoleHandlerForContentType(
            uttype.identifier as NSString as CFString, .all, vscodeInsiders
        )
    }
}

// --- Ghostty: terminal file types ---
let terminalExtensions = ["command", "tool"]

for ext in terminalExtensions {
    if let uttype = UTType(filenameExtension: ext) {
        LSSetDefaultRoleHandlerForContentType(
            uttype.identifier as NSString as CFString, .all, ghostty
        )
    }
}

// --- Ghostty: URL schemes ---
LSSetDefaultHandlerForURLScheme("x-man-page" as NSString as CFString, ghostty)
SWIFT
