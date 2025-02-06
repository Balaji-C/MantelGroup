// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import Foundation

public var isPreview: Bool {
#if DEBUG
    // For Previews only
    if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
        return true
    }
#endif
    return false
}
