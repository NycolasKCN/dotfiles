local Workspace = {}

local containers = "ale-pessoa-db ale-pessoa-minio ale-pessoa-umami"
local webstorm = "$HOME/.local/bin/webstorm"
local intellij = "$HOME/.local/bin/idea1"

function Workspace.start()
  hl.exec_cmd("notify-send -u low \"Workspaces\" \"Starting 'Ale pessoa' dev workspace.\"")
  hl.exec_cmd("docker start " .. containers)

  hl.exec_cmd(webstorm .. " ~/projects/ayty/alePessoa/front-end", { workspace = "2 silent" })
  hl.exec_cmd(intellij .. " ~/projects/ayty/alePessoa/back-end", { workspace = "3 silent" })

  hl.exec_cmd([[notify-send -u low "Workspaces" "Open 'Ale pessoa' dev workspace concluded."]])
end

function Workspace.stop()
  hl.exec_cmd([[notify-send -u low "Workspaces" "Closing 'Ale pessoa' dev workspace."]])

  hl.exec_cmd("docker stop " .. containers)

  hl.exec_cmd([[pkill -f "webstorm"]])
  hl.exec_cmd([[pkill -f "idea"]])

  hl.exec_cmd([[notify-send -u low "Workspaces" "Workspace 'Ale pessoa' closed."]])
end

return Workspace
