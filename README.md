# Timeout

[![Build Status](https://travis-ci.org/goropikari/Timeout.jl.svg?branch=master)](https://travis-ci.org/goropikari/Timeout.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/goropikari/Timeout.jl?svg=true)](https://ci.appveyor.com/project/goropikari/Timeout-jl)
[![Codecov](https://codecov.io/gh/goropikari/Timeout.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/goropikari/Timeout.jl)


Implement the timeout feature in a funciton.

# Installation
```
using Pkg
Pkg.pkg"add https://github.com/goropikari/Timeout.jl.git"
```


# Example
```julia
julia> function f(n)
           sleep(n)
           return :ok
       end
f (generic function with 1 method)

julia> limit = 3
3

julia> @time timeout(()->f(2), limit)()
  2.054879 seconds (49.36 k allocations: 2.393 MiB)
:ok

julia> @time timeout(()->f(5), limit)()
ERROR: TimeoutException()
Stacktrace:
...
```
