# julia-webserver

An example Julia webserver configuration which can be hosted on services such as Render or Fly.io

This configuration works as follows.
Let's say that we create an app called `MyApp`.
The source code for the app is located in `src/MyApp.jl`.
To be able to run it quickly, we need to use [`PackageCompiler.jl`](https://github.com/JuliaLang/PackageCompiler.jl) to compile packages.
Otherwise, it might take 10 seconds or more for the server to start responding after a server restart which is not acceptable for a microservice.
The power of microservices is that they can quickly be restarted.
Okay, so how much do we compile?
We could choose to compile all dependencies, but that would mean that everything needs to be re-compiled once our app changes.
So, as a tradeoff, this example repository compiles only the dependencies of `MyApp`.
This should be quick enough for most cases.
As a side-note, to speed up the app itself once that is necessary, run the app's code when the module is loaded.
This will cause some of the `MyApp` code to be covered by the precompilation and can take about 50% from the running time.
See, also [`Makie.jl/src/precompiles.jl`](https://github.com/JuliaPlots/Makie.jl/blob/master/src/precompiles.jl).

Anyway, back to the code.
The `Dockerfile` shows how the docker is created.
The file creates the sysimage and configures a starting point to start the server.
Here, `build-sysimage.jl` will compile all direct dependencies of `MyApp` and run `scripts/precompile-execution.jl`.
In the execution file, a HTTP server is started and closed again.
Running such a simple server causes much of the [`HTTP.jl`](https://github.com/JuliaWeb/HTTP.jl) code to be compiled which greatly reduces the time to first response.

To deploy this code on [Render.com](https://render.com/), copy this repository and link it to your Render account.
After about 10 minutes of building a Docker container, Render will run this example server online.
You can then visit the site and see "hi".
Note that it may take a while before the server responds; I'm not paying for the server so they'll, understandably, shut it off after a while.

Instructions for [Fly.io](https://fly.io/) are similar.
