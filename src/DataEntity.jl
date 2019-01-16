"""
    DataEntity

Abstract type for an SMLM data entity that has an index, channel, and x/y/z coordinates.
"""
abstract type DataEntity
end

extractcoordinates(entity::DataEntity) = [entity.x; entity.y; entity.z]
extractcoordinates(entities::Vector{DataEntity}) = hcat(extractcoordinates.(entities))

export DataEntity, extractcoordinates
