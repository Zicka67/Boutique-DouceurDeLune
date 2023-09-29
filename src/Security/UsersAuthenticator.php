<?php

namespace App\Security;

use Symfony\Bundle\SecurityBundle\Security;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Http\Authenticator\AbstractLoginFormAuthenticator;
use Symfony\Component\Security\Http\Authenticator\Passport\Badge\CsrfTokenBadge;
use Symfony\Component\Security\Http\Authenticator\Passport\Badge\UserBadge;
use Symfony\Component\Security\Http\Authenticator\Passport\Credentials\PasswordCredentials;
use Symfony\Component\Security\Http\Authenticator\Passport\Passport;
use Symfony\Component\Security\Http\Util\TargetPathTrait;

class UsersAuthenticator extends AbstractLoginFormAuthenticator
{
    use TargetPathTrait;

    public const LOGIN_ROUTE = 'app_login';

    public function __construct(private UrlGeneratorInterface $urlGenerator)
    {
    }

    public function authenticate(Request $request): Passport
    {
        // Récupère l'e-mail depuis la requête HTTP. Utilise une chaîne vide si aucun e-mail n'est fourni.
        $email = $request->request->get('email', '');

        // Stocke l'e-mail dans la session sous la clé LAST_USERNAME.
        // C'est utile pour pré-remplir le champ e-mail en cas d'échec de l'authentification.
        $request->getSession()->set(Security::LAST_USERNAME, $email);
    
        // Crée et retourne un Passport avec les informations d'authentification.
        return new Passport(
            // Le badge UserBadge représente l'identifiant de l'utilisateur, dans ce cas, l'e-mail.
            new UserBadge($email),
            
            // Le badge PasswordCredentials contient le mot de passe fourni par l'utilisateur.
            new PasswordCredentials($request->request->get('password', '')),
            
            [
                // Le badge CsrfTokenBadge est utilisé pour protéger contre les attaques CSRF.
                // Il s'assure que la requête est volontairement initiée par l'utilisateur et non par un site tiers malveillant.
                new CsrfTokenBadge('authenticate', $request->request->get('_csrf_token')),
            ]
        );
    }

    public function onAuthenticationSuccess(Request $request, TokenInterface $token, string $firewallName): ?Response
    {
        if ($targetPath = $this->getTargetPath($request->getSession(), $firewallName)) {
            return new RedirectResponse($targetPath);
        }

        // For example:
        return new RedirectResponse($this->urlGenerator->generate('home'));
        // throw new \Exception('TODO: provide a valid redirect inside '.__FILE__);
    }

    protected function getLoginUrl(Request $request): string
    {
        return $this->urlGenerator->generate(self::LOGIN_ROUTE);
    }
}
