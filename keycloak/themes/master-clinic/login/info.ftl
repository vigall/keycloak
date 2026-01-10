<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <div class="mc-header-section">
            <div class="mc-logo-container">
                <svg class="mc-logo-svg" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                    <path d="M30 10 H70 V30 H90 V70 H70 V90 H30 V70 H10 V30 H30 Z" fill="#2D5A4C"/>
                    <path d="M50 35 C65 35 75 50 75 70 C55 70 45 55 45 40" fill="white" opacity="0.9"/>
                    <path d="M45 40 C45 45 50 55 55 60" stroke="#2D5A4C" stroke-width="2" fill="none"/>
                </svg>
                <span class="mc-logo-text">Master Clinic</span>
            </div>
        </div>
        <h1 id="kc-page-title">${message.summary}</h1>
    <#elseif section = "form">
        <div id="kc-info-message">
            <p class="instruction" style="text-align: center; font-size: 1rem; color: var(--mc-text-light); margin-bottom: 25px;">
                <#if skipLink??>
                <#else>
                    <#if pageRedirectUri?has_content>
                        <a href="${pageRedirectUri}" style="color: var(--mc-primary); font-weight: 700;">« Voltar para o aplicativo</a>
                    <#elseif actionUri?has_content>
                        <a href="${actionUri}" style="color: var(--mc-primary); font-weight: 700;">Clique aqui para continuar</a>
                    <#elseif (client.baseUrl)?has_content>
                        <a href="${client.baseUrl}" style="color: var(--mc-primary); font-weight: 700;">« Voltar para o aplicativo</a>
                    <#else>
                        <a href="${url.loginUrl}" style="color: var(--mc-primary); font-weight: 700;">« Voltar para o login</a>
                    </#if>
                </#if>
            </p>
        </div>
    </#if>
</@layout.registrationLayout>
