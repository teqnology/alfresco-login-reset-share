<!DOCTYPE html>
<html class="grey lighten-2">

<head>
    <title>Alfresco | Forgot Password</title>

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
                            <span class="card-title grey-text text-darken-4">Forgot your password?</span>
                            <div class="divider blue"></div>
                            <p>We can send you details on how to reset it. Please enter your email address or the username you use to log into your account.</p>
                            <form id="form-forgot">
                                <div class="row">
                                    <div id="form-label" class="input-field col s12">
                                        <input id="email" type="text" name="email" required>
                                        <label for="email">Email or Username</label>
                                    </div>
                                </div>
                                <button id="form-btn" class="btn waves-effect waves-light blue" type="submit" name="action">Send Instructions</button>
                                <div class="row"></div>
                            </form>
                            <div id="loading" class="progress blue lighten-1" style="display:none;">
                                <div class="indeterminate blue lighten-4"></div>
                            </div>
                            <p class="flow-text" id="form-result"></p>
                            <p id="error" class="orange-text text-darken-4"></p>
                        </div>
                        <div class="card-action">
                            <a href="${url.context}" class="waves-effect btn grey lighten-5 grey-text text-darken-4" type="submit" name="action">Cancel</a>
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
        $(document).ready(function(){

            $('#form-forgot').submit(function( event ) {
                event.preventDefault();
                emptyDiv('#form-result');
                emptyDiv('#error');
                $('#loading').show();
                $('#form-btn').attr('disabled','disabled');
                $('#form-btn').removeClass('blue');
                $('#form-btn').addClass('disabled');
                var emailValue = $('#email').val();
                $.ajax({
                   type: "POST",
                   url: "/share/proxy/alfresco-noauth/androgogic/login/forgot-password",
                   data: JSON.stringify({ email: emailValue }),
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function(result) {
                        $('#loading').hide();
                        $('#form-btn').removeAttr('disabled');
                        $('#form-btn').addClass('blue');
                        $('#form-btn').removeClass('disabled');
                        $('#form-result').text('Please check your email.');
                   },
                   error: function(xhr, status, error) {
                        $('#loading').hide();
                        $('#form-btn').removeAttr('disabled');
                        $('#form-btn').addClass('blue');
                        $('#form-btn').removeClass('disabled');
                        var err = eval("(" + xhr.responseText + ")");
                        $('#error').text(err.message);
                    }
                });
            });

            function emptyDiv(divElement){
                $( divElement ).empty();
            }

        });
    </script>

</body>

</html>