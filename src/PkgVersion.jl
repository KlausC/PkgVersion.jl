module PkgVersion

function project_data(__source__, name, T::Type, default)
    _name = T(default)
    __source__.file === nothing && return _name
    _file = abspath(dirname(dirname(String(__source__.file))), "Project.toml")
    isfile(_file) && open(_file) do io
        while !eof(io)
            _line = readline(io)
            if startswith(_line, string(name, ' ', '='))
                _name = T(split(_line, '"')[2])
            end
        end
    end
    _name
end
macro Version(default=0); project_data(__source__, "version", VersionNumber, default); end
macro Uuid(default=0); project_data(__source__, "uuid", Base.UUID, default); end
macro Author(default=0); project_data(__source__, "authors", String, default); end

end # module
