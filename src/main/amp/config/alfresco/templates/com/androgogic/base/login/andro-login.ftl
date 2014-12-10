<!DOCTYPE html>
<html>
<head>
    <title>Androgogic | Alfresco Login</title>

    <link rel="icon" href="${url.context}/img/fav.png" type="image/png">

    <link rel="stylesheet" type="text/css" href="${url.context}/css/materialize.min.css" >
    <link rel="stylesheet" type="text/css" href="${url.context}/css/andro-login.css" >
    <link rel='stylesheet' type='text/css' href="//fonts.googleapis.com/css?family=Raleway:200,600" />

</head>
<body>

    <div class="container">

        <div class="row">

            <div class="col s12 m12 l12 text-center">
                <div class="row">
                </div>

                <div class="row">
                </div>

            </div>

        </div>

        <div class="row">

            <div class="col l6 offset-l3 s12 m12 text-center">

                <div class="card-panel">

                    <div class="row">
                        <img class="alfresco-logo" src="/share/img/alfresco.png">
                    </div>

                    <div class="row">
                        <form id="loginform" class="col s12 m12 l12" accept-charset="UTF-8" method="post" action="${url.context}/page/dologin">

                            <div class="row">
                                <div class="input-field col s12 m12 l12">
                                    <input id="username" name="username" type="text" required>
                                    <label for="username">Username</label>
                                </div>
                            </div>

                            <div class="row">
                                <div class="input-field col s12 m12 l12">
                                    <input id="password" name="password" type="password" required>
                                    <label for="password">Password</label>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col s12 m12 l12">
                                    <button class="btn waves-effect waves-light" type="submit" id="btn-login" name="action">Login</button>
                                </div>
                            </div>

                            <div class="row">
                                <img class="androgogic-logo" src="${url.context}/img/androgogic.gif">
                            </div>

                        </form>

                    </div>

                </div>

                <div class="row">

                    <div class="col s12 m12 l12">

                        <p></p>

                    </div>

                </div>

            </div>

        </div>

    </div>

    <footer>
        <div class="container">
            <div class="row">
                <div class="col l6 m6 s6">
                    © 2005-2014 <a href="http://www.alfresco.com" title="Alfresco" target="_blank">Alfresco Software Inc.</a> | All Rights Reserved.
                </div>
                <div class="col l6 m6 s6 right">
                    © 2014 <a href="http://www.androgogic.com" title="Androgogic Website" target="_blank"><span>androgogic pty ltd.</span></a> | all rights reserved
                </div>
            </div>
        </div>
    </footer>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="${url.context}/js/materialize.min.js"></script>

</body>
</html>