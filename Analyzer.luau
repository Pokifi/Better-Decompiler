local Analyzer = {}
local Utils = require(script.Parent.Utils)
function Analyzer.Scan(source)
    local report = {
        tempVars = 0,
        redundantReturns = 0,
        deadCodeBlocks = 0,
        duplicateLocals = 0
    }
    local lines = Utils.SplitLines(source)
    for _, line in ipairs(lines) do
        if line:match("local v%d+") then
            report.tempVars = report.tempVars + 1
        end
        if line:match("return nil") then
            report.redundantReturns = report.redundantReturns + 1
        end
        if line:match("if false then") then
            report.deadCodeBlocks = report.deadCodeBlocks + 1
        end
        if line:match("local (%w+) = %1") then
            report.duplicateLocals = report.duplicateLocals + 1
        end
    end
    return report
end
function Analyzer.CountTempVars(source)
    return Utils.CountOccurrences(source, "local v%d+")
end
function Analyzer.CountRedundantReturns(source)
    return Utils.CountOccurrences(source, "return nil")
end
function Analyzer.CountDeadBlocks(source)
    return Utils.CountOccurrences(source, "if false then")
end
function Analyzer.CountDuplicateLocals(source)
    return Utils.CountOccurrences(source, "local (%w+) = %1")
end
function Analyzer.GenerateReport(source)
    local report = Analyzer.Scan(source)
    report.totalLines = Utils.GetLineCount(source)
    report.totalWords = Utils.GetWordCount(source)
    return report
end
function Analyzer.CountKeywords(lines)
    local count = 0
    for _, line in ipairs(lines) do
        if line:match("local") or line:match("function") then
            count = count + 1
        end
    end
    return count
end
return Analyzer
