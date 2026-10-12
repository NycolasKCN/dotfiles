import QtQuick
import QtQml

Item {
  id: wrapper
  property real margin: 4
  required default property Item child

  // Set the item's visual children list to just the passed item.
  children: [child]

  implicitWidth: child.implicitWidth + margin * 2
  implicitHeight: child.implicitHeight + margin * 2

  // Bind the child's position and size.
  // Note that this syntax is exclusive to the Binding type.
  Binding { wrapper.child.x: wrapper.margin }
  Binding { wrapper.child.y: wrapper.margin }
  Binding { wrapper.child.width: wrapper.width - wrapper.margin * 2 }
  Binding { wrapper.child.height: wrapper.height - wrapper.margin * 2 }
}
