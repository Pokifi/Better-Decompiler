local Utils = {}
function Utils.SplitLines(text)
    local lines = {}
    for line in string.gmatch(text, "[^\r\n]+") do
        lines[#lines+1] = line
    end
    return lines
end
function Utils.JoinLines(lines)
    return table.concat(lines, "\n")
end
function Utils.Trim(str)
    return str:match("^%s*(.-)%s*$")
end
function Utils.SafeCall(fn, ...)
    local ok, result = pcall(fn, ...)
    if ok then
        return result
    end
    return nil
end
function Utils.TableCopy(t)
    local copy = {}
    for k, v in pairs(t) do
        copy[k] = v
    end
    return copy
end
function Utils.TableMerge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
    return t1
end
function Utils.StringReplace(str, old, new)
    return str:gsub(old, new)
end
function Utils.CountOccurrences(str, pattern)
    local count = 0
    for _ in string.gmatch(str, pattern) do
        count = count + 1
    end
    return count
end
function Utils.RemoveDuplicates(lines)
    local seen = {}
    local result = {}
    for _, line in ipairs(lines) do
        if not seen[line] then
            seen[line] = true
            result[#result+1] = line
        end
    end
    return result
end
function Utils.GetLineCount(str)
    return #Utils.SplitLines(str)
end
function Utils.GetWordCount(str)
    return #string.gmatch(str, "%S+")()
end
function Utils.IsEmpty(str)
    return Utils.Trim(str) == ""
end
function Utils.FilterLines(lines, predicate)
    local filtered = {}
    for _, line in ipairs(lines) do
        if predicate(line) then
            filtered[#filtered+1] = line
        end
    end
    return filtered
end
function Utils.MapLines(lines, mapper)
    local mapped = {}
    for i, line in ipairs(lines) do
        mapped[i] = mapper(line)
    end
    return mapped
end
function Utils.ReverseLines(lines)
    local reversed = {}
    for i = #lines, 1, -1 do
        reversed[#reversed+1] = lines[i]
    end
    return reversed
end
function Utils.RemoveEmptyLines(lines)
    local result = {}
    for _, line in ipairs(lines) do
        if line ~= "" then
            result[#result+1] = line
        end
    end
    return result
end
function Utils.PadLines(lines, pad)
    local result = {}
    for _, line in ipairs(lines) do
        result[#result+1] = pad .. line
    end
    return result
end
function Utils.CountKeywords(lines)
    local count = 0
    for _, line in ipairs(lines) do
        if line:match("local") or line:match("function") then
            count = count + 1
        end
    end
    return count
end
return Utils