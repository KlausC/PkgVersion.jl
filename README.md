# PkgVersion.jl

[![Build Status](https://travis-ci.org/KlausC/PkgVersion.jl.svg?branch=master)](https://travis-ci.org/KlausC/PkgVersion.jl)
[![Codecov](https://codecov.io/gh/KlausC/PkgVersion.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/KlausC/PkgVersion.jl)

#### Provide macros to access fields `version`, `uuid`, `authors` in `Project.toml
at compile time.

### Usage

```julia
module MyModule
using Tar
using PkgVersion

const VERSION = @PkgVersion.Version 0
const UUID = @PkgVersion.Uuid 
const AUTHOR = @PkgVersion.Author "unknown@nowhere"


const TarVersion = PkgVersion.Version(Tar)  

end
```

##### Notes
File `Project.toml` must exist readable.

`Author` returns the first string of field `authors`.

