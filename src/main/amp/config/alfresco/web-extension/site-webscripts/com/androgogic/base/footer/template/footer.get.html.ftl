<@markup id="material-css" target="css" action="before">
    <@link rel="stylesheet" type="text/css" href="${url.context}/res/css/material.css" />
</@>

<@markup id="material-js" target="js" action="before">
    <@script src="${url.context}/res/js/jquery.min.js" />
    <@script src="${url.context}/res/js/material.js" />
</@>

<@markup id="footer" target="html" action="replace" scope="global">
    <footer class="mdl-mini-footer">
        <div class="mdl-mini-footer__left-section">
            <div class="mdl-logo">${msg("andro.page.login.footer.label.copyright")}</div>
        </div>
        <div class="mdl-mini-footer__right-section">
            <ul class="mdl-mini-footer__link-list">
                <li><a href="/alfresco/webdav" target="_blank">${msg("andro.page.login.footer.link.one")}</a></li>
                <li><a href="/alfresco/s/index" target="_blank">${msg("andro.page.login.footer.link.two")}</a></li>
            </ul>
        </div>
    </footer>
</@>