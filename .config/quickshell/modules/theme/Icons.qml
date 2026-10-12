pragma Singleton
import QtQuick

QtObject {
  readonly property var workspaces: ({
    "1":  "一",
    "2":  "二",
    "3":  "三",
    "4":  "四",
    "5":  "五",
    "6":  "六",
    "7":  "七",
    "8":  "八",
    "9":  "九",
    "10": "十",

    "special:notes":    "\udb83\udebf",
    "special:music":    "\uf001",
    "special:terminal": "\uf489",
    "special:magic":    "\uf044",
    "special:magic2":   "\uf044"
  })

  function workspace(name, fallback) {
    return workspaces[name] ?? fallback
  }
}
