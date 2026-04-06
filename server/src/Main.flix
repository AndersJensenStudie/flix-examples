use Net.Ipv4Addr.Ipv4Addr
use Server.{serve, connect}
use Net.{IpAddr, Ipv4Addr, TcpAccept, TcpBind}
use Fs.FileRead

def debugMain(): Unit \ IO = 
    run {
        let s = connect(IpAddr.V4(Ipv4Addr.localhost()), 4000i16);
        serve(s, "resources")
    } with RouteResolver.runWithStandard
    with ServerUtils.runWithLogger
    with FileRead.runWithIO
    with TcpAccept.runWithIO
    with TcpBind.runWithIO
    with Logger.runWithIO;
    ()

def withRoutes(): Unit \ IO = 
    run {
        let s = connect(IpAddr.V4(Ipv4Addr.localhost()), 4000i16);
        serve(s, "resources")
    } with RouteResolver.runWithMap(
        Map#{
            "/" => "/index.html",
            "/helloworld" => "/index.html",
            "/favicon.ico" => "/images/favicon.ico"
        })
    with ServerUtils.runWithLogger
    with FileRead.runWithIO
    with TcpAccept.runWithIO
    with TcpBind.runWithIO
    with Logger.runWithSeverityFilter(Severity.Info)
    with Logger.runWithIO;
    ()

def main(): Unit \ IO = 
    run {
        let s = connect(IpAddr.V4(Ipv4Addr.localhost()), 4000i16);
        serve(s, "resources")
    } with RouteResolver.runWithStandard
    with ServerUtils.runWithLogger
    with FileRead.runWithIO
    with TcpAccept.runWithIO
    with TcpBind.runWithIO
    with Logger.runWithSeverityFilter(Severity.Debug)
    with Logger.runWithIO;
    ()

def serveLocally(): Unit \ IO = 
    run {
        let ip = Option.getOrAbort(Ipv4Addr.fromString("0.0.0.0"));
        let s = connect(IpAddr.V4(ip), 4000i16);
        serve(s, "resources")
    } with RouteResolver.runWithStandard
    with ServerUtils.runWithLogger
    with FileRead.runWithIO
    with TcpAccept.runWithIO
    with TcpBind.runWithIO
    with Logger.runWithFilter(
        s -> _ -> 
        match s {
            case Severity.Debug => false
            case _ => true
        })
    with Logger.runWithIO;
    ()
 