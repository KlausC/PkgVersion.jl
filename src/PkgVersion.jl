module PkgVersion
import TOML

function project_data(m::Module, name, T, default)
    function _pkgdir(m::Module)
        @static if Base.VERSION < v"1.4"
            pf = Base.pathof(Base.moduleroot(m))
            pf === nothing ? nothing : abspath(pf, "..", "..")
        else
            pkgdir(m)
        end
    end
    pf = _pkgdir(m)
    pf === nothing && return T(default)
    pf = Base.env_project_file(pf)
    pf isa String || return T(default)
    project_data(pf, name, T, default)
end

function project_variable(pr::Dict, name, T, default)
    res = get(pr, string(name), default)
    res = res isa AbstractVector ? res[1] : res
    T(res)
end

function project_data(pf::AbstractString, name, T::Union{Type,Function}, default)
    pr = TOML.parsefile(pf)
    project_variable(pr, name, T, default)
end

macro Version(default=0)
    Version(__module__, default)
end
macro Uuid(default=0)
    project_data(__module__, :uuid, Base.UUID, default)
end
macro Author(default="unknown")
    project_data(__module__, "authors", string, default)
end

@static if isdefined(Base, :pkgversion) # Julia v1.9+
    Version(m::Module, default=0) = something(pkgversion(m), VersionNumber(default))
else
    Version(m::Module, default=0) = project_data(m, :version, VersionNumber, default)
end
Uuid(m::Module, default=0) = project_data(m, :uuid, Base.UUID, default)
Author(m::Module, default="unknown") = project_data(m, "authors", string, default)

const VERSION = PkgVersion.@Version

end # module
