function getServer() {
    var srv = remote.call("/api/server")
    if (srv.status == 200) {
        srvObj = eval("(" + srv + ")");
        model.srv = srvObj;
    }else if (srv.status == 404) {
        srvObj = eval('({"data":{"edition":"repository not found","version":" - Status code: 404","schema":"0000"}})');
        model.srv = srvObj;
    }else if (srv.status == 500) {
        srvObj = eval('({"data":{"edition":"repository internal server error","version":" - Status code: 500","schema":"0000"}})');
        model.srv = srvObj;
    }else if (srv.status == 503) {
        srvObj = eval('({"data":{"edition":"repository connection refused","version":" - Status code: 503","schema":"0000"}})');
        model.srv = srvObj;
    }else if (srv.status == 504) {
        srvObj = eval('({"data":{"edition":"repository timed out","version":" - Status code: 504","schema":"0000"}})');
        model.srv = srvObj;
    }else {
        srvObj = eval('({"data":{"edition":"repository not found","version":" - generic error","schema":"0000"}})');
        model.srv = srvObj;
    }
}

function main()
{
    getServer();
}

main();