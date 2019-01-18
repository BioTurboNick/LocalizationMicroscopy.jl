"""
    DataEntity

Abstract type for an SMLM data entity that has an index, channel, and x/y/z coordinates.
"""
abstract type DataEntity
end

extractcoordinates(entity::T) where {T <: DataEntity} = [entity.x; entity.y; entity.z]
extractcoordinates(entities::Vector{<:DataEntity}) =
    length(entities) > 1 ? mapreduce(extractcoordinates, hcat, entities) : make2d(entities)

make2d(array1d::AbstractVector) = reshape(array1d, length(array1d), 1)

export DataEntity, extractcoordinates
