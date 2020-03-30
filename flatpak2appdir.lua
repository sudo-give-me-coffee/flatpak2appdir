#!/usr/bin/lua5.3


flatpak = {}

HERE=debug.getinfo(1).source:match("@?(.*/)")

function flatpak.runtime(name, version)
  local dirname = "/var/lib/flatpak/runtime/"
  runtime = dirname..name.."/x86_64/"..version.."/active/files/"
end

function flatpak.app(name)
  local dirname = "/var/lib/flatpak/app/"
  app = dirname..name.."/current/active/files/"
  
  appID=name
  
  for section in name:gmatch("%a+") do
    appName=section
  end
  
  local manifest = app.."manifest.json"
  for line in io.lines(manifest) do
    line = line:gsub("^%s*(.-)%s*$", "%1")
    if line:sub(2,9) == "runtime\"" then
      runtime_name=line:sub(14,-3)
    end
    if line:sub(2,17) == "runtime-version\"" then
      runtime_version=line:sub(22,-3)
    end
    if line:sub(2,9) == "command\"" then
      command=line:sub(14,-3)
    end
  end
  if runtime == nil then
    flatpak.runtime(runtime_name,runtime_version)
  end
  
  for line in io.lines(app.."../deploy") do
    line = line:gsub('%W',' '):gsub('appdata','\n')
    for _line in line:gmatch('[^\n]+') do
      if _line:sub(1,9) == " version " then
        _line = _line:gsub("^%s*(.-)%s*$", "%1")
        appVersion = _line:sub(9,-4):gsub(' ','.')
      end
    end
    break
  end
  
end

-----------------------------------------------------------------------

if #arg == 0 then
  print("Error: You must provide at least app id:\n")
  print("  flatpak2appdir [options] org.gnome.gedit\n")
  os.exit(1)
end

for i=1,#arg do
  if arg[i] == "-force-runtime" then
    flatpak.runtime(arg[i+1],arg[i+2])
    arg[i]   = nil
    arg[i+1] = nil
    arg[i+2] = nil
  end
  
  if arg[i] == "-helpers" then
    helpers = {}
    for bin in arg[i+1]:gmatch('[^,]+') do
      table.insert(helpers,bin)
    end
    arg[i]   = nil
    arg[i+1] = nil
  end
  
  if arg[i] == "-interpreter" then
    interpreter=arg[i+1]
    arg[i]   = nil
    arg[i+1] = nil
  end
  
  if not (arg[i] == nil) then
    flatpak.app(arg[i])
  end
end

-----------------------------------------------------------------------
print("--------------------------------------------\n")
print("         ID: "..appID)
print("       Name: "..appName)
print("    Version: "..appVersion)
print(" Executable: "..command)
print("    Runtime: "..runtime_name.."//"..runtime_version)
print("\n--------------------------------------------\n")

print("[ 1/5 ] Creating AppDir...")
os.execute("mkdir -p "..appName..".AppDir/app")
os.execute("mkdir -p "..appName..".AppDir/usr")

print("[ 2/5 ] Copying libunionpreload...")
os.execute("cp "..HERE.."/libunionpreload.so "..appName..".AppDir/")

print("[ 3/5 ] Copying tracefile...")
os.execute("cp "..HERE.."/tracefile "..appName..".AppDir/")
os.execute("chmod +x "..appName..".AppDir/tracefile")

print("[ 4/5 ] Copying AppRun...")
os.execute("cp "..HERE.."/AppRun "..appName..".AppDir/")
os.execute("chmod +x "..appName..".AppDir/AppRun")

local commandFile = io.open(appName..".AppDir/command", 'w')
commandFile:write(command)
commandFile:close()

if not (interpreter==nil) then
  local interpreterFile = io.open(appName..".AppDir/interpreter", 'w')
  interpreterFile:write(interpreter)
  interpreterFile:close()
end

os.execute("bindfs --no-allow-other "..app.." "..appName..".AppDir/app")
os.execute("bindfs --no-allow-other "..runtime.." "..appName..".AppDir/usr")

os.execute(appName..".AppDir/AppRun")

print("[ 5/5 ] Copying acessed files...")
os.execute("bash "..appName..".AppDir/used_files.sh")

os.execute("fusermount -zu "..appName..".AppDir/app")
os.execute("fusermount -zu "..appName..".AppDir/usr")
os.execute("bash "..appName..".AppDir/move_files.sh")
