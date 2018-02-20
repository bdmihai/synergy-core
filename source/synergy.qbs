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
│  Author: Mihai Baneu                             Last modified: 11.Feb.2017  │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────── */

import qbs
import qbs.TextFile

Project {
  name: "synergy"
  minimumQbsVersion: "1.8"
  property string synergyVersion: manifest.version
  property string synergyVersionStage: manifest.stage
  property string synergyVersionRevision: manifest.revision

  Probe {
      id: manifest
      property string manifestPath: sourceDirectory
      property string revision
      property string stage
      property string version: "na"
      configure: {
        var textFile = new TextFile(manifestPath + "/../manifest.uuid", TextFile.ReadOnly);
        revision = textFile.readLine().substring(0, 10);
        textFile.close();
        textFile = new TextFile(manifestPath + "/../manifest.tags", TextFile.ReadOnly);
        while (!textFile.atEof()) {
          var splitted = textFile.readLine().split(" ");
          if (splitted[0] == "branch") {
            stage = splitted[1];
          }
          if (splitted[0] == "tag") {
            var n = splitted[1].search("version_\\d+\\.\\d+\\.\\d+");
            if (n >= 0) {
              version = splitted[1].substring(8);
              console.info(version);
            }
          }
        }
        textFile.close();
        found = true;
      }
  }

  references: [
    "../libs/external-libs.qbs",
    "lib/lib.qbs",
    "gui/gui.qbs",
    "cmd/cmd.qbs"
  ]
}
