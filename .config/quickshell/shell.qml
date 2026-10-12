// shell.qml
import QtQuick
import Quickshell
import "./modules/bar"

Scope {
  id: shellRoot

  Loader {
    active: true
    
    sourceComponent: Bar {}
  }
  
}
