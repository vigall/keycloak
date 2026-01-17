<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
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
                Inovação que potencializa o cuidado.<br>
                Gestão moderna e intuitiva para profissionais da saúde.
            </div>
        </div>
        <h2 id="kc-page-title">Acesse sua conta</h2>
    <#elseif section = "form">
        <div id="kc-form">
          <div id="kc-form-wrapper">
            <#if realm.password>
                <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                    <div class="pf-v5-c-form__group">
                        <label for="username" class="pf-v5-c-form__group-label">E-mail ou usuário</label>
                        <#if usernameEditDisabled??>
                            <input tabindex="1" id="username" class="pf-v5-c-form-control" name="username" value="${(login.username!'')}" type="text" disabled />
                        <#else>
                            <input tabindex="1" id="username" class="pf-v5-c-form-control" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off"
                                   aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                   placeholder="E-mail ou usuário"
                            />
                            <#if messagesPerField.existsError('username','password')>
                                <span id="input-error" class="pf-v5-c-helper-text pf-m-error" aria-live="polite" style="color: #c9190b; font-size: 0.8rem; margin-top: 5px; display: block;">
                                        Usuário ou senha inválidos.
                                </span>
                            </#if>
                        </#if>
                    </div>

                    <div class="pf-v5-c-form__group" style="margin-top: 15px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                            <label for="password" class="pf-v5-c-form__group-label" style="margin-bottom: 0;">Senha</label>
                            <#if realm.resetPasswordAllowed>
                                <span style="font-size: 0.8rem;"><a tabindex="5" href="${url.loginResetCredentialsUrl}" style="color: var(--mc-primary); text-decoration: none; font-weight: 600;">Esqueceu a senha?</a></span>
                            </#if>
                        </div>

                        <input tabindex="2" id="password" class="pf-v5-c-form-control" name="password" type="password" autocomplete="off"
                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                               placeholder="Sua senha"
                        />
                    </div>

                    <div class="pf-v5-c-form__group" style="margin-top: 15px;">
                        <#if realm.rememberMe && !usernameEditDisabled??>
                            <div class="checkbox">
                                <label style="font-size: 0.85rem; color: var(--mc-text-light); cursor: pointer; display: flex; align-items: center; gap: 8px;">
                                    <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" <#if login.rememberMe??>checked</#if>> Manter conectado
                                </label>
                            </div>
                        </#if>
                    </div>

                    <div id="kc-form-buttons" class="pf-v5-c-form__group">
                        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                        <input tabindex="4" class="pf-v5-c-button pf-m-primary" name="login" id="kc-login" type="submit" value="Entrar no Sistema"/>
                    </div>
                </form>
            </#if>
          </div>
            
          <#if realm.password && social.providers??>
                <div id="kc-social-providers" style="margin-top: 20px; text-align: center;">
                    <div style="display: grid; gap: 10px;">
                        <#list social.providers as p>
                            <a id="social-${p.alias}" class="pf-v5-c-button pf-m-secondary" style="width: 100%; border: 1px solid var(--mc-border); background: white; color: var(--mc-text); text-decoration: none; display: flex; align-items: center; justify-content: center; height: 44px; border-radius: 6px;" href="${p.loginUrl}">
                                <#if p.iconClasses?has_content><i class="${p.iconClasses!}" aria-hidden="true" style="margin-right: 10px;"></i></#if>
                                <span>${p.displayName!}</span>
                            </a>
                        </#list>
                    </div>
                </div>
          </#if>

          <div class="mc-footer-links">
            <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                <div id="kc-registration" style="margin-bottom: 15px;">
                    <span style="color: var(--mc-text-light);">Ainda não tem conta?</span> <a tabindex="6" href="${url.registrationUrl}" style="color: var(--mc-primary); font-weight: 700; text-decoration: none;">Cadastre-se</a>
                </div>
            </#if>
            
            <a href="https://master-clinic-landing-page-latest.onrender.com/" class="master-clinic-test-link" target="_blank">
                Interessado em transformar a gestão da sua clínica? Conheça mais.
            </a>
          </div>
        </div>
    <#elseif section = "info" >
        <#-- Seção info removida para evitar problemas de visibilidade -->
    </#if>
</@layout.registrationLayout>
