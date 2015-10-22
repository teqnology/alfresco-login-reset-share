<#include "../include/andro-header.ftl" />

<@androHeader>
    Alfresco | Login
</@androHeader>

            <main class="mdl-layout__content">
                <div class="page-content">

                    <div class="mdl-grid">

                        <div class="mdl-layout-spacer"></div>

                        <div class="mdl-cell mdl-cell--3-col mdl-cell--6-col-tablet mdl-cell--12-col-phone mdl-typography--text-center">

                            <div class="mdl-card mdl-shadow--6dp" style="width:100%;">

                                <div class="mdl-card__title mdl-card--border">

                                    <h2 class="mdl-card__title-text">LOGIN</h2>

                                </div>

                                <div class="mdl-card__media">

                                    <img src="${url.context}/res/images/logo.png" alt="logo">

                                </div>

                                <div class="mdl-card__supporting-text">

                                    <form id="loginform" accept-charset="UTF-8" method="post" action="${url.context}/page/dologin">
                                        <input type="hidden" name="success" value="${url.url}">
                                        <input type="hidden" name="failure" value="/share/page/?error=true">

                                        <div class="mdl-cell mdl-cell--12-col">
                                            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                                <input class="mdl-textfield__input" name="username" type="text" id="username" />
                                                <label class="mdl-textfield__label" for="username">Username</label>
                                            </div>
                                        </div>

                                        <div class="mdl-cell mdl-cell--12-col">
                                            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                                <input class="mdl-textfield__input" name="password" type="password" id="password" />
                                                <label class="mdl-textfield__label" for="password">Password</label>
                                            </div>
                                        </div>

                                        <div class="mdl-cell mdl-cell--12-col">
                                            <!-- Accent-colored raised button with ripple -->
                                            <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" type="submit" id="btn-login" name="action">
                                                Sign In
                                            </button>
                                        </div>

                                    </form>

                                    <div class="mdl-cell mdl-cell--12-col">
                                        <p id="error"></p>
                                    </div>

                                </div>

                                <div class="mdl-card__actions mdl-card--border">

                                    <div class="mdl-cell mdl-cell--12-col">
                                        <!-- Accent-colored flat button -->
                                        <a class="mdl-button mdl-js-button mdl-js-ripple-effect" href="${url.context}/page/forgot-password">Forgot Password?</a>
                                    </div>

                                </div>
                            </div>

                        </div>

                        <div class="mdl-layout-spacer"></div>

                    </div>

                </div>
            </main>
        </div>

        <#include "../include/andro-footer.ftl" />

        <script src="${url.context}/js/jquery.min.js"></script>
        <script src="${url.context}/js/material.js"></script>
        <script>

            $(document).ready(function(){

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
                    $('#error').text("Your authentication details have not been recognized or Alfresco may not be available at this time.");
                }

            });
        </script>
    </body>
</html>