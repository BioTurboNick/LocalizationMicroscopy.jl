"""
    Localization

A single point identified by SMLM.
"""
struct Localization <: DataEntity
    index::Int            # unique identifier within this dataset
    channel::String
    x::Float64
    y::Float64
    z::Float64
    accuracy::Float64     # computed lateral uncertainty based on detected photons
    frame::Int            # first frame observed
    length::Int           # number of adjacent frames observed over
end
