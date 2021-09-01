"""
    loadlocalizations(source, inputformat)

Load localizations with the given format from the path or stream provided.
"""
function loadlocalizations(source::Union{String, IO}, inputformat::InputFormat)
    if inputformat == nikonelementstext
        loadfrom_nikonelementstext(source)
    elseif inputformat == nikonelementsbinary
        loadfrom_nikonelementsbinary(source)
    end
end

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

#=
function loadfrom_nikonelementsbinary(source::Union{String, IO})
    file = CSV.File(source, delim = '\t', normalizenames = true, types = Dict(1 => String))
    
    open(source) do f
        skip(f, 69) # 69-byte header
        nlocalizations = read(f, Int32)
        A = Matrix{Float32}(undef, 18, nlocalizations)
        A = read!(f, A) # table of 18 columns containing floating point values

        [Localization(i, "1", col[3], col[4], col[18],) (i, col) ∈ enumerate(eachrow(A))]
    end
    localizations
end


From MATLAB
mol.x = A(1:18:end);
mol.y = A(2:18:end);
mol.xc = A(3:18:end);
mol.yc = A(4:18:end);
mol.h = A(5:18:end);
mol.area = A(6:18:end);
mol.width = A(7:18:end);
mol.phi = A(8:18:end);
mol.Ax = A(9:18:end);
mol.bg = A(10:18:end);
mol.I = A(11:18:end);
mol.cat = floor(A(12:18:end)/1.401e-45); ==> reinterpret(Int32, A[12,:])
mol.valid = floor(A(13:18:end)/1.401e-45);
mol.frame = floor(A(14:18:end)/1.401e-45);
mol.length = floor(A(15:18:end)/1.401e-45);
mol.link = floor(A(16:18:end)/1.401e-45);
mol.z = A(17:18:num*18);
mol.zc = A(18:18:num*18);

# where is xwc, ywc, zwc? Channel name? Lateral Localization Accuracy?
# I believe these may all be calculated values that Elements populates when saving a text file
# LLA is calculated by a formula which I could reproduce here, but the warp corrections
# would be stored in the microscope. So... maybe I don't want to read Nikon binary files?

=#