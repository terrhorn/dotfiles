#!/bin/bash
# Set default applications for file types and URL schemes.
# run_onchange_ means chezmoi only re-runs this when the script contents change.

swift - <<'SWIFT'
import CoreServices

let vscodeInsiders = "com.microsoft.VSCodeInsiders" as CFString
let ghostty = "com.mitchellh.ghostty" as CFString

// --- VS Code Insiders: text/code files ---
let editorExtensions = [
    "conf", "css", "html", "js", "json", "jsx", "md",
    "nix", "rs", "sh", "toml", "ts", "tsx", "txt",
    "yaml", "yml",
]

for ext in editorExtensions {
    let uti = UTTypeCreatePreferredIdentifierForTag(
        kUTTagClassFilenameExtension, ext as CFString, nil
    )?.takeRetainedValue()
    if let uti = uti {
        LSSetDefaultRoleHandlerForContentType(uti, .all, vscodeInsiders)
    }
}

// --- Ghostty: terminal file types ---
let terminalExtensions = ["command", "tool"]

for ext in terminalExtensions {
    let uti = UTTypeCreatePreferredIdentifierForTag(
        kUTTagClassFilenameExtension, ext as CFString, nil
    )?.takeRetainedValue()
    if let uti = uti {
        LSSetDefaultRoleHandlerForContentType(uti, .all, ghostty)
    }
}

// --- Ghostty: URL schemes ---
LSSetDefaultHandlerForURLScheme("x-man-page" as CFString, ghostty)
SWIFT
