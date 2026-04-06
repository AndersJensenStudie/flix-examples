mod Server {
    use Net.{TcpAccept, TcpServer, TcpSocket, Ipv4Addr, IpAddr, TcpBind}
    use Fs.FileRead

    pub def connect(ip: IpAddr, port: Int16): TcpServer \ Abort + TcpBind + Logger = 
        let sRes = TcpBind.bind(ip, port);
        match sRes {
            case Err(e) => Abort.abort(RichString.text("Something went wrong while connecting to ${ip}:${port}: ${e}"))
            case Ok(s) => Logger.info("Succesfully connected to ${ip}:${port}"); s
        }

    pub def serveWithRoutes(s: TcpServer, prefix: String, routes: Map[String, String]): Unit \ {IO, TcpAccept, Abort, FileRead, Logger} = 
        let conRes = TcpAccept.accept(s);
        let socket = match conRes {
            case Err(e) => Abort.abort(RichString.text("Something went wrong while accepting connection: ${e}"))
            case Ok(t) => t
        };
        let req = read(socket);
        Logger.trace(req);
        let headers = parseRequest(req);
        //Logger.debug("Got request with headers: ${headers}"); // works weird for some reason??
        Map.forEach(k -> v -> Logger.trace("[HEADER] ${k} => ${v}"), headers);
        let route = "${Option.getOrAbort(Map.get("route", headers))}";
        Logger.trace("Route: ${route}");
        let file = Option.getWithDefault(route, Map.get(route, routes));
        Logger.trace("File: ${file}");
        send(socket, "${prefix}${file}");
        serveWithRoutes(s, prefix, routes)

    pub def serve(s: TcpServer, prefix: String): Unit \ {IO, TcpAccept, Abort, FileRead, Logger} = 
        serveWithRoutes(s, prefix, Map.insert("/", "/index.html", Map.empty()))

    def send(socket: TcpSocket, file: String): Unit \ {FileRead, IO, Abort, Logger} = 
        region rc {
            Logger.debug("Reading file: ${file}");
            let readRes = FileRead.readBytes(file);
            let st = match readRes {
                case Err(e) => Logger.warn("Something went wrong reading ${file}: ${e}"); Vector.empty()
                case Ok(x) => x
            };
            let body = Vector.toArray(rc, st);
            let pre = toIntArray(getHTTPPreamble(Array.length(body), findExtension(file)), rc);
            let res = TcpSocket.write(Array.append(rc, pre, body), socket);
            match res {
                case Err(e) => Abort.abort(RichString.text("Something went while writing: ${e}"))
                case Ok(_) => ()
            };
            Logger.debug("Sent ${file}")
        }

    def _read(socket: TcpSocket): String \ {IO, Abort, Logger} = 
        region rc {
            let buf = Array.empty(rc, 2048);
            Logger.debug("Reading from buffer");
            let readK = Result.getOrAbort(TcpSocket.read(buf, socket));
            let readArr = Array.slice(rc, start = 0, end = readK + 1, buf);
            String.fromBytes(Array.toVector(readArr))
        }

    pub def read(socket: TcpSocket): String \ {IO, Abort, Logger} = 
        region rc {
            Logger.debug("Reading from buffer");
            let reader = BufReader.withCapacity(rc, 2048, socket);
            let res = Result.getOrAbort(Peekable.readWhile(c -> c != 10i8, reader));
            String.fromBytes(res)
        }
        
    def parseRequest(req: String): Map[String, String] \ {} =
        req |>
        String.splitOn(substr = " ") |> 
        List.zip(List#{"request_type", "route", "http_version"}) |> 
        List.foldLeft(m -> s -> Map.insert(fst(s), snd(s), m), Map.empty())

    def findExtension(s: String): ContentType = 
        def rec(ls: List[String]): String = {
            match ls {
                case ext :: Nil => ext
                case Nil => ""
                case _ :: xs => rec(xs)
            }
        };
        let ls = String.splitOn(substr = ".", s);
        let x = String.toLowerCase(rec(ls));
        match x {
            case "html" => ContentType.HTML
            case "css" => ContentType.CSS
            case "ico" => ContentType.ICO
            case "png" => ContentType.PNG
            case _ => ContentType.HTML
        }

    def getHTTPPreamble(length: Int32, typ: ContentType): String \ {} = 
        let status = "HTTP/1.1 200 OK\r\n";
        let tp = "Content-Type: ${typ}; charset=utf-8\r\n";
        let content_length = "Content-Length: ${length}\r\n";
        let connection = "Connection: close\r\n";
        "${status}${tp}${content_length}${connection}\r\n"

    def toIntArray(s: String, rc: Region[r]): Array[Int8, r] \ r = 
        let v = String.toBytes(s);
        Vector.toArray(rc, v)

    enum ContentType {
        case HTML
        case CSS
        case ICO
        case PNG
    }

    instance ToString[ContentType] {

        pub def toString(x: ContentType): String = 
            match x {
                case ContentType.HTML => "text/html"
                case ContentType.CSS => "text/css"
                case ContentType.ICO => "image/x-icon"
                case ContentType.PNG => "image/png"
            }
    
    }
    
}