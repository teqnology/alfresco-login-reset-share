<!DOCTYPE html>
<html class="grey lighten-2">
<head>
    <title>Androgogic | Alfresco Reset Password</title>

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
                    <form id="resetform" class="col s12 m12 l12" accept-charset="UTF-8" method="post" action="#">

                        <input type="hidden" name="success" value="/share/page/">
                        <input type="hidden" name="failure" value="/share/page/?error=true">

                        <input type="hidden" name="oldpassword" value="oldpassword">

                        <div class="row">
                            <div class="input-field col s12 m12 l12">
                                <input id="newpassword" name="newpassword" type="password" required>
                                <label for="newpassword">New Password</label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="input-field col s12 m12 l12">
                                <input id="repeatpassword" name="repeatpassword" type="password" required>
                                <label for="repeatpassword">Repeat Password</label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col s12 m12 l12">
                                <button class="btn waves-effect waves-light disabled" id="btn-reset" type="submit" disabled name="action">Submit</button>
                            </div>
                        </div>

                    </form>

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
                <p>Version ${srv.data.version}</p>
            </div>
            <div class="col l4 offset-l2 s12">
                <h5>Links</h5>
                <li><a class="grey-text" href="${url.context}">Alfresco Share Login</a></li>
                <li><a class="grey-text" href="http://docs.alfresco.com/" target="_blank">Online Documentation</a></li>
                <li><a class="grey-text" href="/alfresco/webdav" target="_blank">Alfresco WebDav</a></li>
                <li><a class="grey-text" href="/alfresco/s/index" target="_blank">Alfresco WebScripts Home (admins only)</a></li>
            </div>
        </div>
    </div>
    <div class="footer-copyright grey lighten-2">
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

            var token = getUrlParameter('token');
            var uname = getUrlParameter('username');

            $.ajax({
                type: 'POST',
                url: '/share/proxy/alfresco-noauth/andro/base/reset-password-id',
                data: '{username:"' + uname + '", token:"' + token + '"}',
                success: function(data) { alert('data: ' + data); },
                contentType: 'application/json',
                dataType: 'json'
            });


            function checkPass(){
                var pass1 = document.getElementById('newpassword');
                var pass2 = document.getElementById('repeatpassword');
                if(pass1.value == pass2.value){
                    $( "#btn-reset" ).removeClass( "disabled" ).removeAttr("disabled");
                }else{
                    //toast('Passwords do not match!', 1000);
                    $( "#btn-reset" ).addClass( "disabled" ).attr("disabled");
                }
            }

            $( "#repeatpassword" ).keyup(function() {
                checkPass();
                return false;
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

             $( "#resetform" ).submit(function( event ) {
                var pass1 = document.getElementById('newpassword');
                var pass2 = document.getElementById('repeatpassword');
                if(pass1.value == pass2.value){
                    $.ajax({
                       type: 'POST',
                       url: '/share/proxy/alfresco-noauth/andro/base/reset-password-id',
                       data: '{newpwd:"' + pass2.value + '", username:"' + uname + '", token:"' + token + '"}',
                       contentType: 'application/json',
                       dataType: 'json',
                       success: function(result) {
                            alert("Password changed. To login please click on the first link in the footer, 'Alfresco Share Login'");
                            $( "#btn-reset" ).addClass( "disabled" ).attr("disabled");
                       },
                       error: function(xhr, status, error) {
                            alert("Password changed. To login please click on the first link in the footer, 'Alfresco Share Login'");
                            $( "#btn-reset" ).addClass( "disabled" ).attr("disabled");
                        }
            });
                }else{
                    toast("Passwords do not match!", 1000);
                    alert("KO");
                }
                event.preventDefault();
            });

        });
    </script>
</body>
</html>
