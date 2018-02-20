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
  name: "gui"
  type: "application"
  targetName: "synergy"
  consoleApplication: false

  // dependencies
  Depends { name: "cpp" }
  Depends { name: "Qt.core" }
  Depends { name: "Qt.network" }
  Depends { name: "Qt.widgets" }
  Depends { name: "bonjour" }

  // cpp module configuration
  cpp.defines: [ "SYNERGY_VERSION=\"" + synergyVersion + "\"", "VERSION_STAGE=\"" + synergyVersionStage + "\"", "VERSION_REVISION=\"" + synergyVersionRevision + "\"" ]
  cpp.includePaths: [ ".", "src", "../lib/shared" ]
  cpp.dynamicLibraries: [ "Advapi32" ]
  cpp.cxxLanguageVersion: "c++14"
  
  // install group for the configuration files
  Group {
    name: "resources"
    files: [ "res/win/Synergy.rc" ]
  }

  files: [
    "src/*.cpp",
    "src/*.h",
    "res/*.ui",
    "res/Synergy.qrc"
  ]

  // properties for the produced files
  Group {
    qbs.install: true
    qbs.installDir: ""
    fileTagsFilter: product.type
  }
}
