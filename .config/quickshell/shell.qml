import QtQuick
import Quickshell
import "./modules/bar"

ShellRoot {
  id: shellRoot

  // Status Bar
  Loader {
    active: true
    sourceComponent: Bar {}
  }
  
}
