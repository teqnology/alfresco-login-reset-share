<#macro androHeader>

<!DOCTYPE html>
<html>

<head>
    <title>
        <#nested>
    </title>

    <meta name = “viewport” content = “user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width”>

    <link rel="icon" href="${url.context}/res/favicon.ico" type="image/png">

    <link rel="stylesheet" type="text/css" href="${url.context}/css/material.css" >
    <link rel="stylesheet" type="text/css" href="${url.context}/css/material.orange-indigo.min.css" >
    <link rel="stylesheet" type="text/css" href="${url.context}/css/main.css" >
    <link rel='stylesheet' type='text/css' href="//fonts.googleapis.com/icon?family=Material+Icons" />

    <script type="text/javascript">
    //<![CDATA[
        window.scrollTo(0, 1);
    //]]>
    </script>

</head>

<body>

<!-- Always shows a header, even in smaller screens. -->
<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header mdl-layout__header--transparent">
        <div class="mdl-layout__header-row">
            <!-- Title -->
            <span class="mdl-layout-title mdl-layout--large-screen-only"><a href="${url.context}" class="brand-logo"><img src="${url.context}/res/themes/default/images/logo.png"></a></span>
            <!-- Add spacer, to align navigation to the right -->
            <div class="mdl-layout-spacer"></div>
            <!-- Navigation. We hide it in small screens. -->
            <nav class="mdl-navigation mdl-layout--large-screen-only">
                <a class="mdl-navigation__link" href="${url.context}"> ${msg("andro.page.header.alfresco")} ${srv.data.edition} - ${msg("andro.page.header.version")} ${srv.data.version} </a>
            </nav>
        </div>
    </header>

</#macro>