# Template d'équipe d'agents Forem

## Périmètre

Cette version implémente Maxime, le sous-agent UMLCreator et Antoine dans GitHub Copilot pour VS Code. Elle ne crée pas les cinq autres agents et ne déploie aucun service Azure.

| Agent | Responsabilité | Statut |
| --- | --- | --- |
| Maxime | Clarifier le besoin métier et rédiger les PBI ADO de type Support Request | Implémenté ; lectures, création initiale, conversion et commentaires vérifiés le 2026-10-20 |
| UMLCreator | Produire des diagrammes UML en Mermaid pour l'agent principal | Configuré ; invocation depuis VS Code à vérifier |
| Simone | Concevoir l'expérience et les interfaces utilisateur | Prévu, non implémenté |
| Joao | Définir l'architecture et les décisions techniques | Prévu, non implémenté |
| Sébastien | Implémenter les fonctionnalités FullStack | Prévu, non implémenté |
| Antoine | Analyser les risques et exigences de sécurité | Configuré : revue, rapport `SECURITY_REVIEW.MD` et corrections locales après validation humaine explicite |
| Anne-Cécile | Définir et exécuter les tests, relever les anomalies | Prévu, non implémenté |
| Vincent | Finaliser les livrables et la documentation | Prévu, non implémenté |

Les frontières détaillées de Simone, Joao, Sébastien, Anne-Cécile et Vincent restent à valider. Aucun relais automatique n'est configuré entre les agents principaux.

`Antoine` effectue une revue statique en lecture seule du code, des dépendances, de l'IaC et de la configuration pertinente. Il consulte uniquement les pages publiques officielles OWASP utiles à la revue et n'envoie aucun contenu du dépôt vers un service externe. Il utilise OWASP Top 10:2025 comme cadre de sensibilisation pour les risques Web, en considérant seulement les catégories applicables et sans en faire une checklist exhaustive ou une certification. Il restitue des constats étayés, leur sévérité et leur niveau de confiance, puis recommande des corrections sans modifier le code ni tenter d'exploiter une vulnérabilité. Pour les périmètres API ou LLM, il signale que ce Top 10 ne couvre pas à lui seul les risques spécialisés. Il ne prétend pas certifier l'absence de risque.

Par défaut, les revues rattachées au dépôt créent ou actualisent uniquement `SECURITY_REVIEW.MD` à la racine, avec ce nom exact. Antoine relit le rapport existant et préserve les notes humaines et résultats non réexaminés ; une revue partielle n'efface pas les conclusions des autres périmètres. Il n'y copie aucun secret, donnée personnelle ou contenu métier sensible, ne crée aucun commit et vérifie le fichier après écriture. L'accès de l'outil `edit` n'est pas techniquement limité aux fichiers autorisés : cette restriction reste une consigne. Les consultations métier par Maxime ne déclenchent aucune écriture de rapport ni correction.

### Corrections après validation humaine

Antoine peut appliquer des recommandations locales après présentation et validation humaine explicite d'un plan précisant les constats, fichiers ciblés, modifications, impacts et vérifications nécessaires. Une demande de revue, un rapport ou l'accord d'un autre agent ne suffit pas. En délégation, l'appelant doit transmettre cette validation et son périmètre. Tout élargissement nécessite une nouvelle validation.

Il préserve les contributions existantes et actualise le rapport avec les modifications, vérifications et risques résiduels. Il reste sans terminal, exécution de tests, scanner, déploiement ou accès ADO. Les tests doivent être exécutés par le responsable humain ou un agent autorisé ; une correction seulement relue statiquement reste indiquée comme en attente de validation d'exécution. Les réglages de permissions ADO ou de protections VS Code restent des actions du responsable humain : modifier les consignes ne crée pas un contrôle technique.

Pour une code review sécurité, Antoine tient compte des configurations, intégrations CI et rapports locaux de SonarQube/SonarCloud et des autres outils de validation présents. Son rapport distingue les outils configurés des résultats réellement disponibles, indique leurs sources, leur actualité connue et les limites de couverture (exclusions, règles désactivées, rapports absents ou anciens). Les alertes de qualité ou Security Hotspots ne deviennent pas automatiquement des vulnérabilités : Antoine recoupe les éléments et regroupe les doublons. Il ne lance aucun scanner et n'accède pas aux tableaux de bord distants ; un export expurgé peut être fourni si nécessaire.

