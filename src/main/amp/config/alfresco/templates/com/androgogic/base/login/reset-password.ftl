<!DOCTYPE html>
<html class="grey lighten-2">

<head>
    <title>Alfresco - ${msg("resetPage.pageTitle")}</title>

    <link rel="icon" href="${url.context}/res/favicon.ico" type="image/png">

    <link rel="stylesheet" type="text/css" href="${url.context}/css/materialize.min.css" >
    <link rel="stylesheet" type="text/css" href="${url.context}/css/main.css" >
    <link rel='stylesheet' type='text/css' href="//fonts.googleapis.com/css?family=Raleway:200,600" />

</head>

<body>

<header>
    <div class="navbar-fixed">
        <nav class="grey lighten-4">
            <div class="container">
                <div class="nav-wrapper">
                    <a href="${url.context}" class="brand-logo"><img src="${url.context}/res/themes/default/images/logo.png"></a>
                    <a class="right hide-on-med-and-down grey-text text-darken-4" href="${url.context}"> Alfresco ${srv.data.edition} - Version ${srv.data.version}</a>
                </div>
            </div>
        </nav>
    </div>
</header>

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
                        <span class="card-title grey-text text-darken-4">${msg("resetPage.title")}</span>
                        <div class="divider blue"></div>
                        <p>${msg("resetPage.text")}</p>
                        <form id="form-reset">
                            <div class="row">
                                <div class="input-field col s12">
                                    <select id="user" class="blue-text">
                                    </select>
                                    <label>${msg("resetPage.usernameLabel")}</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s12">
                                    <input id="password" type="password" name="password" required>
                                    <label for="password">${msg("resetPage.newpassLabel")}</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s12">
                                    <input id="confirm-password" type="password" name="confirm-password" required>
                                    <label for="confirm-password">${msg("resetPage.newpassConfirmLabel")}</label>
                                </div>
                            </div>
                            <button id="form-btn" class="btn waves-effect waves-light disabled" disabled type="submit" name="action">${msg("resetPage.submitButton")}</button>
                            <div class="row"></div>
                        </form>
                        <div id="loading" class="progress blue lighten-1" style="display:none;">
                            <div class="indeterminate blue lighten-4"></div>
                        </div>
                        <p class="flow-text" id="form-result"></p>
                        <p id="error" class="orange-text text-darken-4"></p>
                    </div>
                    <div class="card-action">
                        <a href="${url.context}" class="waves-effect btn grey lighten-5 grey-text text-darken-4" type="submit" name="action">${msg("resetPage.backtologinButton")}</a>
                    </div>
                </div>
            </div>
        </div>

    </div>
</main>

<footer class="page-footer grey lighten-3">
    <div class="container">
        <div class="row">
            <div class="col l6 s12">
                <div class="row valign-wrapper">
                    <div class="col s4 m2">
                        <img class="responsive-img valign" src="${url.context}/res/themes/${theme}/images/app-logo-48.png">
                    </div>
                    <div class="col s8 m10">
                        <p class="grey-text text-darken-4">© 2005-2014 <a href="http://www.alfresco.com" title="Alfresco" target="_blank">Alfresco Software Inc.</a> | All Rights Reserved.</p>
                    </div>
                </div>
            </div>
            <div class="col l4 offset-l2 s12 grey-text text-darken-4">
                <h5>Links</h5>
                <li><a class="blue-text" href="http://docs.alfresco.com/" target="_blank">Online Documentation</a></li>
                <li><a class="blue-text" href="/alfresco/webdav" target="_blank">Alfresco WebDav</a></li>
                <li><a class="blue-text" href="/alfresco/s/index" target="_blank">Alfresco WebScripts Home (admins only)</a></li>
            </div>
        </div>
    </div>
    <div class="footer-copyright grey lighten-2">
        <div class="container">
            <div class="clearfix"></div>
        </div>
    </div>
</footer>

<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="${url.context}/js/materialize.min.js"></script>
<script>
    function getErrorMessage(xhr, error) {
        try {
            var response = JSON.parse(xhr.responseText);
            return response.message;
        } catch(e) {
            return error;
        }
    }

    $(document).ready(function(){

        var key = getUrlParameter('key');
        var activitiId = getUrlParameter('activiti');
        var email = getUrlParameter('email');
        var user = getUrlParameter('user');
        $.ajax({
            type: "POST",
            url: "/share/proxy/alfresco-noauth/androgogic/login/list-users",
            data: JSON.stringify({ email: email, user: user, activiti: activitiId, key: key }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(result) {
                if(result.users.length == 1){
                    $.each(result.users, function() {
                        $.each(this, function(name, value) {
                            $('#user').append('<option value="'+ value + '" selected>' + value + '</option>');
                        });
                    });
                }else{
                    $('#user').append('<option value="" disabled selected>${msg("resetPage.selectUsername")}</option>');
                    $.each(result.users, function() {
                        $.each(this, function(name, value) {
                            $('#user').append('<option value="'+ value + '">' + value + '</option>');
                        });
                    });
                }
                $('select').material_select();
            },
            error: function(xhr, status, error) {
                $('#user').append('<option value="" disabled selected>${msg("resetPage.noValidUsername")}</option>');
                $('#user').attr('disabled','disabled');
                $('#user').addClass('disabled');
                $('#password').attr('disabled','disabled');
                $('#confirm-password').attr('disabled','disabled');
                $('select').material_select();
                $('#error').text(getErrorMessage(xhr, error));
            }
        });

        $('.modal-trigger').leanModal({
            dismissible: true,
            opacity: .5,
            in_duration: 300,
            out_duration: 200,
            complete: function() { emptyDiv('#form-result'); }
        });

        $('#form-reset').submit(function( event ) {
            event.preventDefault();
            emptyDiv('#form-result');
            emptyDiv('#error');
            $('#loading').show();
            $('#user option').removeAttr('disabled');
            $('#form-btn').attr('disabled','disabled');
            $('#form-btn').removeClass('blue');
            $('#form-btn').addClass('disabled');
            var user = $('#user').val();
            var pwd = $('#password').val();
            $.ajax({
                type: "POST",
                url: "/share/proxy/alfresco-noauth/androgogic/login/reset-password",
                data: JSON.stringify({ username: user, password: pwd, activiti: activitiId, key: key }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(result) {
                    $('#loading').hide();
                    $('#user option').attr('disabled','disabled');
                    $('#form-result').text('${msg("resetPage.passwordUpdated")}');
                },
                error: function(xhr, status, error) {
                    $('#loading').hide();
                    $('#user option').attr('disabled','disabled');
                    $('#form-btn').removeAttr('disabled');
                    $('#form-btn').addClass('blue');
                    $('#form-btn').removeClass('disabled');
                    $('#error').text(getErrorMessage(xhr, error));
                }
            });
        });

        function checkPass(){
            var pwd = document.getElementById('password');
            var pwd2 = document.getElementById('confirm-password');
            if(!$('#user').is(':disabled')){
                if(pwd.value == pwd2.value){
                    emptyDiv('#error');
                    $('#form-btn').addClass('blue');
                    $('#form-btn').removeClass('disabled');
                    $('#form-btn').removeAttr('disabled');
                }else{
                    $('#form-btn').attr('disabled','disabled');
                    $('#form-btn').removeClass('blue');
                    $('#form-btn').addClass('disabled');
                    $('#error').text('${msg("resetPage.passwordMismatch")}');
                }
            }
        }

        $('#confirm-password').keyup(function() {
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

    });
</script>

</body>

</html>
