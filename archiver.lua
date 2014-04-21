--[[
Pure Lua archiver made by Andy73 a.k.a. viluon

Copyright 2014
version 0.4 BETA (5th public release)

usage: archiver <compress|extract|help> <file input path> <file output path>

@h@WIP
]]

local s="?"
local tArgs={...}
local t=nil
local tOrigin={} 
local tDictionaryA={ 
"@", 
"#", 
"$", 
"*", 
"&", 
"/", 
"~", 
"|", 
"!", 
"•", 
"√", 
"π", 
"÷", 
"×", 
"£", 
"¢", 
"€", 
"°", 
"_", 
"™", 
"®", 
"©", 
"¶", 
"^", } 
local tDictionaryB={ 
"á", 
"à", 
"â", 
"ä", 
"æ", 
"ã", 
"å", 
"ā", 
"ě", 
"é", 
"è", 
"ê", 
"ë", 
"ę", 
"ė", 
"ē", 
"ï", 
"î", 
"í", 
"ī", 
"ì", 
"į", 
"ò", 
"ô", 
"ö", 
"ó", 
"ō", 
"ø", 
"œ", 
"õ", 
"ů", 
"ú", 
"û", 
"ü", 
"ù", 
"ū", 
"ý", 
"ÿ", 

"ř", 
"ť", 
"ź", 
"ž", 
"ż", 
"š", 
"ß", 
"ś", 
"ď", 
"ć", 
"č", 
"ç", 
"ń", 
"ň", 
"ñ", 
"`", } 


local function help()
print("Pure Lua archiver by Andy a.k.a. viluon copyright 2014")
print("version 0.4a BETA")
print("")
print("Current dictionary size: "..s.." keywords")
print("") term.setBackgroundColor(colors.cyan)
print(string.rep("-",term.getSize())) term.setTextColor(colors.black)
print("FAQ: I am getting an error when accessing a file in ../ directory")
print("  Yes, that is a common problem, I am working on a fix now. Please use the current directory until I fix this (some weird behaviour in shell.resolve :( )") term.setBackgroundColor(colors.black);term.setTextColor(colors.white)
print("Please note:Beta versions can cause unexpected data changes. Andy is not responsible for any data corruption or removals caused by this program. Use at your own risk.")
end

local function usage()
print("Usage:")
print(" archiver <compress|extract|help> <file input path> <file output path>")
print("'compress','extract' or 'help' can be shortened to 'c','e' or '?'")
end

local function loadOrg() 
local iorg=0 
local org=fs.open(shell.resolve(".").."/org","r")
if org then
line=org.readLine()
while line do 
iorg=iorg+1 
table.insert(tOrigin,iorg,line) 
line=org.readLine()
--print(iorg)
end 
org:close()
s=iorg
else
error("Origin file doesn't exist (\"./org\").")
end
end

local function r(a,b)
t=string.gsub(t,a,b)
end

--COMPRESS
local function compress(...)
local args={...}--ARGS ARE SOLVED BEFORE!!!
local file=fs.open(shell.resolve(tostring(args[1])),"r")
print("FileSize original:"..fs.getSize(shell.resolve(tostring(args[1])))) --print("asd")
if file then t=file.readAll() else error("Can't open:Requested source file doesn't exist.") end
file:close()
local b=0
for a=1,#tDictionaryA do 
    for index=1,#tDictionaryB do 
     b=b+1 
     if b>#tOrigin then break end 
     
     r(tostring(tOrigin[b]),tostring(tDictionaryA[a])..tostring(tDictionaryB[index])) 
    end 
   end 

local target=fs.open(shell.resolve(tostring(args[2])),"w")
if not target then error("Can't write:Taget path is invalid. Check the help for more info.") end
target.write(t)
target:close()

print("FileSize comprimed:"..fs.getSize(shell.resolve(args[2])))
local one=tonumber(fs.getSize(shell.resolve(args[1])))/100
local size=fs.getSize(shell.resolve(args[2]))
local calc=tonumber(size/one)

--[[DEBUG
print("fs.getSize(...):"..fs.getSize(shell.resolve(tostring(args[1]))))
print("one:"..one)
print("size:"..size)
print("size/one:"..tonumber(size/one))
print("calc:"..calc)
--/DEBUG]]

print("comprimed by "..(100-tonumber(calc)).."%")
end

--EXTRACT
local function extract(...)
local args={...}--ARGS ARE SOLVED BEFORE!!!
local file=fs.open(shell.resolve(tostring(args[1])),"r") --print("asd")
if file then t=file.readAll() else error("Can't open:Requested source file doesn't exist.") end
file:close()

local b=0 
   for a=1,#tDictionaryA do 
    for index=1,#tDictionaryB do 
     b=b+1 
     if b>#tOrigin then break end 
     r(tostring(tDictionaryA[a])..tostring(tDictionaryB[index]),tostring(tOrigin[b])) 
    end 
   end 

local target=fs.open(shell.resolve(tostring(args[2])),"w")
if not target then error("Can't write:Taget path is invalid. Check the help for more info.") end
target.write(t)
target:close()

print("done!")
end

local function main()
if not fs.exists(shell.resolve(".").."/org") then
  pcall(function() print("Attempting to download origin file...") shell.run("pastebin","get","xj4ZABRH","org") end)
end
loadOrg()
if tostring(tArgs[1])=="compress" or tostring(tArgs[1])=="c" then
compress(tArgs[2],tArgs[3])
elseif tostring(tArgs[1])=="extract" or tostring(tArgs[1])=="e" then
extract(tArgs[2],tArgs[3])
elseif tostring(tArgs[1])=="help" or tostring(tArgs[1])=="?" then
help()
else
usage()
end
end
------------------------------------------------------------------------------------------------------------






main()

