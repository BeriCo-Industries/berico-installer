local io = require("io")
local fs = require("filesystem")
local term = require("term")
local serialization = require("serialization")
local gpu = require("component").gpu

--Installer info
local name = "BeriCo Industries Installer"
local version = "v1.0"
local build = "30897"


--Vars
local input
local branch
local webPath = "https://raw.githubusercontent.com/BeriCo-Industries/berico-installer/main"
local _,y = gpu.getResolution()

--functions

function clear()
  term.clear()
  gpu.set(1,1,name.." "..version.."_"..build)
  gpu.set(1,y,"Type 'quit' to exit installer")
end

function install(inp)

  local progFile = assert(io.open("/usr/bc_program.list"))
  progFile = serialization.unserialize(progFile:read("*all"))
  clear()
  term.setCursor(1,3)
  files = progFile[inp].files

  for k,v in pairs(files) do

    --os.execute("wget -fq '"..webPath.."/"..branch.."/"..v.."'")
    print("Downloading...  "..v)

  end
end

--pre init
clear()

--init

--branch selection
gpu.set(1,3,"-- Choose a branch --")
gpu.set(1,4,"[1] Dev")
gpu.set(1,5,"[2] Master")
gpu.set(1,7,"INPUT: ")
term.setCursor(8,7)
input = io.read()

input = tostring(input)

if input == "1" then--dev branch

  branch = "dev"
  local yPos = 4

  clear()
  gpu.set(1,3,"-> Downloading bc_program.list")
  term.setCursor(1,4)
  --os.execute("wget -f '"..webPath.."/"..branch.."/usr/bc_program.list' /usr/bc_program.list ")
  os.sleep(1.5)

  local progFile = assert(io.open("/usr/bc_program.list"))
  progFile = serialization.unserialize(progFile:read("*all"))

  clear()
  gpu.set(1,3,"-- Choose a Program/Library --")
  gpu.set(1,4,"!!! CAUTION THE DEV BRANCH MAY BE UNSTABLE !!!")--disclaimer
  for k,v in pairs(progFile) do
    gpu.set(1,yPos+v.pos,"["..v.pos.."] "..v.name)
  end
  term.setCursor(8,y-1)
  gpu.set(1,y-1,"INPUT: ")
  input = io.read()

  if input == "quit" or input == "" then
    term.clear()
    return false
  end
  input = tonumber(input)

  install(input)

  print("-> Download complete.")
  os.sleep(1)

elseif input == "2" then--master branch

  branch = "main"
  local yPos = 3

  clear()
  gpu.set(1,3,"-> Downloading bc_program.list")
  term.setCursor(1,4)
  --os.execute("wget -f '"..webPath.."/"..branch.."/usr/bc_program.list' /usr/bc_program.list ")
  os.sleep(1.5)

  local progFile = assert(io.open("/usr/bc_program.list"))
  progFile = serialization.unserialize(progFile:read("*all"))

  clear()
  gpu.set(1,3,"-- Choose a Program/Library --")
  for k,v in pairs(progFile) do
    gpu.set(1,yPos+v.pos,"["..v.pos.."] "..v.name)
  end
  term.setCursor(8,y-1)
  gpu.set(1,y-1,"INPUT: ")
  input = io.read()

  if input == "quit" or input == "" then
    term.clear()
    return false
  end
  input = tonumber(input)

  install(input)

  print("-> Download complete.")
  os.sleep(1)

elseif input == "quit" or input == "" then
  term.clear()
  return false
end

--exit
term.clear()

