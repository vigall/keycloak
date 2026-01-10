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
            <div class="master-clinic-info">
                Ops! Ocorreu um imprevisto.<br>
                Estamos aqui para ajudar.
            </div>
        </div>
        <h1 id="kc-page-title">Sentimos muito...</h1>
    <#elseif section = "form">
        <div id="kc-error-message">
            <p class="instruction" style="text-align: center; font-size: 1.1rem; color: var(--mc-text); margin-bottom: 30px; line-height: 1.6;">
                <#if message.summary == "Failed to send email, please try again later.">
                    Falha ao enviar e-mail. Por favor, tente novamente mais tarde.
                <#else>
                    ${message.summary?no_esc}
                </#if>
            </p>
            
            <div style="text-align: center; border-top: 1px solid var(--mc-border); padding-top: 25px;">
                <a id="backToApplication" href="${url.loginUrl}" style="color: var(--mc-primary); text-decoration: none; font-weight: 700; font-size: 1rem;">
                    « Voltar para o login
                </a>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
