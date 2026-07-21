--- Curves ---
hl.curve("fluid", {
  type = "bezier",
  points = {
    { 0.15, 0.85 },
    { 0.25, 1 }
  }
})

hl.curve("snappy", {
  type = "bezier",
  points = {
    { 0.3, 1 },
    { 0.4, 1 }
  }
})

hl.curve("overshot", {
  type = "bezier",
  points = {
    { 0.13, 0.99 },
    { 0.29, 1.05}
  }
})

--- Animations ---
hl.animation({
  enabled = true,
  leaf = "windows",
  speed = 4,
  bezier = "snappy",
  style = "popin 5%"
})

hl.animation({
  enabled = true,
  leaf = "windowsMove",
  speed = 4,
  bezier = "overshot",
  style = "popin 5%"
})


hl.animation({
  enabled = true,
  leaf = "windowsOut",
  speed = 2.5,
  bezier = "snappy",
})

hl.animation({
  enabled = true,
  leaf = "fade",
  speed = 4,
  bezier = "snappy",
})

hl.animation({
  enabled = true,
  leaf = "workspaces",
  speed = 4,
  bezier = "overshot",
  style = "slide"
})

hl.animation({
  enabled = true,
  leaf = "workspacesOut",
  speed = 4,
  bezier = "snappy",
  style = "slidefade"
})

hl.animation({
  enabled = true,
  leaf = "specialWorkspaceIn",
  speed = 4,
  bezier = "overshot",
  style = "slidefade bottom"
})

hl.animation({
  enabled = true,
  leaf = "specialWorkspaceOut",
  speed = 2,
  bezier = "snappy",
  style = "slide top"
})

hl.animation({
  enabled = true,
  leaf = "layersIn",
  speed = 1.6,
  bezier = "snappy",
  style = "slide bottom 70%"
})

hl.animation({
  enabled = true,
  leaf = "layersOut",
  speed = 0.8,
  bezier = "snappy",
  style = "fade"
})
