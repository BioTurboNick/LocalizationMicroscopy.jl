"""
    localizationsplot(localizations::Vector{Localizations}, color::Symbol)
    localizationsplot(localizations::Vector{Vector{Localization}}, colors::Vector{Symbol})

Plot localizations by spatial coordinates. Assumes that the y-coordinate is inverted. Defaults to 0-to-40960 on each
axis, but option may be specified using keyword arguments xlims=(x1, x2) and ylims=(y1, y2). Colors are specified in the
documentation for Plots.jl.
"""
plotlocalizations(locs::Vector{Localization}, color::Symbol; kargs...) =
    plotlocalizations([locs], [color]; kargs...)

function plotlocalizations(localizations::Vector{Vector{Localization}}, colors::Vector{Symbol};
    xlims=(0, 40960), ylims=(0,40960))

    channelcount = length(localizations)
    plot(framestyle=:none)
    for i ∈ 1:channelcount
        coords = localizations[i] |> extractcoordinates
        scatter!(coords[1,:], coords[2,:], marker=(1, stroke(0), 0.75, colors[i]))
    end
    plot!(aspect_ratio=:equal, xlims=xlims, yaxis=(ylims, :flip), legend=:none, grid=:hide, ticks=(0))
end
