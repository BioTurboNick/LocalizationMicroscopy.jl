"""
    loadlocalizations(source, inputformat)

Load localizations with the given format from the path or stream provided.
"""
function loadlocalizations(source::Union{String, IO}, inputformat::InputFormat)
    if inputformat == nikonelementstext
        loadfrom_nikonelementstext(source)
    elseif inputformat == nikonelementsbinary
        error("Not implemented")
    end
end

using CSV
import Base.push!
function loadfrom_nikonelementstext(source::Union{String, IO})
    file = CSV.File(source, delim = '\t', normalizenames = true, types = Dict(1 => String))
    localizations = Vector{Localization}()
    i = 1
    for row ∈ file
        loc =  Localization(i, row.Channel_Name, row.Xwc, row.Ywc, row.Zwc,
            row.Lateral_Localization_Accuracy, row.Frame, row.Length)
        push!(localizations, loc)
        i += 1
    end
    localizations
end
