"""
    localizationsplot(localizations::Vector{Localizations}, color::Symbol)
    localizationsplot(localizations::Vector{Vector{Localization}}, colors::Vector{Symbol})

Plot localizations by spatial coordinates. Assumes that the y-coordinate is inverted. Defaults to 0-to-40960 on each
axis, but option may be specified using keyword arguments xlims=(x1, x2) and ylims=(y1, y2). Colors are specified in the
documentation for Plots.jl. Can tune opacity with opacity= keword argument. factor= can be tuned for display in the pane
or for saving and printing (recommended 4, default 1).
"""
plotlocalizations(locs::Vector{Localization}, color::Symbol; kargs...) =
    plotlocalizations([locs], [color]; kargs...)

function plotlocalizations(localizations::Vector{Vector{Localization}}, colors::Vector{Symbol};
    xlims=(0, 40960), ylims=(0,40960), opacity=0.75, factor=1)

    channelcount = length(localizations)
    plot(framestyle=:none, size=((1024,1024) .* factor))
    for i ∈ 1:channelcount
        coords = localizations[i] |> extractcoordinates
        scatter!(coords[1,:], coords[2,:], marker=(1 * factor, stroke(0), opacity, colors[i]))
    end
    plot!(aspect_ratio=:equal, xlims=xlims, yaxis=(ylims, :flip), legend=:none, grid=:hide, ticks=(0))
end
