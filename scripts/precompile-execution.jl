using HTTP
using Sockets

function _socket(host::String, port::Integer)::Sockets.TCPServer
    return Sockets.listen(Sockets.InetAddr(parse(Sockets.IPAddr, host), port))
end

function get_home(req::HTTP.Request)
    return HTTP.Response(200, "hi")
end

function _router()
    r = HTTP.Router()
    HTTP.@register(r, "GET", "/", get_home)
    return r
end

host = "127.0.0.1"
port = 8010

@info "Starting async server"
server = _socket(host, port)
@async HTTP.serve(_router(), host, port; server)

sleep(2)
@info "Calling endpoint '/'"
response = HTTP.get("http://$host:$port/")
@info "Closing server"
close(server)
