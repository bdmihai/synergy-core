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
  name: "bonjour"
  type: "dynamiclibrary"
  targetName: "dnssd"

  // dependencies
  Depends { name: "cpp" }

  // cpp module configuration
  cpp.windowsApiCharacterSet: "mbcs"
  cpp.includePaths: [ "." ]
  cpp.defines: [ "USE_TCP_LOOPBACK", "NOT_HAVE_SA_LEN", "WIN32_LEAN_AND_MEAN" ]
  cpp.dynamicLibraries: [ "Ws2_32", "Advapi32" ]
  cpp.linkerFlags: ["/DEF:" + path + "/" + definitionFile.files[0]]
  cpp.cxxLanguageVersion: "c++14"

  // definition file
  Group {
    id: definitionFile
    name: "exports"
    files: "dnssd.def"
  }

  files: [
    "CommonServices.h",
    "DebugServices.c",
    "DebugServices.h",
    "dns_sd.h",
    "dnssd_clientlib.c",
    "dnssd_clientstub.c",
    "dnssd_ipc.c",
    "dnssd_ipc.h",
    "GenLinkedList.c",
    "GenLinkedList.h",
    "dllmain.c",
    "resource.h",
    "WinVersRes.h",
    "dll.rc"
  ]

  // properties for the produced files
  Group {
    qbs.install: true
    qbs.installDir: ""
    fileTagsFilter: product.type
  }

  Export {
    Depends { name: "cpp" }
    cpp.includePaths: [ product.sourceDirectory ]
  }
}
