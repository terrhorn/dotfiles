#!/bin/bash
# Set VS Code Insiders as the default editor for common text/code file types.
# run_onchange_ means chezmoi only re-runs this when the script contents change.

swift - <<'SWIFT'
import CoreServices

let vscodeInsiders = "com.microsoft.VSCodeInsiders" as CFString
let extensions = [
    "conf", "css", "html", "js", "json", "jsx", "md",
    "nix", "rs", "sh", "toml", "ts", "tsx", "txt",
    "yaml", "yml",
]

for ext in extensions {
    let uti = UTTypeCreatePreferredIdentifierForTag(
        kUTTagClassFilenameExtension, ext as CFString, nil
    )?.takeRetainedValue()
    if let uti = uti {
        LSSetDefaultRoleHandlerForContentType(uti, .all, vscodeInsiders)
    }
}
SWIFT
