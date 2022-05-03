using PackageCompiler:
    create_sysimage,
    default_app_cpu_target
using Pkg: dependencies

function direct_dependencies()
    deps = dependencies()
    package_infos = [last(pair) for pair in deps]
    filter!(p -> p.is_direct_dep, package_infos)
    return [p.name for p in package_infos]
end

packages = direct_dependencies()

project = "."

sysimage_path = joinpath(project, "img.so")
cpu_target = default_app_cpu_target()
precompile_execution_file = joinpath(project, "scripts/precompile-execution.jl")

@time create_sysimage(packages; project, sysimage_path, cpu_target, precompile_execution_file)
