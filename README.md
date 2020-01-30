# PkgVersion.jl

[![Build Status](https://travis-ci.org/KlausC/PkgVersion.jl.svg?branch=master)](https://travis-ci.org/KlausC/PkgVersion.jl)
[![Codecov](https://codecov.io/gh/KlausC/PkgVersion.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/KlausC/PkgVersion.jl)

####Provide macros to access fields `version`, `uuid`, `authors` in `Project.toml
at compile time.

### Usage

```julia
module MyModule

using PkgVersion

const version = @PkgVersion.Version 0
const uuid = @PkgVersion.Uuid 
const author = @PkgVersion.Author "unknown@nowhere"

end
```

##### Note
File `@__DIR__/../Project.toml` must exist readable.
`Author` returns the first string in field `authors`.

