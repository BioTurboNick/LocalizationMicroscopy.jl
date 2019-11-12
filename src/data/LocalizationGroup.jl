"""
    LocalizationGroup

A set of [`Localization`](@ref)s determined to be associated together and treated as a single entity.
"""
mutable struct LocalizationGroup <: DataEntity
    index::Int            # unique identifier within this dataset
    channel::String
    x::Float64
    y::Float64
    z::Float64
    localizations::Vector{Localization}


    LocalizationGroup(localization::Localization) =
        new(localization.index, localization.channel, localization.x, localization.y, localization.z, [localization])
end

import Base.push!
function push!(group::LocalizationGroup, newlocalization::Localization...)
    push!(group.localizations, newlocalization...)
    calcposition!(group)
end

import Base.append!
function append!(group::LocalizationGroup, newlocalizations::Vector{Localization})
    append!(group.localizations, newlocalizations)
    calcposition!(group)
end

append!(group::LocalizationGroup, othergroup::LocalizationGroup) =
    append!(group, othergroup.localizations)

function calcposition!(group::LocalizationGroup)
    count = length(group.localizations)
    group.x = sum(l -> l.x, group.localizations) / count
    group.y = sum(l -> l.y, group.localizations) / count
    group.z = sum(l -> l.z, group.localizations) / count
    return group
end
