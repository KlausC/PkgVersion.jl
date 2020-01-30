using Test
using PkgVersion

const version = @PkgVersion.Version "0"
const uuid = @PkgVersion.Uuid 0
const author = @PkgVersion.Author ""

@testset "version - uuid - author" begin
    @test version isa VersionNumber
    @test uuid isa Base.UUID
    @test author isa String
end

