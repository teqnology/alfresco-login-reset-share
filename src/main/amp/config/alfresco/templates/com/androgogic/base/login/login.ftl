<!DOCTYPE html>
<html class="grey lighten-2">
<head>
    <title>Alfresco - ${msg("loginPage.pageTitle")}</title>

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
                            <span class="card-title grey-text text-darken-4">${msg("loginPage.title")}</span>
                            <div class="divider blue"></div>
                            <form id="loginform" accept-charset="UTF-8" method="post" action="${url.context}/page/dologin">
                                <input type="hidden" name="success" value="${url.url}">
                                <input type="hidden" name="failure" value="/share/page/?error=true">
                                <div class="row">
                                    <div class="input-field col s12 m12 l12">
                                        <input id="username" name="username" type="text" required>
                                        <label for="username" class="active">${msg("loginPage.usernameLabel")}</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="input-field col s12 m12 l12">
                                        <input id="password" name="password" type="password" required>
                                        <label for="password" class="active">${msg("loginPage.passwordLabel")}</label>
                                    </div>
                                </div>
                                <button class="btn waves-effect waves-light blue" type="submit" id="btn-login" name="action">${msg("loginPage.submitButton")}</button>
                            </form>
                        </div>
                        <div class="card-action">
                            <a class="waves-effect btn grey lighten-5 grey-text text-darken-4" href="${url.context}/page/forgot-password">${msg("loginPage.forgotButton")}</a>

                            <div id="auth-error-modal" class="modal">
                                <div class="card-content">
                                    <span class="card-title grey-text text-darken-4">${msg("loginPage.authErrorTitle")}</span>
                                    <p class="flow-text">${msg("loginPage.authErrorText")}</p>
                                </div>
                                <div class="card-action">
                                    <a href="#" class="waves-effect btn-flat grey-text text-darken-4 modal-close">${msg("loginPage.authErrorClose")}</a>
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
        $(document).ready(function(){

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
