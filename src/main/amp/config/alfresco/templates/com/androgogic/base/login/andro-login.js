
function getServer() {
    var srv = remote.call("/api/server")
    if (srv.status == 200) {
      srvObj = eval("(" + srv + ")");
      model.srv = srvObj;
    }
}

function main()
{
    getServer();
}

main();