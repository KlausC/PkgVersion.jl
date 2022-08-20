module PkgVersion
using Pkg

if Base.VERSION < v"1.4"
    function pkgdir(m::Module)
        pf = Base.pathof(m)
        pf = pf === nothing ? "." : pf
        abspath(pf, "..", "..")
    end
end

function project_data(m::Module, name, T, default)
    sname = Symbol(name)
    if isconst(m, sname)
        T(getfield(m, sname))
    else
        pf = pkgdir(m)
        pf === nothing && return T(default)
        pf = Pkg.Types.projectfile_path(pf)
        project_data(pf, name, T, default)
    end
end
function project_data(pf::AbstractString, name, T::Union{Type,Function}, default)
    pf === nothing && return T(default)
    pr = Pkg.Operations.read_project(pf)
    if Symbol(name) ∈ fieldnames(typeof(pr))
        res = getfield(pr, Symbol(name))
        res === nothing ? T(default) : res
    else
        res = get(() -> T(default), pr.other, string(name))
        res isa AbstractVector ? res[1] : res
    end
end
macro Version(default=0)
    project_data(__module__, :version, VersionNumber, default)
end
macro Uuid(default=0)
    project_data(__module__, :uuid, Base.UUID, default)
end
macro Author(default="unknown")
    project_data(__module__, "authors", string, default)
end

Version(m::Module, default=0) = project_data(m, :version, VersionNumber, default)
Uuid(m::Module, default=0) = project_data(m, :uuid, Base.UUID, default)
Author(m::Module, default="unknown") = project_data(m, "authors", string, default)

const VERSION = PkgVersion.@Version

end # module
