"""
    DataEntity

Abstract type for an SMLM data entity that has an index, channel, and x/y/z coordinates.
"""
abstract type DataEntity
end

extractcoordinates(entity::DataEntity) = [entity.x; entity.y; entity.z]
extractcoordinates(entities::Vector{<:DataEntity}) =
    mapreduce(extractcoordinates, hcat, entities) |> (length(entities) > 1 ? identity : make2d)
make2d(array1d::AbstractVector) = reshape(array1d, length(array1d), 1)
