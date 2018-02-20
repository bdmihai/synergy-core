/* ────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│  COPYRIGHT (C) 2018 Mihai Baneu                                              │
│                                                                              │
│  Permission is hereby  granted,  free of charge,  to any person obtaining a  │
│  copy of this software and associated documentation files (the "Software"),  │
│  to deal in the Software without restriction,  including without limitation  │
│  the rights to  use, copy, modify, merge, publish, distribute,  sublicense,  │
│  and/or sell copies  of  the Software, and to permit  persons to  whom  the  │
│  Software is furnished to do so, subject to the following conditions:        │
│                                                                              │
│  The above  copyright notice  and this permission notice  shall be included  │
│  in all copies or substantial portions of the Software.                      │
│                                                                              │
│  THE SOFTWARE IS PROVIDED  "AS IS",  WITHOUT WARRANTY OF ANY KIND,  EXPRESS  │
│  OR   IMPLIED,   INCLUDING   BUT   NOT   LIMITED   TO   THE  WARRANTIES  OF  │
│  MERCHANTABILITY,  FITNESS FOR  A  PARTICULAR  PURPOSE AND NONINFRINGEMENT.  │
│  IN NO  EVENT SHALL  THE AUTHORS  OR  COPYRIGHT  HOLDERS  BE LIABLE FOR ANY  │
│  CLAIM, DAMAGES OR OTHER LIABILITY,  WHETHER IN AN ACTION OF CONTRACT, TORT  │
│  OR OTHERWISE, ARISING FROM,  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR   │
│  THE USE OR OTHER DEALINGS IN THE SOFTWARE.                                  │
│                                                                              │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Author: Mihai Baneu                             Last modified: 08.Feb.2017  │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────── */

import qbs

Product {
  name: "synergyc"
  type: "application"
  consoleApplication: true

  // dependencies
  Depends { name: "cpp" }
  Depends { name: "arch" }
  Depends { name: "base" }
  Depends { name: "client" }
  Depends { name: "common" }
  Depends { name: "core" }
  Depends { name: "ipc" }
  Depends { name: "io" }
  Depends { name: "mt" }
  Depends { name: "net" }
  Depends { name: "platform" }
  Depends { name: "openssl" }

  // cpp module configuration
  cpp.includePaths: [ ".", "../../lib" ]
  cpp.dynamicLibraries: [
      "Shell32",
      "User32",
      "Advapi32",
      "Wininet",
      "Shlwapi",
      "Wtsapi32",
      "Gdi32",
      "Ole32",
      "Userenv"
  ]
  cpp.cxxLanguageVersion: "c++14"
  
  files: [
    "*.cpp",
    "*.h"
  ]

  // properties for the produced files
  Group {
    qbs.install: true
    qbs.installDir: ""
    fileTagsFilter: product.type
  }
}
