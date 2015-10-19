<!DOCTYPE html>
<html class="grey lighten-2">
<head>
    <title>Alfresco Login</title>

    <link rel="icon" href="${url.context}/res/favicon.ico" type="image/png">

    <link rel="stylesheet" type="text/css" href="${url.context}/css/materialize.min.css" >
    <link rel="stylesheet" type="text/css" href="${url.context}/css/main.css" >
    <link rel='stylesheet' type='text/css' href="//fonts.googleapis.com/css?family=Raleway:200,600" />

</head>
<body>

    <#include "../include/andro-header.ftl" />

    <main>
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
                <div class="col l6 offset-l3 s12 m12">
                    <div class="card z-depth-1">
                        <div class="card-content">
                            <span class="card-title grey-text text-darken-4">Log In</span>
                            <div class="divider blue"></div>
                            <form id="loginform" accept-charset="UTF-8" method="post" action="${url.context}/page/dologin">
                                <input type="hidden" name="success" value="${url.url}">
                                <input type="hidden" name="failure" value="/share/page/?error=true">
                                <div class="row">
                                    <div class="input-field col s12 m12 l12">
                                        <input id="username" name="username" type="text" required>
                                        <label for="username" class="active">Username</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="input-field col s12 m12 l12">
                                        <input id="password" name="password" type="password" required>
                                        <label for="password" class="active">Password</label>
                                    </div>
                                </div>
                                <button class="btn waves-effect waves-light blue" type="submit" id="btn-login" name="action">Login</button>
                            </form>
                        </div>
                        <div class="card-action">
                            <a class="waves-effect btn grey lighten-5 grey-text text-darken-4" href="${url.context}/page/forgot-password">Forgot Password?</a>

                            <div id="forgotten-password" class="modal">
                                <h4 id="formResultH">Password Reset</h4>
                                <form id="resetP" action="/share/proxy/alfresco-noauth/androgogic/reset-password" method="POST">
                                    <div id="formResult" class="input-field col s12">
                                        <input id="emailForgotten" type="text" name="email" required>
                                        <label for="emailForgotten">Email or Username</label>
                                    </div>
                                    <button id="formBtn" class="waves-effect waves-light btn modal_close grey" type="submit" name="action">Confirm</button>
                                </form>
                                <div id="loading" class="progress" style="visibility:hidden;">
                                    <div class="indeterminate"></div>
                                </div>
                                <p class="flow-text" id="formResultP"></p>
                            </div>

                            <div id="auth-error-modal" class="modal">
                                <div class="card-content">
                                    <span class="card-title grey-text text-darken-4">Authentication Error</span>
                                    <p class="flow-text">Your authentication details have not been recognized or Alfresco may not be available at this time.</p>
                                </div>
                                <div class="card-action">
                                    <a href="#" class="waves-effect btn-flat grey-text text-darken-4 modal-close">Close</a>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col s12 m12 l12 text-center">
                    <div class="row">
                    </div>
                    <div class="row">
                    </div>
                </div>
            </div>

        </div>
    </main>

    <#include "../include/andro-footer.ftl" />


    <script src="${url.context}/js/jquery.min.js"></script>
    <script src="${url.context}/js/materialize.min.js"></script>
    <script>

        $( document ).ajaxStart(function() {
          $( "#loading" ).show();
        });

        $(document).ready(function(){

            $(".modal-trigger").leanModal({
                dismissible: true,
                opacity: .5,
                in_duration: 300,
                out_duration: 200,
                complete: function() { emptyDiv("#formResultP"); }
            });

            $( "#resetP" ).submit(function( event ) {
                event.preventDefault();
                var emailF = $('#emailForgotten').val();
                $.ajax({
                   type: "POST",
                   url: "/share/proxy/alfresco-noauth/androgogic/reset-password",
                   data: JSON.stringify({ email: emailF }),
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function(result) {
                        $('#formResultP').text("Check your email.");
                   },
                   error: function(xhr, status, error) {
                      var err = eval("(" + xhr.responseText + ")");
                        $('#formResultP').text(err.message);
                    }
                });
            });

            function emptyDiv(divElement){
                $( divElement ).empty();
            }

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
                 $('#auth-error-modal').openModal();
            }


        });
    </script>
</body>
</html>