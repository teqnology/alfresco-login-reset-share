<!DOCTYPE html>

    <head>
        <title>Androgogic | Alfresco Login</title>

        <link rel="stylesheet" type="text/css" href="${url.context}/css/andro-login.css" >

    </head>

    <body>

        <div class="login-wrap">
            <img class="alfresco-logo" src="${url.context}/images/alfresco.png">
            <form class="form" id="loginform" accept-charset="UTF-8" method="post" action="${url.context}/page/dologin">
                Username: <input type="text" id="username" name="username"/><br>
                Password: <input type="password" id="password" name="password"/><br>
                <input type="submit" id="btn-login"/>
            </form>
            <img class="androgogic-logo" src="${url.context}/images/androgogic.gif">
        </div>

    </body>

</html>