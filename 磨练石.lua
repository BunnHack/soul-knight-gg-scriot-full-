function readPointer(name, offset, i)
	local re = gg.getRangesList(name)
	local x64 = gg.getTargetInfo().x64
	local va = {[true] = 32, [false] = 4}
	if re[i or 1] then
		local addr = re[i or 1].start + offset[1]
		for i = 2, #offset do
			addr = gg.getValues({{address = addr, flags = va[x64]}})
			if not x64 then
				addr[1].value = addr[1].value & 0xFFFFFFFF
			end
			addr = addr[1].value + offset[i]
		end
		return addr
	end
end

function gg.edits(addr, Table, name)
	local Table1 = {{}, {}}
	for k, v in ipairs(Table) do
		local value = {address = addr + v[3], value = v[1], flags = v[2], freeze = v[4]}
		if v[4] then
			Table1[2][#Table1[2] + 1] = value
		else
			Table1[1][#Table1[1] + 1] = value
		end
	end
	gg.addListItems(Table1[2])
	gg.setValues(Table1[1])
	gg.toast((name or "") .. "开启成功, 共修改" .. #Table .. "个值")
end





--libil2cpp.so + 0x305E10 -> 0xD8 -> 0x1F8 -> 0x308 -> 0x248 -> 0x14C
local addr = readPointer("libil2cpp.so", {3169808, 216, 504, 776, 584, 332}, 3)
gg.edits(addr, {{3000, 16, 0, true}})

--libil2cpp.so + 0x305E10 -> 0x98 -> 0x1F8 -> 0x308 -> 0x248 -> 0x14C
local addr = readPointer("libil2cpp.so", {3169808, 152, 504, 776, 584, 332}, 3)
gg.edits(addr, {{3000, 16, 0, true}})