Le sous-agent `UMLCreator` produit des diagrammes UML en Mermaid lorsqu'il est sollicité directement ou par un agent autorisé. Il est configuré en lecture seule et ne modifie ni ticket ni fichier : l'agent qui l'a sollicité relit et insère le résultat dans un livrable Markdown adapté. Maxime n'est pas autorisé à déléguer à UMLCreator pour la rédaction ou l'affinage des PBI ADO : les tickets ne rendant pas Mermaid, il décrit les flux en texte clair et ne publie pas de blocs de source Mermaid. Le futur agent Joao pourra être autorisé à utiliser UMLCreator pour un diagramme d'architecture destiné à `ARCHITECTURE.md`. Un agent principal doit autoriser explicitement UMLCreator dans sa liste `agents`. Le modèle de UMLCreator n'est pas fixé tant que son libellé exact n'a pas été vérifié dans VS Code. Les maquettes d'écran ne sont mentionnées dans les tickets de Maxime que lorsqu'elles sont fournies dans le besoin initial.

### Consultation d'Antoine par les autres agents

Antoine est utilisable directement et comme sous-agent. L'intensité ci-dessous décrit la place de sa consultation, pas le niveau de sévérité des risques.

| Appelant | Intervention d'Antoine | Configuration |
| --- | --- | --- |
| Maxime — ponctuelle | Questions et exigences de sécurité du besoin, critères proposés ; pas de revue du code ni de décision d'architecture | Autorisé : outil `agent`, `agents: [Antoine]` |
| Joao — intermédiaire | Risques de la solution, frontières de confiance, flux et permissions | À câbler lors de la création de Joao : outil `agent` et `Antoine` dans `agents` |
| Sébastien — prioritaire | Revue de sécurité des implémentations et relecture des corrections pertinentes | À câbler lors de la création de Sébastien : outil `agent` et `Antoine` dans `agents` |

L'appelant transmet un contexte confirmé et un objectif délimité, puis relit l'avis avant de l'intégrer à son livrable. En revue, Antoine ne modifie que son rapport local ; toute correction suit la procédure de validation humaine ci-dessus, sans accès ADO ni délégation. Sa consultation ne vaut pas validation humaine et ne permet pas de contourner les limites de l'appelant.

## Installation dans un dépôt

1. Intégrer `.github/copilot-instructions.md`, `.github/agents/maxime.agent.md`, `.github/agents/umlcreator.agent.md`, `.github/agents/antoine.agent.md`, `.vscode/mcp.json` et `docs/` au dépôt cible. Fusionner les configurations existantes au lieu de les écraser.
2. Ouvrir le dépôt dans une version à jour de VS Code avec GitHub Copilot Chat et les agents personnalisés activés. N'accorder la confiance à l'espace de travail qu'après vérification de son contenu.
3. Ouvrir `.vscode/mcp.json` et utiliser l'action de démarrage du serveur `ado`, ou la commande VS Code `MCP: List Servers` puis choisir `ado` et le démarrer.
4. Autoriser la connexion et s'authentifier dans le parcours Microsoft Entra proposé par VS Code, avec un compte ayant accès à l'organisation `leforem`. Ne communiquer aucun secret à l'agent.
5. Choisir Maxime dans le sélecteur d'agents. Vérifier que le modèle `Claude Opus 5.5` est reconnu et accessible avec l'abonnement. Le libellé provient de l'utilisateur et n'a pas été vérifié par une API de catalogue. S'il n'est pas reconnu, sélectionner le libellé exact dans VS Code et adapter le champ `model` ; ne pas supposer un remplacement équivalent.
6. Vérifier que les outils `ado` sont visibles. Si nécessaire, actualiser la découverte des outils ou ouvrir une nouvelle conversation après démarrage du serveur.

