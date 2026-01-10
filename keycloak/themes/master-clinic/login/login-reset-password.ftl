<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
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
                Recuperação de Acesso<br>
                Informe seus dados para receber as instruções.
            </div>
        </div>
        <h1 id="kc-page-title">Esqueceu sua senha?</h1>
    <#elseif section = "form">
        <form id="kc-reset-password-form" class="pf-v5-c-form" action="${url.loginAction}" method="post">
            <div class="pf-v5-c-form__group">
                <label for="username" class="pf-v5-c-form__group-label">
                    E-mail ou usuário
                </label>
                <input type="text" id="username" name="username" class="pf-v5-c-form-control" autofocus value="${(auth.attemptedUsername!'')}" aria-invalid="<#if messagesPerField.existsError('username')>true</#if>" placeholder="Digite seu e-mail ou usuário"/>
                
                <#if messagesPerField.existsError('username')>
                    <span id="input-error-username" class="pf-v5-c-helper-text pf-m-error" aria-live="polite" style="color: #c9190b; font-size: 0.8rem; margin-top: 5px; display: block;">
                        Usuário ou e-mail não encontrado.
                    </span>
                </#if>
            </div>

            <div class="pf-v5-c-form__group pf-m-action" style="margin-top: 25px;">
                <div id="kc-form-buttons">
                    <input class="pf-v5-c-button pf-m-primary" type="submit" value="Enviar instruções" id="kc-login" style="width: 100%; height: 52px; background-color: var(--mc-primary); border: none; border-radius: 8px; color: white; font-weight: 700; cursor: pointer; font-size: 1rem;"/>
                </div>
                
                <div style="text-align: center; margin-top: 25px; border-top: 1px solid var(--mc-border); padding-top: 20px;">
                    <a href="${url.loginUrl}" style="color: var(--mc-primary); text-decoration: none; font-weight: 700; font-size: 0.95rem;">
                        « Voltar para o login
                    </a>
                </div>
            </div>
        </form>
    <#elseif section = "info" >
        <p style="text-align: center; color: var(--mc-text-light); font-size: 0.85rem; margin-top: 15px;">
            Enviaremos um link para o seu e-mail cadastrado.
        </p>
    </#if>
</@layout.registrationLayout>
