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

                <div class="card-panel z-depth-4">

                    <div class="row">
                        <img class="androgogic-logo" src="${url.context}/img/androgogic.gif">
                        <!--<img class="alfresco-logo" src="/share/img/alfresco.png">-->
                    </div>

                    <div class="row">
                        <form id="loginform" class="col s12 m12 l12" accept-charset="UTF-8" method="post" action="${url.context}/page/dologin">

                            <input type="hidden" name="success" value="/share/page/">
                            <input type="hidden" name="failure" value="/share/page/?error=true">

                            <div class="row">
                                <div class="input-field col s12 m12 l12">
                                    <input id="username" name="username" type="text" autocomplete="off" required>
                                    <label for="username">Username</label>
                                </div>
                            </div>

                            <div class="row">
                                <div class="input-field col s12 m12 l12">
                                    <input id="password" name="password" type="password" autocomplete="off" required>
                                    <label for="password">Password</label>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col s12 m12 l12">
                                    <button class="btn waves-effect waves-light" type="submit" id="btn-login" name="action">Login</button>
                                </div>
                            </div>

                        </form>

                    </div>

                </div>

                <div class="row">

                    <div class="col s12 m12 l12">

                        <p><a class="waves-effect btn-flat modal-trigger" href="#modal1">Forgotten Password?</a></p>

                        <div id="modal1" class="modal">
                            <h4 id="formResultH">Password Reset</h4>
                            <form id="resetP" action="/share/proxy/alfresco-noauth/andro/base/reset-password" method="POST">
                                <div id="formResult" class="input-field col s12">
                                    <input id="emailForgotten" type="text" name="email" required>
                                    <label for="emailForgotten">Email or Username</label>
                                </div>
                                <button id="formBtn" class="waves-effect btn-flat modal_close" type="submit" name="action">Confirm</button>
                            </form>
                            <p class="flow-text" id="formResultP"></p>
                        </div>

                        <div id="errorModal" class="modal">
                            <h4>Authentication Error</h4>
                            <p class="flow-text">Your authentication details have not been recognized or Alfresco may not be available at this time.</p>
                            <a href="#" class="waves-effect btn-flat modal-close">Close</a>
                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

    <footer class="grey lighten-3">
        <div class="container">
            <div class="row">
                <div class="col l6 s12">
                    <h5><img class="responsive-img" src="${url.context}/res/themes/default/images/app-logo-48.png"> Alfresco ${srv.data.edition}</h5>
                    <p>version ${srv.data.version}</p>
                </div>
                <div class="col l4 offset-l2 s12">
                    <h5>Links</h5>
                    <li><a class="grey-text" href="http://docs.alfresco.com/" target="_blank">Online Documentation</a></li>
                    <li><a class="grey-text" href="/alfresco/webdav" target="_blank">Alfresco WebDav</a></li>
                    <li><a class="grey-text" href="/alfresco/s/index" target="_blank">Alfresco WebScripts Home (admins only)</a></li>
                </div>
            </div>
        </div>
        <div class="footer-copyright">
            <div class="container">
                <p class="grey-text left">© 2005-2014 <a href="http://www.alfresco.com" title="Alfresco" target="_blank">Alfresco Software Inc.</a> | All Rights Reserved.</p>
                <p class="grey-text right">© 2014 <a href="http://www.androgogic.com" title="Androgogic Website" target="_blank"><span>androgogic pty ltd.</span></a> | all rights reserved
                <div class="clearfix"></div>
            </div>
        </div>
    </footer>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="${url.context}/js/materialize.min.js"></script>
    <script>
        $(document).ready(function(){
            $('.modal-trigger').leanModal();

            $( "#resetP" ).submit(function( event ) {
                event.preventDefault();
                var emailF = $('#emailForgotten').val();
                $.ajax({
                   type: "POST",
                   url: "/share/proxy/alfresco-noauth/andro/base/reset-password",
                   data: JSON.stringify({ email: emailF }),
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function(result) {
                        $('#formResultP').text("Check your email.");
                        $('#formResultH').text("Password reset - Success");
                        $('#resetP').remove();
                   },
                   error: function(xhr, status, error) {
                      var err = eval("(" + xhr.responseText + ")");
                        $('#formResultP').text(err.message);
                        $('#formResultH').text("Password reset - Failure");
                        $('#resetP').remove();
                    }
                });
            });

            function getUrlParameter(sParam) {
                var sPageURL = window.location.search.substring(1);
                var sURLVariables = sPageURL.split('&');
                for (var i = 0; i < sURLVariables.length; i++)
                {
                    var sParameterName = sURLVariables[i].split('=');
                    if (sParameterName[0] == sParam)
                    {
                        return sParameterName[1];
                    }
                }
            };

            var error = getUrlParameter('error');
            if (error == "true") {
                 $('#errorModal').openModal();
            }


        });
    </script>
</body>
</html>