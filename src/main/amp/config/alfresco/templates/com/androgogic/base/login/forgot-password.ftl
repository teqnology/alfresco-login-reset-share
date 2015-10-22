<#include "../include/andro-header.ftl" />

<@androHeader>
    Alfresco | Forgot Password
</@androHeader>

            <main class="mdl-layout__content">
                <div class="page-content">

                    <div class="mdl-grid">

                        <div class="mdl-layout-spacer"></div>

                        <div class="mdl-cell mdl-cell--3-col mdl-cell--6-col-tablet mdl-cell--12-col-phone mdl-typography--text-center">

                            <div class="mdl-card mdl-shadow--6dp" style="width:100%;">

                                <div class="mdl-card__title mdl-card--border">

                                    <h2 class="mdl-card__title-text">Forgot your password?</h2>

                                </div>

                                <div class="mdl-card__media">

                                    <img src="${url.context}/res/images/logo.png" alt="logo">

                                </div>

                                <div class="mdl-card__supporting-text">

                                    <div class="mdl-cell mdl-cell--12-col">
                                        <p>We can send you details on how to reset it. Please enter your email address or the username you use to log into your account.</p>
                                    </div>

                                    <form id="form-forgot">

                                        <div class="mdl-cell mdl-cell--12-col">
                                            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" id="form-label">
                                                <input class="mdl-textfield__input" name="email" type="text" id="email" />
                                                <label class="mdl-textfield__label" for="email">Email or Username</label>
                                            </div>
                                        </div>

                                        <div class="mdl-cell mdl-cell--12-col">
                                            <!-- Accent-colored raised button with ripple -->
                                            <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" type="submit" id="form-btn" name="action">
                                                Send Instructions
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