Le serveur distant officiel utilise `https://mcp.dev.azure.com/leforem`. Il ne nécessite ni installation Node.js, ni PAT dans le dépôt. L'organisation et le compte doivent être rattachés à Microsoft Entra ; l'accès peut dépendre des politiques et consentements du tenant Forem. Aucun compte ni consentement administrateur n'est créé par ce template.

### Installer uniquement Antoine pour une code review sécurité

Copier `.github/agents/antoine.agent.md` dans le dépôt cible et fusionner les règles communes de `.github/copilot-instructions.md` avec les instructions existantes, sans les écraser. Aucun serveur MCP ADO ni agent Maxime n'est nécessaire à son utilisation directe. Ouvrir le dépôt dans VS Code, sélectionner Antoine dans une nouvelle conversation et préciser le périmètre de revue. Les configurations et rapports de validation accessibles localement sont pris en compte sans ajouter de secret ni de connexion à une plateforme d'analyse.

## Vérification initiale sans écriture ADO

Demander à Maxime :

> Vérifie uniquement en lecture l'accès au projet Tools Backlogs et identifie l'équipe et le chemin de zone correspondant à Tools Backlogs\Squads\Prague. Consulte Ressources et toutes ses pages enfants, ainsi que les correspondances OMA. Mets à jour ton cache avec les faits non sensibles vérifiés et leurs sources. Ne crée et ne modifie aucun ticket. Signale les informations impossibles à établir.

Cette vérification a été effectuée le 2026-10-20 : équipe `Squad Prague`, chemin `Tools Backlogs\Squads\Prague`, type `User story`, champs rédactionnels, racine Ressources et neuf descendants. Les sources et révisions sont consignées dans `docs/maxime/references.md`. Répéter cette procédure après installation dans un autre environnement ou pour actualiser les références ; l'authentification de chaque utilisateur reste nécessaire.

Arbitrages utilisateur actuels : tous les PBI créés par Maxime restent dans Prague et utilisent uniquement **Support Request**. Le libellé initialement demandé, `Service Request`, a été refusé par ADO ; `Support Request` a ensuite été confirmé par l'utilisateur et vérifié. Le type `User story` mentionné dans le premier contrôle est désormais historique, pas un choix de repli. Les titres suivent `[Code OMA][NNN].[NN] - [Fonctionnalité]`, par exemple `LDC001.01`. LDC est uniquement un exemple. La règle d'incrémentation n'étant pas définie, Maxime demande le numéro si nécessaire et vérifie les doublons avant création.

La description commence par **Expression du besoin**. INVEST reste un contrôle interne, jamais une section publiée. Les critères sont placés uniquement dans Acceptance Criteria ; aucune section du même nom ni section État de l'affinage n'est ajoutée dans Description. Les questions de discussion privilégient un ton naturel, des sujets séparés, des paragraphes courts et des puces, sans rappels de procédure répétitifs.

Pour vérifier les écritures, désigner explicitement un ticket de test et autoriser un commentaire de test. Contrôler le résultat dans ADO. Ne pas tester sur un ticket métier sans accord. L'installation et la validation locale des fichiers ne prouvent pas le fonctionnement de l'authentification ou des écritures ADO.

Un test concret explicitement demandé a réussi le 2026-10-20 : création initiale d'une `User story` dans Prague, puis conversion en `Support Request` et correction de Description à la suite du retour utilisateur. La mise à jour a utilisé un test de révision ; la relecture et la comparaison ont confirmé la conservation exacte des Acceptance Criteria, du titre, de la zone et de l'état. Le commentaire a été réécrit selon la présentation utilisateur et son rendu vérifié. Les valeurs `New`, priorité `3` et `Change Request = false` avaient été appliquées au type initial ; elles ne définissent pas les défauts d'une création directe en `Support Request`, encore non testée. Aucun conflit de concurrence n'a été provoqué. Aucun contenu métier du ticket n'est copié dans ce guide ou le cache.

## Utilisation

Exemples de demandes après vérification de la connexion :

### Créer un PBI

> Je souhaite créer un PBI Support Request pour [application] : [besoin réel]. Vérifie les conventions, crée le ticket dès que les informations obligatoires sont connues et pose les questions restantes dans ses commentaires.

