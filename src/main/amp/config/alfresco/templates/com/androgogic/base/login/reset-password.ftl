<#include "../include/andro-header.ftl" />

<@androHeader>
    Alfresco | Reset Password
</@androHeader>

            <main class="mdl-layout__content">
                <div class="page-content">

                    <div class="mdl-grid">

                        <div class="mdl-layout-spacer"></div>

                        <div class="mdl-cell mdl-cell--3-col mdl-cell--6-col-tablet mdl-cell--12-col-phone mdl-typography--text-center">

                            <div class="mdl-card mdl-shadow--6dp" style="width:100%;">

                                <div class="mdl-card__title mdl-card--border">

                                    <h2 class="mdl-card__title-text">Reset your password</h2>

                                </div>

                                <div class="mdl-card__media">

                                    <img src="${url.context}/res/images/logo.png" alt="logo">

                                </div>

                                <div class="mdl-card__supporting-text">

                                    <div class="mdl-cell mdl-cell--12-col">
                                        <p>Update your user password here. If the provided email has multiple accounts registered, a dropdown user selection will be available.</p>
                                    </div>

                                    <form id="form-reset">

                                        <div class="mdl-cell mdl-cell--12-col">
                                            <div class="mdl-textfield mdl-js-textfield">
                                                <select class="mdl-textfield__input" id="user">
                                                </select>
                                            </div>
                                        </div>

                                        <div class="mdl-cell mdl-cell--12-col">
                                            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                                <input class="mdl-textfield__input" name="password" type="password" id="password" required/>
                                                <label class="mdl-textfield__label" for="password">New Password</label>
                                            </div>
                                        </div>

                                        <div class="mdl-cell mdl-cell--12-col">
                                            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" id="form-label">
                                                <input class="mdl-textfield__input" name="confirm-password" type="password" id="confirm-password" />
                                                <label class="mdl-textfield__label" for="confirm-password">Confirm Password</label>
                                            </div>
                                        </div>

                                        <div class="mdl-cell mdl-cell--12-col">
                                            <!-- Accent-colored raised button with ripple -->
                                            <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" disabled type="submit" id="form-btn" name="action">
                                                Reset Password
                                            </button>
                                        </div>

                                    </form>

                                    <div class="mdl-cell mdl-cell--12-col">
                                        <p id="form-result"></p>
                                        <p id="error"></p>
                                    </div>

                                    <div id="loading" class="mdl-progress mdl-js-progress mdl-progress__indeterminate" style="display:none;"></div>

                                </div>

                                <div class="mdl-card__actions mdl-card--border">

                                    <div class="mdl-cell mdl-cell--12-col">
                                        <!-- Accent-colored flat button -->
                                        <a class="mdl-button mdl-js-button mdl-js-ripple-effect" href="${url.context}">Back to login page</a>
                                    </div>

                                </div>
                            </div>

                        </div>

                        <div class="mdl-layout-spacer"></div>

                    </div>

                </div>
            </main>

            <#include "../include/andro-footer.ftl" />

        </div>

        <script src="${url.context}/js/jquery.min.js"></script>
        <script src="${url.context}/js/material.js"></script>
        <script>
            $(document).ready(function(){

                var key = getUrlParameter('key');
                var activitiId = getUrlParameter('activiti');
                var email = getUrlParameter('email');
                $.ajax({
                   type: "POST",
                   url: "/share/proxy/alfresco-noauth/androgogic/login/list-users",
                   data: JSON.stringify({ email: email, activiti: activitiId, key: key }),
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function(result) {
                        if(result.users.length == 1){
                            $.each(result.users, function() {
                              $.each(this, function(name, value) {
                                $('#user').append('<option value="'+ value + '" disabled selected>' + value + '</option>');
                              });
                            });
                        }else{
                            $('#user').append('<option value="">Select username...</option>');
                            $.each(result.users, function() {
                              $.each(this, function(name, value) {
                                $('#user').append('<option value="'+ value + '">' + value + '</option>');
                              });
                            });
                        }
                   },
                   error: function(xhr, status, error) {
                        $('#user').append('<option value="" disabled selected>No valid username found...</option>');
                        $('#user').attr('disabled','disabled');
                        $('#user').addClass('disabled');
                        var err = eval("(" + xhr.responseText + ")");
                        $('#error').text(err.message);
                    }
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
                            $('#form-result').text('Password updated. A confirmation email was sent to notify the password update.');
                            window.setInterval(function() {reloadPage()}, 2000);
                       },
                       error: function(xhr, status, error) {
                            $('#loading').hide();
                            $('#user option').attr('disabled','disabled');
                            $('#form-btn').removeAttr('disabled');
                            $('#form-btn').addClass('blue');
                            $('#form-btn').removeClass('disabled');
                            var err = eval("(" + xhr.responseText + ")");
                            $('#error').text(err.message);
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
                            $('#error').text("Passwords do not match");
                        }
                    }
                }

                $('#confirm-password').keyup(function() {
                    checkPass();
                    return false;
                });

                function reloadPage(){
                    window.location.assign("/share");
                }

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