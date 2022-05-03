module MyApp

export serve

using HTTP:
    HTTP,
    Response,
    Request
using Sockets:
    Sockets,
    @ip_str

function get_home(req::Request)
    return Response(200, "hi")
end

function _router()
    r = HTTP.Router()
    HTTP.@register(r, "GET", "/", get_home)
    return r
end

function serve(host::String=ip"127.0.0.1", port::Int=8080)
    @info "Starting server at http://$host:$port"
    HTTP.serve(_router(), host, port)
end

end # module
