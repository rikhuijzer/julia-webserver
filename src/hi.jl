prefix_zero(x) = x < 10 ? "0$x" : string(x)

function now_pretty()
    day = today()
    dt = now()
    h = prefix_zero(hour(dt))
    m = prefix_zero(minute(dt))
    s = prefix_zero(second(dt))
    return "$day $h:$m:$s"
end

hi() = """
    <!doctype html>
    <html>
    <head>
        <title>Example Server</title>

        <meta charset="utf-8" />
        <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel=icon  href="https://julialang.org/assets/infra/julia.ico">

        <style type="text/css">
        body {
            background-color: #f0f0f2;
            margin: 0;
            padding: 0;
            font-family: -apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", "Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }
        div {
            width: 600px;
            margin: 5em auto;
            padding: 2em;
            background-color: #fdfdff;
            border-radius: 0.5em;
            box-shadow: 2px 3px 7px 2px rgba(0,0,0,0.02);
        }
        a:link, a:visited {
            color: #38488f;
            text-decoration: none;
        }
        @media (max-width: 700px) {
            div {
                margin: 0 auto;
                width: auto;
            }
        }
        </style>
    </head>

    <body>
    <div>
        <h1>Hi</h1>
        <p>This is a response from a <a href="https://julialang.org">Julia</a>-powered webserver.</p>
        <p>On the server, it is currently $(now_pretty()).</p>

        <p>
            <a href="https://github.com/rikhuijzer/julia-webserver">
                Click here for the code
            </a>
        </p>
    </div>
    </body>
    </html>
    """
