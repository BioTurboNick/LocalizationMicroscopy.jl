@testset "Load Localizations" begin

    @testset "Nikon Text" begin
        expected = Localization[Localization(1,  "647",  8394.1,  7259.0, 0.0, 10.97216,    1,  1),
                                Localization(2,  "647", 22137.7, 13796.5, 0.0, 12.56947, 2114,  1),
                                Localization(3,  "647", 36718.1, 28336.0, 0.0, 13.24367, 3160,  1),
                                Localization(4,  "647", 13799.5, 26063.8, 0.0, 13.50408, 7444,  1),
                                Localization(5,  "647",  5691.9, 26318.1, 0.0,  8.73353, 11009, 2),
                                Localization(6,  "488",  7934.0, 10576.6, 0.0,  4.75511, 11011, 3),
                                Localization(7,  "488", 11612.8, 20987.3, 0.0, 12.5259,  11135, 1),
                                Localization(8,  "488", 12917.9, 19160.3, 0.0, 16.88895, 14050, 1),
                                Localization(9,  "488", 38189.6, 22873.5, 0.0, 14.11827, 18538, 1),
                                Localization(10, "488", 24023.7, 16153.2, 0.0,  9.34327, 22014, 2)]

        localizations = loadlocalizations("nikontestdata.bin.txt", nikonelementstext)

        @test all(expected .== localizations)
    end

end
