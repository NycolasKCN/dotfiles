// shell.qml
import QtQuick
import Quickshell
import "./modules/bar"

ShellRoot {
  id: shellRoot

  Loader {
    active: true
    
    sourceComponent: Bar {}
  }
  
}
