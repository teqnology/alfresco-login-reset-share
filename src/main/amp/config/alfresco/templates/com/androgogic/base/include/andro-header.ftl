<#macro androHeader>

<!DOCTYPE html>
<html class="grey lighten-2">

<head>
    <title>
        <#nested>
    </title>

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

</#macro>