### Affiner un ticket existant

> Affine le ticket [identifiant]. Lis d'abord son contenu et ses commentaires, puis pose les questions encore ouvertes sans modifier les décisions établies.

### Lire les nouvelles réponses

> Reprends l'affinage du ticket [identifiant] à partir des nouvelles réponses dans ADO.

### Actualiser le cache

> Actualise complètement ton cache depuis Ressources et ses descendants. Ne modifie aucun ticket.

Maxime ne surveille pas les commentaires en arrière-plan : le relancer pour lire les réponses. Les réponses fournies dans VS Code sont synthétisées dans le ticket. La validation du contenu reste humaine et ne déclenche pas automatiquement un changement d'état.

## Outils et confidentialité

La configuration `X-MCP-Tools` expose uniquement les outils de lecture nécessaires et les outils d'écriture de tickets/commentaires. Elle n'expose ni les écritures wiki, ni les dépôts, ni les pipelines. Les droits réels restent ceux du compte connecté et des autorisations OAuth.

Certains outils regroupent plusieurs actions : par exemple `wit_backlog` inclut aussi le réordonnancement. Leur disponibilité ne vaut pas autorisation d'utiliser toutes leurs actions. Maxime ne les emploie qu'en lecture, sauf les écritures d'US et commentaires décrites dans son rôle. Pour une garantie forte, appliquer également les permissions ADO appropriées et les confirmations d'outils de VS Code ; ne pas activer une approbation globale sans examen.

Les outils locaux `read` et `edit` ne sont pas limités techniquement à un dossier. Le périmètre documentaire de Maxime est donc une consigne, pas une sandbox. Il ne dispose pas du terminal ; sa délégation est limitée à Antoine pour les exigences de sécurité du besoin. La restriction de consultation Web d'Antoine aux sources OWASP est également une consigne, pas un filtrage technique des domaines.

Le cache `docs/maxime/references.md` est destiné à être versionné uniquement dans un dépôt dont l'accès est compatible avec la confidentialité des informations Forem. Ne pas publier ce cache, les correspondances internes ou les paramètres d'organisation dans un dépôt public sans autorisation. Vérifier son contenu avant chaque commit ; l'agent ne réalise pas les commits.

## Dépannage

- Serveur absent : vérifier que `.vscode/mcp.json` est bien au niveau du dépôt ouvert et que les serveurs MCP sont autorisés par les politiques VS Code.
- Authentification refusée : vérifier le compte, le rattachement Entra, les accès Forem et les politiques du tenant. Les secrets restent dans le parcours d'authentification, jamais dans la conversation.
- Outils absents : redémarrer le serveur après modification de la configuration et renouveler leur découverte dans Copilot. Vérifier les noms officiels avant de modifier la liste autorisée.
- Wiki ou tickets inaccessibles : faire vérifier les droits par le responsable ADO. Maxime doit signaler la limite et ne pas déduire le contenu manquant.
- Modèle indisponible : vérifier l'abonnement et le nom exact dans le sélecteur de modèles.

Références officielles consultées pour la configuration : [serveur MCP distant ADO](https://learn.microsoft.com/en-us/azure/devops/mcp-server/remote-mcp-server) et [agents personnalisés VS Code](https://code.visualstudio.com/docs/copilot/customization/custom-agents).

## Suites possibles

Vérifier dans une nouvelle conversation VS Code qu'Antoine est reconnu, appelable par Maxime sans écriture pour une question de sécurité du besoin, et que ses revues du dépôt n'écrivent que `SECURITY_REVIEW.MD` à la racine sans validation de correction. Vérifier séparément qu'un plan validé n'autorise que les corrections approuvées et leur suivi dans le rapport. Définir ensuite les entrées, livrables et outils des futurs agents ; câbler la consultation d'Antoine pour Joao et Sébastien selon le tableau ci-dessus. Ajouter `UMLCreator` à la liste `agents` de Joao uniquement si le relais de diagrammes d'architecture vers `ARCHITECTURE.md` est souhaité. Ne pas élargir les droits de Maxime au-delà de son rôle.
