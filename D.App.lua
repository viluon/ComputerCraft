--[[ 
Dictionary app for AndyCode archiver 

@h@COMPUTERCRAFT VERSION


note:add those l00ps! 
note:check letter 'printability' 

17/1219 
]] 
--[[d=fs.open(shell.resolve(".").."/asd","w") 
d:write("") 
d:close() ]]
local function addCom(txt,tr) 
out=fs.open(shell.resolve(".").."/asd","w") 
out.writeLine("r(\""..tr.."\",\""..txt.."\")") 
out:close() 
end 
local function addExt(tr,txt) 
out=fs.open(shell.resolve(".").."/asd","a") 
out.writeLine("r(\""..txt.."\",\""..tr.."\")") 
out:close() 
end 

local tOrigin={} 
local iorg=0 
org=fs.open(shell.resolve(".").."/org","r")
if org then
line=org.readLine()
while line do 
iorg=iorg+1 
table.insert(tOrigin,iorg,line) 
line=org.readLine()
print(iorg)
end 
org:close()
else
error("Origin file doesn't exist.")
end

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
local function main() 
 local b=0 
 local count=0 
 for a=1,#tDictionaryA do 
  for index=1,#tDictionaryB do 
   b=b+1 
   if b>#tOrigin then break end 
   count=count+1 
   addCom(tostring(tOrigin[b]),tostring(tDictionaryA[a])..tostring(tDictionaryB[index])) 
  end 
 end 
 b=0 
 for a=1,#tDictionaryA do 
  for index=1,#tDictionaryB do 
   b=b+1 
   if b>#tOrigin then break end 
   addExt(tostring(tOrigin[b]),tostring(tDictionaryA[a])..tostring(tDictionaryB[index])) 
  end 
 end 
 term.setTextColor(colors.green)
 print("Repeated "..count.." times.")
 print(tostring(tOrigin[10])) 
end 
--[[ 
"", 
"", 
"", 
"", 

]] 
main()