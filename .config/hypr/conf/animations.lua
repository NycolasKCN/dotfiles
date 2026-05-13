-- Curves
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

hl.animation({
  enabled = true,
  leaf = "windows",
  speed = 3,
  bezier = "fluid",
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
  speed = 1.7,
  bezier = "snappy",
  style = "slide"
})

hl.animation({
  enabled = true,
  leaf = "specialWorkspaceIn",
  speed = 4,
  bezier = "fluid",
  style = "slidefade bottom"
})

hl.animation({
  enabled = true,
  leaf = "specialWorkspaceOut",
  speed = 4,
  bezier = "fluid",
  style = "slidefade top"
})

hl.animation({
  enabled = true,
  leaf = "layers",
  speed = 1,
  bezier = "snappy",
  style = "popin 70%"
})
