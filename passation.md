# Passation de la conversation

## Point de reprise — 2026-11-25

À lire en premier dans une nouvelle session. Ce bloc est l'état courant ; tout ce qui suit est un journal historique. En cas d'écart, ce bloc, les fichiers d'agents et `docs/guide-equipe.md` font foi.

### Objectif

Construire une équipe d'agents GitHub Copilot pour VS Code (template à copier dans un dépôt), utilisable en contexte Forem ou sur un projet personnel. L'utilisateur est le PO. À terme, les agents enchaînent les étapes en autonomie, orchestrés par Philippe, et ne remontent à l'utilisateur que les validations obligatoires et les questions qu'aucun agent ne peut trancher. L'utilisateur nomme cet objectif la **dark factory** (terme adopté le 25/11 dans le guide et ici).

### Agents

| Agent | Fichier | Modèle | État |
| --- | --- | --- | --- |
| Maxime (besoin, bugs, `PROJET.md`, `ANALYSE.md`) | `.github/agents/maxime.agent.md` | Claude Opus 5.5 | Mode ADO Forem testé (10/2026) ; mode local et processus non testés |
| Simone (UI/UX) | `.github/agents/simone.agent.md` | Claude Sonnet 5.5, effort medium | Créée le 23/11, non testée |
| Joao (architecture, contexte technique, relecture PR, qualification des anomalies) | `.github/agents/joao.agent.md` | Claude Opus 5.5, effort high | Écriture wiki testée le 19/11 ; rôle dans le processus non testé |
| Antoine (sécurité) | `.github/agents/antoine.agent.md` | non fixé | Premier test accepté (10/2026) ; posture de constatateur à retester |
| UMLCreator (diagrammes Mermaid) | `.github/agents/umlcreator.agent.md` | non fixé | Délégation imbriquée testée le 23/11 |
| Sébastien, Anne-Cécile, Vincent, Léo, Philippe | — | — | Non créés ; Léo et Philippe déjà spécifiés dans le guide |

### Fichiers clés

- `.github/copilot-instructions.md` : règles communes, dont « Configuration du projet » (`PROJET.md` lu par tous, écrit par Maxime seul) et « Autonomie et remontée des questions » (libellé « À remonter à l'utilisateur », pas de rappel de l'appelant).
- `docs/guide-equipe.md` : référence fonctionnelle (rôles, processus, Philippe, Léo, modes de suivi, harnesses, hook, installation, points ouverts).
- `docs/maxime/` : `modele-projet.md` (modèle de `PROJET.md` + exemple Forem), `modele-analyse.md` (modèle de `ANALYSE.md`), `modele-us.md` (rubriques d'un besoin), `references.md` (cache Forem uniquement).
- `.github/hooks/route-securite.json` + `scripts/route-securite.ps1` : rappel vers Antoine si `ARCHITECTURE.md`, `ADR*.md` ou `contexte-technique.md` contient « Base de données », « API externe », « Authentification » ou « Données personnelles ».
- `.vscode/mcp.json` : serveur MCP distant `ado` (`https://mcp.dev.azure.com/leforem`), outils listés dans `X-MCP-Tools`, dont `wiki_upsert_page`.

### Prochaine étape décidée : test sur un petit projet local

Avant de concevoir Sébastien. Rien n'est encore lancé.

1. Créer un nouveau dossier (petite application Web, par exemple une liste de tâches), l'ouvrir comme espace de travail VS Code, harness Copilot. Y copier `.github/` et `docs/`, sans `.vscode/mcp.json`, `PROJET.md` ni `ANALYSE.md`.
2. **Maxime** : créer `PROJET.md` (contexte Autre, suivi Local, wiki Aucun), puis `ANALYSE.md` avec `FCT-001` ; vérifier découpage, questions et réponses, validation du PO, statut `Validé par le PO`.
3. **Simone** : proposition de 2-3 design systems et de la charte (`docs/ux/charte.md`), validation par l'utilisateur ; parcours et maquette dans `docs/ux/FCT-001/` ; questions métier à Maxime ; critères UX intégrés par Maxime dans `ANALYSE.md`.
4. **Joao** (mode conception) : `ARCHITECTURE.md` (projet entier), ADR `Proposé` si l'architecture change, `docs/fonctionnalites/FCT-001/contexte-technique.md`, diagrammes délégués à UMLCreator.
5. **Antoine** : doit être appelé si la fonctionnalité touche à l'authentification ou aux données personnelles ; vérifier le déclenchement réel du hook (rappel `additionalContext`).
6. Relever les écarts, corriger agents et guide, puis mettre à jour ce bloc.

L'utilisateur lance le test lui-même. Le 25/11, l'assistant a préparé le protocole (prompts, réponses à donner, points de contrôle, `git status` après chaque étape, une conversation par étape, test isolé du hook) dans un fichier de session hors dépôt : `test-local-dark-factory.md`. Projet de test proposé : « Liste de tâches », code `TDL`, suivi Local, wiki Aucun. Point à observer, non tranché par les règles actuelles : Maxime intègre-t-il directement les critères UX de Simone dans un besoin déjà `Validé par le PO`, ou demande-t-il un arbitrage ? Résultat du test : non connu à ce jour.

### Décisions et points encore ouverts

- **À trancher en concevant Philippe** : en mode ADO, qui transmet à Simone la synthèse du ticket ; passage à Joao possible ou non avec des maquettes provisoires (charte non validée) ; Joao appelle-t-il Sébastien directement pour une correction ou passe-t-il par Philippe ; qui demande une publication wiki dans le processus autonome ; outils exacts de Philippe et Léo.
- **Choix faits par l'assistant, jamais validés explicitement** : contexte technique toujours écrit dans un fichier, même avec ADR ; livrables par identifiant (`docs/ux/<ID>/`, `docs/fonctionnalites/<ID>/`) ; bug sans lien ADO vers le besoin ; identifiants locaux plus grand + 1, jamais réutilisés ; statuts locaux des besoins et bugs ; wiki local par défaut `docs/wiki/`. L'utilisateur ne les a pas contestés ; les confirmer si l'occasion se présente.
- **Ordre de travail proposé, non validé** : Sébastien, Anne-Cécile, Vincent, puis Léo et Philippe (Philippe n'est créé qu'une fois les trois premiers disponibles : décision utilisateur).
- **Toujours en attente** : appel d'Antoine systématique en mode documentation, ou seulement pour les dépôts avec dépendances externes au SI.
- **Contexte Forem** : type, zone et convention de titre des bugs ADO à renseigner dans `PROJET.md` ; libellés exacts des modèles à vérifier dans le sélecteur VS Code.
- **Git** (vérifié le 25/11) : tout est commité jusqu'à `36e60da` sur la branche `add_joao`, y compris Simone et les modèles de Maxime. `README.md` a été vidé au commit `df21014` puis retiré du dépôt : point clos. `route-securite.json` a été migré au format Copilot hors des interventions de l'assistant.
- **Wiki CRM (hors template)** : contradictions signalées sur Dossiers Représentation (recalcul §3 vs §4 ; statut vs cases non cochées) et Service Opérationnel (Gufid des autres codes Gestion Accès, usage des recherches PCU) à faire arbitrer par le PO. Dernier `etag` constaté de Service Opérationnel : `adeee7f948be111bce478c6f40699559a7d4785d` (modifiée par un tiers après le 19/11).

### Méthode de travail attendue par l'utilisateur

- Réponses et documents en français, ton direct et concis (règles « Style de rédaction »).
- **Après chaque évolution, ne laisser aucune incohérence** : propager le changement dans tous les fichiers concernés (instructions communes, agents, guide, documents de Maxime, passation), puis relire. L'utilisateur l'a demandé explicitement deux fois.
- Poser les décisions structurantes avec `ask_user` au lieu de supposer ; signaler clairement les choix faits sans validation.
- Vérifier dans la documentation officielle avant d'affirmer un comportement de VS Code / Copilot ; dire ce qui n'est pas vérifié. Ne pas présenter un test simulé comme un test réel.
- Ne rien commiter sans demande. Ne rien créer par anticipation (agents futurs).
- Pour modifier les fichiers d'agents ou de configuration, l'utilisateur passe par l'agent Copilot par défaut (Joao refuse d'écrire hors de son périmètre).

### Repères techniques

- **Harness Copilot** (cible) : ignore `agents`, `handoffs` et `argument-hint` ; les délégations reposent sur les consignes ; délégation via l'outil `task`, imbrication sur deux niveaux vérifiée. Harness Local déprécié (février 2027). Indications grisées dans les `.agent.md` : normales, ne pas supprimer ces champs ni ajouter `target` (décision utilisateur).
- **Hook Copilot `postToolUse`** : entrée `toolArgs` (Local : `tool_input`), sortie `additionalContext` ; ne bloque pas. Script compatible avec les deux formats ; tester avec des charges JSON simulées par `powershell -File` (voir journal du 23/11).
- **`wiki_upsert_page`** remplace toute la page : relire, transmettre l'`etag`, syntaxe `::: mermaid` / `:::` dans les wikis ADO.
- **ADO** : si 401 ou erreur d'authentification, demander `/mcp auth ado` ou un redémarrage du serveur ; un échec ponctuel en sous-agent a été observé le 23/11 puis a disparu.
- **Fichiers** : UTF-8 sans BOM, fins de ligne CRLF (une réécriture complète doit les conserver). Sous PowerShell 5.1, les accents s'affichent mal mais les fichiers sont corrects ; le script du hook évite les accents (lu en ANSI).
- Vérifier le format avec `git --no-pager diff --check` après chaque série de modifications.

## Journal détaillé du 23/11 (historique)

### Ancienne liste « Où en est-on » — 23/11 matin

- Agents en place : Maxime, UMLCreator, Joao, Antoine et Simone (créée le 23/11). Sébastien, Anne-Cécile et Vincent ne sont pas commencés ; ne pas les créer par anticipation.
- Restent à faire à cette date : retester Antoine ; tester les modes de Joao ; tester le hook ; trancher l'appel systématique à Antoine ; tester Simone et la publication wiki de Maxime ; câbler Sébastien ; trancher les points ouverts du processus. Voir le point de reprise ci-dessus pour l'état courant.

### Processus cible de l'équipe — 23/11

- Décrit dans `docs/guide-equipe.md`, section « Processus de l'équipe » : Maxime (besoin, découpage en une responsabilité par ticket) → Simone (UX) → Joao (ADR si changement d'architecture, sinon contexte à Sébastien ; Antoine au besoin) → Sébastien (branche depuis `main`/`master`, PR validée par Joao et Antoine puis poussée) → Anne-Cécile (tests, rapport à Joao) → boucle Joao qualifie / Maxime crée le bug / Sébastien corrige → Vincent (documentation projet et processus métier).
- Décisions de l'utilisateur :
  - agents autonomes ; question ou validation remontée à l'utilisateur seulement si aucun agent n'est responsable ou ne sait répondre ; jamais d'invention ;
  - questions métier de Simone : Maxime d'abord, puis l'utilisateur ; réponse documentée dans la discussion du ticket ;
  - `ARCHITECTURE.md` = documentation du projet entier, évolutive en conception de projet ; ADR seulement si une fonctionnalité change l'architecture ;
  - seul Maxime crée les tickets, y compris les bugs, sur la base des éléments de Joao issus du rapport d'Anne-Cécile ; une responsabilité par agent ;
  - Joao : documentation d'architecture technico-fonctionnelle ; Vincent : projet et processus métier.
- Points ouverts initiaux, tranchés le 23/11 :
  - validations humaines conservées : ticket prêt (Maxime), plan de correction d'Antoine, charte graphique de Simone, PR avant fusion (en plus de Joao et Antoine) ;
  - écritures wiki de Joao, Maxime et Simone désormais autonomes, sans confirmation par écriture ; relecture, `etag`, périmètre, interdiction de supprimer et relecture après écriture conservés ;
  - passage d'étape par un agent chef d'orchestre appelant chaque agent comme sous-agent ;
  - Sébastien fusionne la PR après validations ;
  - type et zone des bugs définis par projet.
- Restent ouverts : conception du chef d'orchestre (nom, outils, blocages, reprise) et vérification des sous-agents imbriqués dans VS Code ; adaptations de Simone, Joao et Maxime, dont le retrait des confirmations wiki ; configuration ADO de Maxime propre au Forem.
- Orchestrateur décidé le 23/11 : **Philippe**, `Claude Sonnet 5.5`, coordination uniquement (aucun livrable, aucune écriture ADO), une fonctionnalité à la fois, démarrage après le travail direct de l'utilisateur avec Maxime (à partir de l'identifiant du ticket), fichier d'état propre corrélé à la reprise avec le livrable de l'étape en cours, au plus 3 cycles de correction avant remontée. Nouvel agent **Léo** pour le contrôle qualité de chaque livrable en fin d'étape, avant passage à l'agent suivant. Précisions du 23/11 : fichier d'état `docs/fonctionnalites/<ID>/etat.md` ; Philippe créé seulement quand Sébastien, Anne-Cécile et Vincent existeront. Léo : `Claude Sonnet 5.5`, lecture ADO (tickets, wiki) sans écriture ; contrôle conformité au ticket, complétude, cohérence avec les étapes précédentes, respect des règles, points ouverts bloquants ; en cas de refus, retour à l'agent auteur avec les écarts, 2 essais puis remontée. Imbrication vérifiée le 23/11 (voir plus haut). Non créés. Ordre de travail proposé, non validé : Sébastien, Anne-Cécile, Vincent, puis Léo et Philippe.
- Aucun fichier d'agent n'a été modifié pour ce processus. Les consignes de Joao, Maxime et Simone exigent encore une confirmation avant chaque écriture wiki, tant qu'elles ne sont pas adaptées.
- **Adaptations faites le 23/11 après-midi** (détail dans `docs/guide-equipe.md`, « Adaptations du 2026-11-23 ») :
  - règle commune « Autonomie et remontée des questions » dans `.github/copilot-instructions.md` ;
  - Maxime : un ticket par responsabilité, réponses aux questions métier consignées dans le ticket, création des bugs, intégration autonome des compléments de Joao et Simone hors changement métier, wiki sans confirmation ; ligne « Bugs » ajoutée à `docs/maxime/references.md` (type, zone et titre à définir) ;
  - Simone : `agents` + Maxime et Joao, livrables dans `docs/ux/<ID>/`, validation de la charte remontée, wiki sans confirmation ;
  - Joao : section « Rôle dans le processus de l'équipe » (conception d'une fonctionnalité avec `docs/fonctionnalites/<ID>/contexte-technique.md`, relecture des PR, qualification des anomalies), wiki sans confirmation ; `agents` inchangé, Sébastien et Anne-Cécile cités en consigne seulement.
  - Choix faits sans décision explicite de l'utilisateur, à confirmer : contexte technique écrit par Joao dans un fichier, même avec un ADR ; livrables UX rangés par identifiant de ticket ; bug sans lien ADO vers le ticket (outil de lien non exposé).
  - Décidé ensuite le 23/11 : un ADR doit être `Accepté` par un humain avant le développement (Joao et guide mis à jour).
  - Restent ouverts : mode sans ADO (`ANALYSE.md`) et indépendance de Maxime vis-à-vis du Forem, en cours de conception.
- **Modes de suivi et indépendance du Forem — 23/11** : décisions de l'utilisateur : `PROJET.md` à la racine (contexte, code application, mode de suivi ADO/Local, mode de wiki ADO/Local/Aucun, indépendants) ; mode local par un seul `ANALYSE.md` (besoins `FCT-NNN`, questions et réponses, historique, « Suivi des bugs » `BUG-NNN`) ; périmètre limité à Maxime pour l'instant ; pour Joao plus tard, wiki Architecture DDI seulement en contexte Forem.
  - Fait : `maxime.agent.md` réécrit (sections « Configuration du projet », « Mode de suivi local », « Mode de suivi ADO », « Contexte Forem » regroupant toutes les règles Forem conservées, création et suivi des bugs dans les deux modes, publication ADO/locale/aucune) ; nouveaux modèles `docs/maxime/modele-projet.md` (avec exemple Forem) et `docs/maxime/modele-analyse.md` ; `modele-us.md` rendu générique ; `references.md` limité au contexte Forem ; guide (section « Configuration du projet et modes de suivi », installation).
  - Choix faits sans décision explicite : pas de bascule automatique vers le local si ADO est indisponible ; identifiants locaux calculés à partir du fichier (plus grand + 1, jamais réutilisés) ; statuts locaux des besoins (`En affinage`, `Validé par le PO`, `Terminé`, `Abandonné`) et des bugs (`Ouvert`, `En correction`, `À retester`, `Fermé`) ; wiki local par défaut `docs/wiki/`.
  - À faire : adapter Joao, Simone et les agents suivants à `PROJET.md` et au mode local (lecture de `ANALYSE.md` au lieu du ticket, wiki selon le mode). Tester Maxime en mode local.
  - Fait ensuite le 23/11 (validé par l'utilisateur) : `PROJET.md` partagé par toute l'équipe. Règle commune « Configuration du projet » dans `.github/copilot-instructions.md` (lecture par tous, écriture par Maxime seul, besoins et bugs selon le mode, publication selon le mode de wiki, pas de bascule automatique, règles Forem seulement en contexte Forem). Joao : lecture du besoin dans ADO ou `ANALYSE.md`, section « Wikis » par mode, principes DDI et gouvernance ADR Forem seulement en contexte Forem, code application des ADR depuis `PROJET.md`. Simone : besoin dans ADO ou `ANALYSE.md`, publication selon le mode. Les futurs agents héritent de la règle commune. Reste à tester en mode local.
- **Revue approfondie de Joao et Simone — 23/11** : corrigé : vocabulaire « ticket » dans les sources de Joao ; mode conception imposé à Joao dans le processus et pour les questions d'agents (le mode documentation par défaut aurait interdit ADR et propositions) ; section « Sécurité » d'`ARCHITECTURE.md` adaptée à la conception ; conversion des seuls délimiteurs Mermaid pour le wiki ADO (contradiction avec « sans le réécrire ») ; statuts ADR explicites hors Forem ; dossier de wiki local ajouté aux périmètres d'écriture de Joao et Simone ; Simone et Joao ne rappellent pas leur appelant pour leurs consultations. Décisions de l'utilisateur : `ARCHITECTURE.md` mis à jour avec changements marqués « Proposé (ADR X) », finalisés ou retirés selon la décision ; routage vers Antoine étendu à `contexte-technique.md` (consigne + hook, testé sur 5 cas simulés) ; en contexte Forem, Joao lit et publie dans les wikis du portefeuille indiqué par l'utilisateur, sans utiliser `PROJET.md` pour ce choix.
- Points à traiter lors de la conception de Philippe : en mode ADO, qui transmet à Simone la synthèse du ticket (elle n'a pas accès aux tickets) ; passage à Joao possible ou non avec des maquettes provisoires tant que la charte n'est pas validée ; Joao appelle-t-il Sébastien directement pour une correction ou passe-t-il par Philippe.
- Prochaine étape décidée : test sur un petit projet local (Maxime, Simone, Joao, éventuellement Antoine) avant Sébastien.
- **Passe de cohérence complète — 23/11** (demande de l'utilisateur : ne laisser aucune incohérence après chaque évolution) :
  - **Hook inopérant corrigé** : `route-securite.json` avait été migré hors de mes interventions au format Copilot (`postToolUse`, `bash`/`powershell`, `timeoutSec`). Dans ce format, l'entrée contient `toolArgs` (et non `tool_input`) et la sortie attendue est `additionalContext` (`decision: block` ignoré). Le script ne détectait donc rien. Il accepte maintenant les deux formats (y compris `toolArgs` en chaîne JSON) et émet `additionalContext` plus `decision`/`reason` pour Local ; 7 cas simulés testés. Dans Copilot, `postToolUse` ne peut ni annuler ni bloquer : c'est un rappel injecté au modèle. Source : [référence des hooks Copilot](https://docs.github.com/en/copilot/reference/hooks-reference).
  - Instructions communes : exception de publication pour Joao en contexte Forem, `ANALYSE.md` comme donnée non fiable, vocabulaire « besoin ».
  - Antoine : Simone dans la description, lecture de `ANALYSE.md` en local, verdict sur les PR avec Joao.
  - Joao : vocabulaire « besoin » partout (relais, qualification, délégations).
  - Guide : titre et introduction hors Forem ; modes, ADR, principes et écritures de Joao ; relais Maxime ↔ Joao (intégration autonome) ; Simone (besoin, publication, fichiers, rappel) ; processus (besoin, contexte technique, ADR accepté, PR validée par un humain et fusionnée, 3 cycles) ; Philippe et Léo (besoin, `ANALYSE.md`) ; points ouverts Philippe regroupés ; hook ; vérification initiale et exemples d'utilisation ; dépannage ; références.
  - Passation : sections « Configuration de Maxime / UMLCreator / Joao » et tableau des agents remis à jour ; sections inférieures marquées comme historique.
- La mention ci-dessus sur les confirmations wiki est historique : elles sont retirées.
- Indications (`Hint`) grisées dans les `.agent.md` : l'utilisateur choisit le 23/11 de ne pas ajouter `target`. **Correction du 23/11 après lecture de la documentation VS Code** : ces indications ne concernent pas « hors de VS Code » mais le harness Copilot ; le harness Local est déprécié (suppression en février 2027). Dans Copilot, `agents`, `handoffs` et `argument-hint` sont ignorés : les restrictions de délégation ne reposent que sur les consignes. Voir `docs/guide-equipe.md`, section « Harnesses Local et Copilot ». Ne pas supprimer ces champs.
- Test du 23/11 dans cette conversation (harness Copilot) : délégation imbriquée réussie (agent principal → Joao → UMLCreator via `task`) ; lecture ADO par Joao en sous-agent : un échec d'authentification puis un succès. `handoffs` écarté (Local uniquement) : orchestrateur confirmé.
- La page Wiki Service Opérationnel a été modifiée par un tiers après notre écriture du 19/11 : `etag` `adeee7f948be111bce478c6f40699559a7d4785d` constaté le 23/11.

### Création de Simone (UI/UX) — 23/11

- Décisions de l'utilisateur :
  - livrables : parcours, charte graphique, maquettes basse fidélité en Markdown, règles et critères UX ; revue UX et accessibilité sur demande ;
  - sollicitations : d'abord un besoin transmis par Maxime ; ensuite les questions d'UI/UX de Maxime, Joao et Sébastien ;
  - dossier de travail local `docs/ux/`, nettoyé à chaque nouveau projet après liste et confirmation explicite ; publication sur demande dans un wiki ADO désigné par l'utilisateur, avec les garde-fous de Joao ;
  - pas de charte Forem : Simone propose 2 ou 3 design systems, l'utilisateur choisit, puis elle fixe les design tokens ; WCAG 2.2 AA proposé par défaut, à confirmer dans la charte ; liste de contrôle (accessibilité, hiérarchie, cohérence, états, lisibilité, heuristiques de Nielsen) ;
  - applications Web uniquement ;
  - délégations : UMLCreator pour les parcours, Antoine pour un avis ciblé ; Maxime et Joao peuvent appeler Simone ;
  - modèle moins coûteux : `Claude Sonnet 5.5`, `reasoning-effort: medium` (libellé à vérifier dans VS Code) ;
  - maquettes et tickets : Maxime reprend seulement les règles et critères en texte clair, avec le chemin ou le lien de la maquette.
- Également décidé : Maxime reçoit l'écriture wiki (`ado/wiki_upsert_page`) avec les mêmes garde-fous, dans le wiki désigné par l'utilisateur. Cela remplace la restriction du 19/11.
- Fait : [.github/agents/simone.agent.md](.github/agents/simone.agent.md) créé (outils `read`, `search`, `edit`, `agent`, `ado/wiki`, `ado/wiki_upsert_page` ; `agents: [UMLCreator, Antoine]`) ; Maxime (`agents` + Simone, `wiki_upsert_page`, sections « Consultation UX de Simone » et « Publication dans un wiki Azure DevOps », règle des maquettes) ; Joao (`agents` + Simone, consultation UX) ; UMLCreator et Antoine (collaboration avec Simone) ; `docs/maxime/modele-us.md` et `references.md` (maquettes, relais UX, publication wiki) ; guide d'équipe (section « Simone — UI/UX », tableaux, installation, outils, compatibilité, vérifications). `.vscode/mcp.json` inchangé, `wiki_upsert_page` y étant déjà.
- Non vérifié : reconnaissance de Simone et de son modèle, existence d'un outil de suppression de fichier pour les agents, comportements de délégation.
- Point de structure : le guide n'avait pas de titre pour la partie Antoine ; un titre « Antoine — sécurité » a été ajouté après la section Simone.

### Écriture Wiki pour Joao — 19/11

- Demande : Joao lit, crée et met à jour des documents d'architecture technique et d'intégration dans tous les wikis du projet Dossier Unique Chercheur Emploi (CRM), sans suppression. Lecture étendue à tous les wikis de ce projet, dans la limite des droits ADO ; pas d'autres projets.
- Fait : `wiki_upsert_page` ajouté à `X-MCP-Tools` dans `.vscode/mcp.json` et à `tools` de Joao ; consignes d'écriture dans `joao.agent.md` (relecture préalable, `etag` transmis, présentation du wiki, du chemin, de l'action et du contenu, confirmation explicite avant chaque écriture, relecture après écriture, syntaxe `::: mermaid` / `:::`) ; `ado/*` de Maxime remplacé par la liste explicite de ses outils, sans `wiki_upsert_page`. Guide aligné.
- Source : outil documenté dans `docs/TOOLSET.md` de microsoft/azure-devops-mcp et sur la page Learn du serveur distant. Le code de la version locale remplace la page entière ; il récupère l'`etag` s'il est absent, d'où la consigne de toujours le transmettre.
- Vérifié le 19/11, après redémarrage du serveur MCP `ado` : l'outil est exposé, le compte a les droits d'écriture et trois mises à jour ont réussi, chacune confirmée par l'utilisateur puis relue :
  - page [Service Opérationnel](https://dev.azure.com/leforem/Dossier%20Unique%20Chercheur%20Emploi%20(CRM)/_wiki/wikis/Dossier-Unique-Chercheur-Emploi-(CRM).wiki/48019/Service-Op%C3%A9rationnel) : passage des 4 diagrammes de ` ```mermaid ` à `::: mermaid`, puis ajout de la sous-section « Recherche des PCU » (recherche par code postal avec exemple de réponse abrégé, recherche globale et échéance du 01/01/2027, état d'accessibilité Code Gestion Accès). Dernier `etag` constaté : `c3055411530b5763cb831632c12e0a14a898878c` ;
  - page [Dossiers Représentation](https://dev.azure.com/leforem/Dossier%20Unique%20Chercheur%20Emploi%20(CRM)/_wiki/wikis/Dossier-Unique-Chercheur-Emploi-(CRM).wiki/48013/Dossiers-Repr%C3%A9sentation) : 3 schémas texte convertis en Mermaid (AS-IS, TO-BE, séquence du flag) produits par UMLCreator. Dernier `etag` constaté : `b56c59c05c83bc560cd7abe4009d8d6d35614fd5`.
- Non vérifié : le rendu visuel des diagrammes dans le navigateur.
- Points signalés à l'utilisateur, non tranchés, à faire arbitrer par le PO ou l'auteur des pages :
  - Dossiers Représentation : le §3 recalcule l'employabilité dans tous les cas, le §4 seulement si le flag change ; la section « Statut » annonce qu'aucune action ne reste en suspens alors que trois cases de suivi ne sont pas cochées ;
  - Service Opérationnel : Gufid des codes Gestion Accès « Inactif », « Archivé » et « Supprimé » non fournis ; usage des recherches PCU par le CRM DU (chargement initial, détermination du site) non précisé.
- `SO.md` : copie locale temporaire de la page Service Opérationnel, créée en attendant l'outil d'écriture Wiki. Retirée par l'utilisateur le 23/11 ; la page Wiki fait référence.
- Limite : `wiki_upsert_page` n'est pas restreint au projet CRM ; cette limite repose sur la consigne de Joao et les droits ADO.

### Routage Joao → Antoine par hook — 29/10

- Demande : si le livrable de Joao contient « Base de données », « API externe », « Authentification » ou « Données personnelles », router vers Antoine sans intervention humaine.
- Choix validés : hook + consigne, tous les modes, insensible à la casse et aux accents, expression exacte, livrables `ARCHITECTURE.md` et `ADR*.md`.
- Fait : [.github/hooks/route-securite.json](.github/hooks/route-securite.json), [.github/hooks/scripts/route-securite.ps1](.github/hooks/scripts/route-securite.ps1), consigne de routage dans `joao.agent.md`, section dans `docs/guide-equipe.md`.
- Testé en local avec des entrées simulées : blocage, absence de mot-clé, autre fichier, `apply_patch`, revue présente, marqueur, JSON invalide.
- Non vérifié : le format réel de l'entrée du hook dans VS Code (champs `cwd` et `tool_input` supposés), le déclenchement réel et le comportement de l'agent face au blocage. À tester dans VS Code. **Mise à jour du 23/11** : format Copilot vérifié dans la documentation (`toolArgs`, sortie `additionalContext`, pas de blocage possible) et script adapté ; seul le déclenchement réel reste à tester.
- Limites : le hook contrôle une preuve écrite, pas l'appel réel d'Antoine ; il vise tout agent écrivant ces fichiers ; seul Windows PowerShell est testé.

### Garde-fous globaux — 28/10

- Demande : renforcer Maxime et Joao sans toucher à leur rôle. Décision : mettre les règles transverses dans les instructions globales plutôt que dans chaque agent.
- Fait : section « Garde-fous de sécurité et d'intégrité » ajoutée dans [.github/copilot-instructions.md](.github/copilot-instructions.md) (données non fiables, contrôles non contournés, périmètre, aucun ajout d'outil ou de réglage, pas de données sensibles conservées, échecs d'outils signalés). Mention ajoutée dans [docs/guide-equipe.md](docs/guide-equipe.md).
- Les fichiers de Maxime et Joao n'ont pas été modifiés. Les règles propres à Antoine (Web limité à OWASP, rapport expurgé, posture de constatateur) restent dans son fichier, car elles tiennent à son rôle. Sa section « Sécurité de fonctionnement » a été dédoublonnée le 28/10 15:40 : elle renvoie aux garde-fous globaux et ne garde que les règles propres à son rôle.
- À vérifier : le comportement réel dans une nouvelle conversation VS Code. Ces règles sont des consignes, pas des contrôles techniques.
- Incident de méthode : plusieurs tentatives `apply_patch` mal formées ont échoué sans rien modifier ; l'outil `edit` a été utilisé ensuite.

### Comparaison d'Antoine au guide de conception OWASP — 28/10

- Demande : vérifier et ajuster Antoine selon le [Skill Development Best Practices](https://github.com/OWASP/www-project-agentic-skills-top-10/blob/main/skill-development-guide.md). Il s'agit de sa conception, pas d'une nouvelle revue de vulnérabilités du dépôt IEBOX.
- Guide consulté : moindre privilège, validation des entrées, erreurs, stockage, tests et revue, plan avant mutation, recommandations par plateforme, publication, suivi et transparence.
- Consignes renforcées dans [.github/agents/antoine.agent.md](.github/agents/antoine.agent.md) : justification des outils, données non fiables et injections d'instructions, périmètre et chemins, destinations Web, aucune conservation de secret ou sortie brute sensible, échecs explicites, recherches bornées et limites des contrôles techniques. Plan de correction et traçabilité des écritures précisés.
- Aucun nouvel outil, hook, script, accès réseau ou mécanisme de télémétrie ajouté. Posture de constatateur conservée ; pas de questions ouvertes en revue.
- [docs/guide-equipe.md](docs/guide-equipe.md) contient la correspondance avec le guide, les limites et les scénarios de test comportemental. Les tests d'exécution restent à réaliser. Aucune conformité OWASP, sandbox, signature, Workspace Trust ou protection du stockage n'est certifiée par cette comparaison de consignes.
- L'état Git était propre au début de cette demande. Les mentions « non commité » des sections antérieures sont historiques ; aucun commit n'a été créé pendant cette comparaison.

### Où en est-on — 29/10 (historique, voir le point de reprise en tête)
- Maxime et UMLCreator : configurés et validés par l'utilisateur. Ne pas les rouvrir sans demande.
- Joao : l'utilisateur valide sa nouvelle version le 27/10 à 12:54. Le retest proposé ci-dessous n'est plus un préalable à cette validation utilisateur ; ne pas inventer de vérifications supplémentaires.
- Antoine : après lecture du rapport partagé, l'utilisateur demande le 27/10 de supprimer les questions ouvertes et de rester observateur / constatateur en revue, sans extrapolation ni hypothèse. Consignes et guide ajustés ; comportement à retester.
- Rien n'est commité. Aucun commit ne doit être fait sans demande.

### Décisions prises pendant la conversation sur Joao (26/10)

1. **Rôle double** : documenter l'architecture existante d'un dépôt dans `ARCHITECTURE.md` (contexte, schéma des composants et dépendances, flux utiles à un nouveau développeur) ; concevoir une architecture cible à partir du chat, d'un ticket transmis par Maxime ou d'un identifiant ADO.
2. **Principes** : Clean Architecture, KISS, DRY, SOLID et wiki Forem [Principes d'architecture logicielle](https://dev.azure.com/leforem/Tools%20Backlogs/_wiki/wikis/Architecture%20DDI/41159/%F0%9F%93%91-Principes-d'architecture-logicielle). La liste peut évoluer.
3. **Modèle** : `Claude Opus 5.5` et `reasoning-effort: high`, comme Maxime.
4. **Tickets** : Joao ne modifie jamais un ticket. Il prépare les compléments et les transmet à Maxime, seul à écrire dans ADO. Il s'appuie sur la cible de `ARCHITECTURE.md` si elle existe, sinon sur le wiki des principes. Maxime peut appeler Joao (`agents: [Antoine, Joao]`) et Joao peut appeler Maxime (`agents: [Antoine, UMLCreator, Maxime]`), avec consigne anti-boucle.
5. **Style commun** : sorties courtes, langage simple et humain, sans tournures « IA ». Section « Style de rédaction » ajoutée dans [.github/copilot-instructions.md](.github/copilot-instructions.md) et « Style commun » dans le guide.
6. **Installation** : copier tout le contenu du dossier TeamAgentTemplate à la racine du dépôt cible, sans le dossier `.git` du template, en fusionnant `.github`, `.vscode` et `docs` s'ils existent. Un script d'installation a été suggéré, pas réalisé.
7. **Retour du premier test de Joao** (corrections appliquées dans [.github/agents/joao.agent.md](.github/agents/joao.agent.md)) :
   - **Trois modes** : *documentation de l'existant* (par défaut) strictement factuel — ni déduction, ni hypothèse, ni point à confirmer, ni risque, ni recommandation, ni légende « Observé / Déduit / À confirmer », ni section « Constats et limites » ; *conception* d'une cible ; *challenge* uniquement sur demande explicite (par exemple challenger un besoin de Maxime).
   - **Sécurité** : en mode documentation, Joao appelle systématiquement Antoine pour une revue du dépôt. Antoine produit `SECURITY_REVIEW.MD` sans corriger le code. `ARCHITECTURE.md` décrit seulement les mécanismes de sécurité visibles et renvoie vers ce rapport. [.github/agents/antoine.agent.md](.github/agents/antoine.agent.md) ajusté en conséquence.
   - **ADR** : uniquement pour un changement ou une décision d'architecture. En mode documentation, Joao n'en crée pas et n'en parle pas.
   - Une source illisible est signalée dans le chat, pas dans `ARCHITECTURE.md`.

### Point en attente de réponse utilisateur

- L'appel à Antoine a été rendu **systématique** en mode documentation. L'utilisateur peut préférer le limiter aux dépôts ayant des dépendances externes au SI. Pas encore tranché.

### Ajustement d'Antoine — demande du 27/10 à 12:54

- En revue du dépôt, directement ou par délégation : seulement des constats étayés par des preuves localisables. Les conditions essentielles au défaut doivent être vérifiées dans les sources accessibles.
- Pas de section « Questions ouvertes », de points à confirmer, d'hypothèses ni d'extrapolation, dans le rapport ou le chat. Une confiance faible ne remplace pas une preuve.
- Une information manquante ou un composant inaccessible est une limite de couverture, pas une vulnérabilité supposée ni une question à l'équipe.
- Les recommandations restent liées aux défauts étayés ; les conséquences décrites doivent être démontrables par les sources.
- Le rôle de conseil sur un besoin ou une conception reste distinct. Les clarifications de périmètre, la préservation des contributions et la validation humaine des corrections restent autorisées.
- Fichiers ajustés : [.github/agents/antoine.agent.md](.github/agents/antoine.agent.md), [docs/guide-equipe.md](docs/guide-equipe.md) et cette passation. La pièce jointe est un rapport en lecture seule : elle n'a pas été modifiée et aucun constat du dépôt analysé n'a été revérifié ici.

### Prochaine action proposée

Complément Joao du 27/10 à 13:53 : ajouter systématiquement à `ARCHITECTURE.md` une « Vue d’ensemble des dépendances » juste avant « Composants ». Schéma Mermaid haut niveau : application analysée en un bloc, applications appelantes et systèmes communicants autour, liens décrivant le rôle des échanges. Pas de couches internes ni de paquets logiciels dans cette vue. Tous les systèmes et échanges doivent être étayés en documentation ; distinguer les propositions en conception. Consignes de Joao et guide alignés. La pièce jointe d'exemple n'a pas été modifiée. À vérifier lors de la prochaine génération de documentation.

Retour du 27/10 à 14:23 : l'utilisateur valide le diagramme haut niveau, mais constate la disparition des diagrammes de séquence des flux principaux. La consigne les rendait encore facultatifs. Correction appliquée : chaque flux principal retenu doit avoir, dans la même sous-section, une description des étapes et un diagramme Mermaid `sequenceDiagram` concordant. La sélection des flux reste proportionnée ; leurs diagrammes ne sont plus facultatifs. La vue haut niveau et le schéma de composants ne les remplacent pas. Joao peut solliciter UMLCreator ou produire lui-même les diagrammes ; une vérification finale de cette correspondance est ajoutée à sa méthode. Guide aligné. À retester sur la prochaine génération.

Précision du 27/10 à 14:28, qui remplace l'obligation de séquence du retour précédent : chaque flux ou fonctionnalité principal retenu garde une description et un diagramme Mermaid obligatoires, mais Joao choisit le type adapté. Séquence pour les interactions ; activité ou logigramme (`flowchart`) pour les traitements, décisions et branches. Ne pas imposer `sequenceDiagram` à tous les sujets. Consignes, contrôle final et guide ajustés.

Retour du 27/10 à 15:32 : l'utilisateur relève l'usage de `flowchart` pour les composants. Après clarification, il choisit de conserver Mermaid, mais demande une meilleure organisation, comme pour la vue HL. Pas de passage à PlantUML ni de prétention à une notation UML formelle. Joao et UMLCreator doivent produire une vue structurelle : regroupements `subgraph` selon les frontières constatées, niveau de détail homogène, systèmes externes séparés, dépendances orientées du composant dépendant vers le composant utilisé, peu de croisements et pas de détails d'injection non structurants. Pas d'étapes ni de décisions dans cette vue ; zoom ciblé si nécessaire. Guide aligné ; rendu à vérifier au prochain run.

1. Retester Antoine dans une **nouvelle** conversation VS Code avec ses consignes mises à jour.
2. Vérifier l'absence de questions ouvertes, d'hypothèses et de constats dépendant de conditions non vérifiées ; conserver les preuves localisables et les limites factuelles de couverture.
3. Tester ensuite le mode conception (besoin ou ticket via Maxime) et le mode challenge sur demande explicite.

### À signaler

- `git diff --stat` du 26/10 montre `README.md` vidé (44 octets → 0) dans le template. Ce n'est pas une modification de l'assistant ; à vérifier avec l'utilisateur avant tout commit.

### Fichiers modifiés localement par cette conversation (non commités)

- Créé : [.github/agents/joao.agent.md](.github/agents/joao.agent.md).
- Modifiés : [.github/agents/maxime.agent.md](.github/agents/maxime.agent.md) (relais Joao, lecture de `ARCHITECTURE.md`), [.github/agents/antoine.agent.md](.github/agents/antoine.agent.md) (revue demandée par Joao), [.github/agents/umlcreator.agent.md](.github/agents/umlcreator.agent.md), [.github/copilot-instructions.md](.github/copilot-instructions.md) (style), [docs/guide-equipe.md](docs/guide-equipe.md), [docs/maxime/references.md](docs/maxime/references.md), ce fichier.
- Dernier `git diff --check` : OK.

### Repères techniques pour reprendre

- Wiki Architecture DDI (projet `Tools Backlogs`) : principes (41159), gouvernance ADR (42619), templates (42608). Les sous-pages de templates se lisent avec `get_page` et le chemin canonique `/⚒️ Templates/APP-001 - Énoncé de la décision de l'ADR` ; le lien de la page gouvernance est cassé.
- ADR : titre `[CodeApplication]-[NNN] - Décision affirmative`, code application depuis `PROJET.md` (en contexte Forem, à défaut, code OMA du cache de Maxime), statuts Brouillon / Proposé / Accepté / Constaté / Supplanté. Le dossier ADR est à demander si le dépôt n'en a pas.
- Si le MCP `ado` renvoie 401, demander à l'utilisateur de se réauthentifier (`/mcp auth ado`).
- Sous PowerShell, les accents s'affichent mal mais les fichiers UTF-8 sont corrects. Pour éditer des lignes accentuées longues, voir d'abord le texte exact et procéder par petits blocs.
- Les limites de fichiers des agents (`read`, `edit`) sont des consignes, pas une sandbox technique.

---

Dernière mise à jour de l'historique ci-dessous : 2026-10-26, complétée ponctuellement ensuite. **Ces sections sont un historique.** En cas d'écart, l'état en tête de ce fichier et `docs/guide-equipe.md` font foi ; les sections « Configuration de … » ont été remises à jour le 2026-11-23. Elle ne contient ni secret ni copie du contenu métier des tickets. Les états et révisions ci-dessous sont des observations historiques à revérifier avant toute écriture.

## Reprise rapide : Joao

- L'utilisateur a validé le plan de conception de l'agent Architecte **Joao**. La configuration a été créée dans ce template partagé ; son comportement effectif reste à vérifier dans une nouvelle conversation VS Code. Ne pas relancer par défaut le durcissement d'Antoine : l'utilisateur a considéré son premier test satisfaisant le 26/10 à 11:10.
- Maxime fonctionne selon la validation utilisateur : création, modification et alimentation des commentaires avec les derniers inputs. Antoine est configuré et son premier essai est accepté, sans certification de sécurité ni clôture de tous les risques résiduels.
- Joao peut travailler à partir d'un besoin dans le chat, du contexte d'un ticket transmis par Maxime, d'un identifiant ADO ou des fichiers pertinents d'un dépôt. Son livrable dépôt est `ARCHITECTURE.md` ; ses décisions structurantes et tout changement de l'architecture existante nécessitent des ADR distincts.
- Joao est autorisé à consulter Antoine pour un avis intermédiaire et UMLCreator pour les diagrammes utiles. Il dispose de `ado/wit_work_item` pour lire le ticket explicitement identifié et de `ado/wiki` pour lire les pages Architecture DDI citées ; aucune recherche générale ni écriture ADO/wiki. Évolution du 19/11 : lecture de tous les wikis du projet CRM et écriture Wiki via `ado/wiki_upsert_page` (voir « Point de reprise »).
- Les principes de conception incluent Clean Architecture, KISS, DRY, SOLID et le référentiel Architecture DDI. Les détails des livrables, statuts ADR et permissions figurent dans [.github/agents/joao.agent.md](.github/agents/joao.agent.md) et [docs/guide-equipe.md](docs/guide-equipe.md).

## Objectif et périmètre

Construire un template d'équipe d'agents GitHub Copilot pour VS Code, intégrable par copier-coller dans un dépôt Git, en contexte Forem ou sur tout autre projet (depuis le 23/11, via `PROJET.md`). Maxime, le sous-agent UMLCreator, Antoine, Joao et Simone sont configurés. Après constat que les tickets ADO n'affichent pas le rendu Mermaid, Maxime ne délègue pas à UMLCreator et ne publie pas de source Mermaid dans les tickets. Le 26/10, une délégation ciblée à Antoine est autorisée pour les exigences de sécurité du besoin.

| Agent | Rôle envisagé | État |
| --- | --- | --- |
| Maxime | Business Analyste : clarification du besoin, rédaction et affinage dans ADO ou `ANALYSE.md`, suivi des bugs | Implémenté et ajusté après test ; modes de suivi ajoutés le 23/11 |
| UMLCreator | Sous-agent : diagrammes UML en Mermaid | Implémenté ; lecture seule, résultats retournés à l'agent principal |
| Simone | Expertise UI/UX | Configurée le 23/11 ; à tester |
| Joao | Architecture | Implémenté ; version validée le 27/10 ; écriture Wiki vérifiée le 19/11 ; rôle dans le processus ajouté le 23/11, à tester |
| Sébastien | Développement FullStack | Non implémenté |
| Antoine | Revue statique de sécurité du code, des dépendances, de l'IaC et de la configuration | Configuré ; rapport `SECURITY_REVIEW.MD` et corrections locales après validation humaine explicite |
| Anne-Cécile | Tests | Non implémentée |
| Vincent | Finalisation et documentation | Non implémenté |
| Léo | Contrôle qualité de chaque livrable | Non implémenté |
| Philippe | Orchestrateur | Non implémenté |

UMLCreator peut être sollicité directement ou par un agent autorisé lorsque le diagramme est utile, sans génération systématique. Il produit les types de diagrammes utiles au besoin et retourne son résultat à l'agent principal, qui le relit et l'insère dans un livrable Markdown adapté. Maxime ne l'utilise pas pour rédiger un besoin. Joao l'utilise pour les diagrammes d'architecture, Simone pour les parcours. Son modèle n'est pas fixé en attendant la vérification du libellé dans VS Code.

Le paragraphe suivant décrit le mode revue par défaut d'Antoine ; le mode correction après validation est défini dans la section « Évolution : corrections validées du 26/10 ».

Antoine est configuré dans `.github/agents/antoine.agent.md` pour examiner le code, les dépendances, l'IaC et la configuration sans les modifier, puis proposer des corrections sans les appliquer. Il écrit uniquement son rapport `SECURITY_REVIEW.MD` à la racine du dépôt analysé, emplacement confirmé par l'utilisateur le 26/10 ; il préserve les contributions existantes et ne produit pas de rapport local pour une consultation métier de Maxime. À la demande du 26/10, OWASP Top 10:2025 sert de cadre de sensibilisation pour les risques Web ; l'agent peut consulter uniquement la documentation publique officielle OWASP, sans envoyer de contenu du dépôt à un service externe. Il associe les constats aux catégories pertinentes et cite référentiel, version et source, sans prétention d'exhaustivité ou de conformité. Les périmètres API/LLM doivent signaler les limites du Top 10 Web et vérifier le référentiel OWASP spécialisé correspondant. Source officielle : https://top10.owasp.org/2025/. Le premier test est accepté par l'utilisateur ; cela ne démontre pas tous les scénarios de délégation, d'écriture de rapport ou de correction.

### Évolution : corrections validées du 26/10

L'utilisateur demande qu'Antoine puisse appliquer ses recommandations après validation. Le mode par défaut reste la revue avec écriture du seul rapport racine. Toute correction locale nécessite un plan validé explicitement par un humain : constats, fichiers, changements, impacts et vérifications. Un appelant doit transmettre cette validation ; son propre accord ne suffit pas. Maxime reste limité à la consultation du besoin, sans correction ni rapport local. Antoine ne reçoit aucun outil supplémentaire : il reste sans terminal, tests, scanner, déploiement ou accès ADO. Les permissions et protections effectives restent à traiter par un responsable humain. Le rapport distingue les correctifs appliqués des résultats d'exécution encore attendus ; cette évolution des instructions ne résout pas à elle seule les risques de cloisonnement cités dans la revue précédente.

### Revues et premier test d'Antoine : bilan du 26/10

- Deux rapports ont été présentés dans la conversation, avant et après l'ajout du mode correction. Ils relevaient deux risques de cloisonnement classés MEDIUM : limites de fichiers/Web déclaratives malgré des outils généraux ; outils ADO et droits du compte plus larges que le rôle de Maxime.
- Ces constats sont des risques conditionnels, pas des exploitations démontrées. Aucun scanner, test d'intrusion ou changement de permission ADO n'a été réalisé. Aucun résultat local SonarQube/SonarCloud, CodeQL, Semgrep ou SARIF n'avait été identifié dans les fichiers recensés ; aucune application ou IaC n'avait été identifiée dans ce périmètre.
- Les réponses de revue ont annoncé une impossibilité d'enregistrer le rapport faute d'outil d'écriture utilisable dans ces interactions. Il ne faut pas en déduire une interdiction générale de l'environnement. Lors de la présente passation, `Test-Path` confirme que `SECURITY_REVIEW.MD` est absent à la racine : les rapports précédents existent uniquement dans la conversation. Ne pas prétendre que la persistance du rapport a été testée avec succès.
- L'utilisateur a validé un inventaire en lecture des approbations VS Code et permissions ADO pour préparer un plan de réduction des risques. La vérification des permissions effectives ADO n'a pas été effectuée par un outil ; les valeurs ci-dessous sont déclarées par l'utilisateur.
- Le 26/10 à 11:10, l'utilisateur a décidé : « pour ce premier test d'antoine on va considérer que l'on est bon ». Arrêter ce chantier pour cette étape et passer à Joao ; les limites restent documentées sans les présenter comme résolues.

### Approbations VS Code et permissions ADO

- Selon l'utilisateur : mode de conversation `Interactive`, `Manual permissions`, approbations mémorisées non consultables. `chat.mcp.access` est déclaré à `all` ; cela ne signifie pas que tous les appels MCP sont automatiquement approuvés.
- L'utilisateur avait relevé `**/*: true` dans `Chat > Tools > Edits: Auto Approve`, puis validé son passage à `false`. La lecture ciblée des paramètres utilisateur a ensuite montré que `chat.tools.edits.autoApprove` contenait déjà `"**/*": false` ; aucune modification de ce réglage n'a été faite par l'assistant.
- À 11:09, l'utilisateur a confirmé le test proposé : une édition demande une approbation humaine et son refus laisse le fichier inchangé. C'est une validation utilisateur du scénario testé, pas une preuve de restriction technique des chemins.
- L'utilisateur confirme que le compte ADO est celui du MCP, que la lecture et l'édition des work items dans Prague sont `Allow`, que suppression/restauration et suppression définitive sont `Deny`, et que l'héritage et les groupes ont été vérifiés.
- Le compte peut aussi modifier hors Prague. Ne pas réduire arbitrairement ses droits professionnels : le périmètre Prague reste une consigne de Maxime et un contrôle humain avant approbation.
- L'utilisateur confirme avoir testé avec Maxime l'authentification par un compte reconnu de l'organisation et la validation humaine avant écriture d'un ticket. Ne pas généraliser cette observation à toutes les opérations MCP ni confondre authentification et restriction de zone.
- Risques résiduels : restriction Web d'Antoine aux sources OWASP et limites de fichiers non cloisonnées techniquement ; droits ADO hors Prague disponibles. L'approbation humaine atténue les risques dans les scénarios testés, sans les supprimer.
- Aucune politique réseau, sandbox ou restriction technique de chemin n'a été ajoutée. Aucun changement de la configuration MCP n'a été nécessaire pour ce test.

## Décisions communes

Complément du 26/10 pour Antoine : il peut être installé seul dans un dépôt pour une code review sécurité, sans MCP ADO. Il doit tenir compte des configurations, intégrations CI et rapports locaux SonarQube/SonarCloud ou autres outils de validation, en distinguant configuration, exécution prévue et résultats disponibles. Le rapport précise provenance, actualité connue, exclusions et limites de couverture ; les alertes sont recoupées, qualifiées et dédupliquées. Aucun scanner n'est lancé et aucun tableau de bord distant n'est consulté ; demander si nécessaire un export expurgé, jamais un jeton.

- Instructions, questions, réponses, commentaires ADO et documentation en français ; conserver les identifiants techniques.
- Échanges concis, factuels et naturels. Ne rien inventer ; distinguer faits, propositions et questions ouvertes.
- Chaque agent garde son rôle. Les décisions métier et d'architecture nécessitent leurs validateurs humains.
- Opérations ADO exclusivement via les outils ADO disponibles : aucun contournement par terminal, script ou appel HTTP direct.
- Ne pas écraser de contributions existantes. Relire le ticket et ses commentaires avant modification ; utiliser le test de révision pour les champs.
- Ne pas versionner de secrets, données personnelles ou contenu métier sensible. Le cache contient uniquement les conventions réutilisables et leurs sources.

## Configuration de Maxime

État au 2026-11-23 ; le détail fait foi dans l'agent et le guide.

- Agent : [.github/agents/maxime.agent.md](.github/agents/maxime.agent.md). Règles communes : [.github/copilot-instructions.md](.github/copilot-instructions.md).
- Modèle : `Claude Opus 5.5`, libellé à confirmer dans le sélecteur VS Code.
- Outils : `read`, `edit`, `agent` et une liste explicite d'outils ADO (`core_list_projects`, `core_list_project_teams`, `work`, `wit_backlog`, `wit_work_item`, `wit_query`, `search_workitem`, `wit_work_item_write`, `wit_work_item_comment_write`, `wiki`, `wiki_upsert_page`, `search_wiki`). `agents: [Antoine, Joao, Simone]`, non appliqué dans le harness Copilot. Aucun terminal ni Web.
- Configuration du projet : crée et tient seul `PROJET.md` ; mode de suivi ADO ou local (`ANALYSE.md`, besoins `FCT-NNN`, bugs `BUG-NNN`) ; règles Forem (Prague, `Support Request`, titre OMA, wiki Ressources, cache `docs/maxime/references.md`) seulement en contexte Forem.
- Lecture locale : instructions, `docs/maxime/`, `PROJET.md`, `ANALYSE.md`, sections utiles de `ARCHITECTURE.md`. Écriture locale : `PROJET.md`, `ANALYSE.md`, `docs/maxime/references.md` en contexte Forem, et ses documents en mode de wiki local. Consignes, pas une sandbox.
- Processus : un besoin par responsabilité, découpage après accord du PO ; réponses aux questions métier des agents, consignées ; création des bugs à partir des anomalies qualifiées par Joao ; intégration autonome des compléments de Joao et Simone hors changement métier ; publication wiki sur demande, sans confirmation par écriture ; validation du PO avant de considérer un besoin prêt.
- Il ne développe pas, ne choisit pas d'architecture et ne délègue pas à UMLCreator pour rédiger un besoin ; aucune source Mermaid dans les tickets ADO.

## Délégation sécurité décidée le 26/10

- Antoine reste accessible directement et devient appelable comme sous-agent : `disable-model-invocation: false`. Il ne délègue pas lui-même et reste sans terminal ou accès ADO. L'outil `edit` est autorisé pour son rapport racine `SECURITY_REVIEW.MD` et les corrections locales explicitement validées selon la procédure ci-dessus, par consigne et non par sandbox technique.
- Maxime peut le consulter ponctuellement pour affiner les exigences et critères de sécurité à partir du contexte du besoin fourni, sans décider d'une solution technique.
- Joao peut le consulter pour la sécurité des solutions d'architecture ; Sébastien devra le solliciter prioritairement pour les implémentations et les corrections pertinentes. Joao est configuré avec l'outil `agent` et `Antoine` dans `agents`.
- Antoine retourne son avis à l'appelant pour relecture et intégration. Les exigences proposées et risques de conception ne sont pas présentés comme des vulnérabilités d'implémentation confirmées ; la validation reste humaine.
- Configuration locale mise à jour ; le fonctionnement effectif de cette délégation dans une nouvelle conversation VS Code reste à vérifier.

## Configuration de UMLCreator

- Agent : [.github/agents/umlcreator.agent.md](.github/agents/umlcreator.agent.md).
- Outil autorisé : `read` uniquement. UMLCreator ne modifie pas directement ADO ni les fichiers du dépôt.
- Maxime ne l'autorise pas dans sa liste `agents`. Joao l'utilise pour les diagrammes d'architecture et Simone pour les parcours ; ils relisent tout résultat avant intégration. La liste `agents` n'est pas appliquée dans le harness Copilot.
- UMLCreator produit uniquement des diagrammes utiles, fondés sur les faits fournis ou les fichiers pertinents. Il signale les inconnues sans inventer de contenu.
- Maxime ne place pas de source Mermaid dans la Description ADO. Joao peut insérer dans `ARCHITECTURE.md` les diagrammes utiles produits par UMLCreator après relecture.
- Modèle non fixé avant vérification dans le sélecteur VS Code.

## Configuration de Joao

- Agent : [.github/agents/joao.agent.md](.github/agents/joao.agent.md).
- Modèle : `Claude Opus 5.5`, comme Maxime, avec `reasoning-effort: high`, selon la demande utilisateur du 26/10 à 13:34. La disponibilité du modèle et l'application effective du réglage restent à vérifier dans VS Code ; la configuration de Maxime n'a pas été modifiée.
- Entrées : besoin dans le chat, besoin transmis par Maxime, identifiant de besoin (ticket ADO ou `FCT-NNN`), ou dépôt ouvert pour analyser l'architecture existante ; dans le processus, besoin validé et documents de Simone.
- Outils : `read`, `search`, `edit`, `agent`, `ado/wit_work_item`, `ado/wiki`, `ado/wiki_upsert_page`. Lecture du besoin dans ADO ou `ANALYSE.md`. Wikis : en contexte Forem, ceux du portefeuille indiqué par l'utilisateur (pas `PROJET.md`) et les pages Architecture DDI ; ailleurs, selon le mode de wiki de `PROJET.md`. Publication sur demande, sans confirmation par écriture, sans suppression. Aucune modification de besoin ni de `PROJET.md`. Aucun terminal ni Web.
- Sous-agents : `Antoine` (revue systématique en documentation, avis ciblé en conception, routage obligatoire), `UMLCreator` (tous les diagrammes), `Maxime` (compléments au besoin, questions métier, bugs), `Simone` (questions UI/UX) ; plus tard `Sébastien` et `Anne-Cécile`. Joao relit les résultats ; ils ne valent pas validation humaine.
- Trois modes : documentation de l'existant strictement factuelle ; conception (appliquée dans le processus et pour les questions d'agents) ; challenge sur demande explicite. Le mode documentation reste le défaut en cas de doute hors processus.
- Livrable dépôt : `ARCHITECTURE.md` à la racine, documentation du projet entier, évolutive en conception. Dans le processus : `docs/fonctionnalites/<ID>/contexte-technique.md` pour Sébastien, relecture des PR, qualification des anomalies.
- ADR : uniquement pour un changement ou une décision d'architecture, créé `Proposé`, accepté par un humain avant le développement ; `ARCHITECTURE.md` mis à jour avec les changements marqués « Proposé (ADR X) ». Titre `CodeApplication-### - Décision affirmative`, code application de `PROJET.md` (en contexte Forem, à défaut, cache OMA de Maxime). Gouvernance et modèle Forem en contexte Forem ; même structure ailleurs sauf convention du dépôt.
- Le modèle ADR impose statut, contexte, décision justifiée, conséquences positives et négatives, vérification de conformité et notes (auteur, date, ADR liés). `Accepté` requiert une validation humaine ; `Constaté` sert à documenter un fait observé sans décision historique connue.
- Principes : Clean Architecture, KISS, DRY et SOLID ; en contexte Forem, référentiel Architecture DDI et dérogations validées par la DDI ; ailleurs, source éventuelle de `PROJET.md` et dérogations validées par l'utilisateur.
- Écritures par consigne : `ARCHITECTURE.md`, ADR, `contexte-technique.md`, documents en mode de wiki local, pages wiki autorisées. Joao ne code, ne déploie, ne modifie aucune permission et n'exécute ni commande ni test. Ces limites ne sont pas une sandbox technique.
- Sources lues pour la conception : [Principes d'architecture logicielle](https://dev.azure.com/leforem/Tools%20Backlogs/_wiki/wikis/Architecture%20DDI/41159/%F0%9F%93%91-Principes-d'architecture-logicielle), [Gouvernance des ADR](https://dev.azure.com/leforem/Tools%20Backlogs/_wiki/wikis/Architecture%20DDI/42619/Gouvernance-des-ADR), [modèle ADR](https://dev.azure.com/leforem/Tools%20Backlogs/_wiki/wikis/Architecture%20DDI/42608/%E2%9A%92%EF%B8%8F-Templates), [modèle de travail d'architecture](https://dev.azure.com/leforem/Tools%20Backlogs/_wiki/wikis/Architecture%20DDI/42608/%E2%9A%92%EF%B8%8F-Templates) et [modèle de dette](https://dev.azure.com/leforem/Tools%20Backlogs/_wiki/wikis/Architecture%20DDI/42608/%E2%9A%92%EF%B8%8F-Templates). Les pages modèles ont été retrouvées sous l'index « Templates » via leurs chemins canoniques.

### Relais architectural vers les tickets — demande du 26/10 à 13:46

- Pour un besoin provenant de Maxime ou une intervention sur un ticket, Joao utilise d'abord la cible documentée dans `ARCHITECTURE.md` ; à défaut de cible exploitable, il signale la limite et se base sur les principes du wiki Architecture DDI. Un fichier inaccessible n'est pas déclaré absent ; toute contradiction ou cible non validée reste à clarifier.
- Joao fournit à Maxime un dossier sourcé : ticket/projet, faits, référence architecturale, écarts, impacts, questions et modifications proposées de Description, Acceptance Criteria ou commentaires. Joao n'écrit jamais le ticket ; Maxime reste responsable de la mise à jour après validation et contrôles habituels.
- Si Maxime a appelé Joao, les compléments lui sont retournés sans rappel. Si Joao intervient directement, il peut solliciter Maxime ; celui-ci ne rappelle pas Joao pour la même demande. Le silence ou l'accord autonome d'un agent ne vaut pas validation humaine.
- Le fonctionnement effectif de ce relais bidirectionnel, l'absence de boucles et les écritures ADO sous validation restent à vérifier dans une nouvelle conversation VS Code.

## Décisions ADO actuelles

- Organisation : `leforem` ; projet : `Tools Backlogs`.
- Équipe : `Squad Prague`, identifiant `a855ca36-c1f3-4eff-899c-92a3799b1358`.
- Zone imposée pour toutes les créations : `Tools Backlogs\Squads\Prague`. L'utilisateur a explicitement confirmé cette exception aux règles génériques du wiki qui orientent normalement vers la zone métier de l'outil.
- Type de PBI : **Support Request uniquement**. L'utilisateur avait demandé « Service Request », mais ADO a renvoyé `VS402323` ; il a ensuite explicitement confirmé `Support Request`. Ne pas revenir à `User story`, `Service Request` ou `Issue` comme solution de repli.
- Titre : `[Code OMA][NNN].[NN] - [Fonctionnalité]`. L'exemple initial `LDC001.01` illustre la structure, sans imposer l'application LDC.
- La signification et l'incrémentation des deux nombres n'ont pas été définies. Demander le numéro si nécessaire ; ne pas calculer arbitrairement « maximum + 1 ». Vérifier les doublons en direct.
- Le code OMA est retrouvé à partir du Tool dans `Release Management`. Ce projet est une source de lecture, pas une cible de création pour Maxime.

## Rédaction des tickets

- Le champ Description commence par **Expression du besoin**, pas « La description ».
- INVEST reste un contrôle interne à Maxime : aucune grille ou vérification INVEST publiée dans la description.
- Les critères restent uniquement dans le champ Acceptance Criteria. Ne pas ajouter dans Description une section Critères d'acceptation, même pour renvoyer au champ dédié.
- Ne pas ajouter de section État de l'affinage dans Description.
- Ne pas mentionner de maquette d'écran si le besoin initial n'en fournit pas.
- Ne pas ajouter de rubrique Diagrammes ni de source Mermaid aux PBI ADO. Si un flux doit être expliqué, Maxime le décrit en texte clair. Les diagrammes d'architecture relèvent de Joao, qui peut déléguer à UMLCreator.
- Les règles métier et les accès aux données restent documentés ; les inconnues nécessaires sont signalées sans réponse inventée.
- Les propositions et critères non validés restent identifiés comme tels. Aucun choix d'intégration n'est présenté comme acquis sans validation.

## Questions et affinage

Créer le ticket dès que les informations obligatoires sont connues, puis poser les questions métier dans sa discussion. Les réponses dans VS Code sont également acceptées et synthétisées dans ADO.

L'utilisateur a demandé un style plus humain : sujets bien séparés, phrases courtes, question principale puis puces, plutôt que de longs paragraphes composites. Le premier commentaire peut suivre cette structure :

1. **Affinage initial : 3 questions avant de continuer** (adapter le nombre).
2. **Contexte confirmé** : une synthèse courte.
3. **À confirmer** : les propositions encore ouvertes.
4. Jusqu'à trois sujets numérotés, avec questions directes et précisions en puces.
5. Une invitation courte à répondre dans ADO ou VS Code.

Éviter les répétitions administratives. En Markdown ADO, écrire `**Libellé** :` plutôt que `**Libellé :**` : le second format a provoqué une mauvaise interprétation du rendu lors du test.

Maxime ne surveille pas les commentaires en arrière-plan : l'utilisateur doit le relancer. Il ne considère pas un besoin prêt par silence et ne change pas l'état ADO sans demande explicite.

## Fichiers de référence

- [.vscode/mcp.json](.vscode/mcp.json) : serveur MCP officiel distant, nommé `ado`, URL `https://mcp.dev.azure.com/leforem`, liste explicite d'outils (`wiki_upsert_page` inclus depuis le 19/11) ; aucun secret enregistré. Après modification de la liste, redémarrer le serveur MCP dans VS Code.
- [docs/guide-equipe.md](docs/guide-equipe.md) : installation, responsabilités, fonctionnement, limites des outils et résultats de vérification.
- [docs/maxime/modele-us.md](docs/maxime/modele-us.md) : modèle de PBI Support Request, séparation Description / Acceptance Criteria et présentation des commentaires.
- [docs/maxime/references.md](docs/maxime/references.md) : conventions sourcées, identifiants, inventaire des pages wiki et ETags, observations historiques et points ouverts.

## Sources wiki et cache

La page [Ressources](https://dev.azure.com/leforem/Tools%20Backlogs/_wiki/wikis/Tools%20backlogs.wiki/47345/Ressources) et ses neuf descendants ont été consultés. L'inventaire et les révisions sont dans le cache ; ne pas refaire tout le parcours sans nécessité.

La page [Correspondances OMA](https://dev.azure.com/leforem/Tools%20Backlogs/_wiki/wikis/Tools%20backlogs.wiki/47513/Correspondances-Tools-OmaCode-NodeName) contient une table dynamique, pas les correspondances dans son Markdown. Elle référence la requête `fc8c65ae-8f49-4eaf-9b6a-cae451579c4b`, chemin `Shared Queries/Ref4Ai/OMA-Tool-NodeName`, qui retourne des Tools de `Release Management` et notamment `Custom.OMAcode`. Les résultats peuvent évoluer sans changement d'ETag wiki : vérifier le Tool en direct avant une création.

Pour obtenir tous les descendants, la lecture `wiki/get_page` avec projet, wiki, chemin canonique et `recursionLevel: Full` a fonctionné. La lecture par URL seule n'avait pas développé l'arborescence. Les identifiants et le chemin canonique sont dans le cache.

## Test réel et état vérifié

Ticket de test concret : [PBI 272941](https://dev.azure.com/leforem/Tools%20Backlogs/_workitems/edit/272941). Lire son contenu et ses commentaires dans ADO pour reprendre le cas ; ne pas copier son contenu métier dans les fichiers versionnés.

- Authentification et lectures ADO réussies après démarrage et connexion par l'utilisateur.
- Création initiale en `User story`, puis conversion en **Support Request** après retour utilisateur.
- Conversion et correction de Description avec `Test /rev`, puis relecture réussie.
- Lors de la correction initiale du 20/10 uniquement, Acceptance Criteria comparés avant/après : **strictement identiques**. Titre, zone et état conservés lors de cette correction. Les critères ont ensuite été révisés le 23/10 avec accord utilisateur, comme indiqué ci-dessous.
- État vérifié le 20/10 : `New`, zone Prague ; cette observation est historique et remplacée par la relecture du 23/10 ci-dessous.
- Commentaire initial corrigé selon la formulation aérée fournie par l'utilisateur ; commentaire `10383704`, dernière version vérifiée `3`.
- Les fichiers locaux modifiés ne présentaient pas d'erreur signalée par VS Code lors de la dernière vérification.

Limites : la création directe d'un nouveau `Support Request` n'a pas encore été testée ; seule la conversion l'a été. Aucun conflit de concurrence n'a été volontairement provoqué. Les défauts observés lors de la création initiale en `User story` ne doivent pas être transposés au nouveau type.

## Dernières opérations du 23/10 et reprise du cas concret

### Diagrammes puis retrait du relais de Maxime

- À la demande de l'utilisateur, deux séquences AS-IS et TO-BE ont été ajoutées au PBI 272941 après une production par UMLCreator et relecture. Le TO-BE était explicitement illustratif, pas une architecture validée. Écriture avec test de révision `10`, résultat à la révision `11`.
- L'utilisateur a constaté que les tickets ADO affichent la source Mermaid, sans rendu de diagramme. Il a demandé de retirer à Maxime la possibilité d'appeler UMLCreator pour les PBI.
- Retrait effectué le 23/10 dans la configuration : outil `agent` supprimé, `agents: []`, consignes de Maxime et documentation alignées. Cette interdiction reste applicable à UMLCreator ; la consultation ciblée d'Antoine autorisée le 26/10 constitue une évolution distincte.
- L'utilisateur a nettoyé lui-même le ticket. La relecture ultérieure à la révision `12` a confirmé l'absence de la section ajoutée. Ne pas restaurer les blocs Mermaid.

### Ressources supplémentaires et révision du PBI

L'utilisateur a précisé que le contexte initial était incomplet et a fourni ces sources à consulter pour répondre aux questions d'affinage :

- [Ticket 268404](https://dev.azure.com/leforem/Dossier%20Unique%20Chercheur%20Emploi%20(CRM)/_workitems/edit/268404), dans le projet `Dossier Unique Chercheur Emploi (CRM)`.
- [Analyse wiki 26.11, page 46930](https://dev.azure.com/leforem/Dossier%20Unique%20Chercheur%20Emploi%20(CRM)/_wiki/wikis/Dossier-Unique-Chercheur-Emploi-(CRM).wiki/46930/26.11-D%C3%A9terminer-le-type-de-disponibilit%C3%A9-applicable).

Ces sources ont été lues via MCP ADO, ainsi que les quatre commentaires alors présents sur 268404 (révision du ticket observée : `17`). Pour reprendre l'analyse, relire ces contenus en direct, notamment les échanges des 21, 22 et 23/10 ; leurs détails métier ne sont pas copiés ici. Les commentaires fournissent un contexte complémentaire indispensable au seul champ Description.

- Après synthèse et question explicite, l'utilisateur a choisi de réviser **Description et Acceptance Criteria**, plutôt que de publier uniquement un commentaire.
- Mise à jour effectuée sur 272941 avec `Test /rev = 12`, résultat à la révision `13`.
- Un commentaire de synthèse sourcé a ensuite été ajouté : `10419109`, version `1`. Le commentaire initial `10383704`, version `3`, a été conservé ; ses questions ne doivent donc pas être considérées toutes encore ouvertes sans lire le complément.
- Dernière relecture réussie : PBI 272941, révision **14**, état **`In Progress`**, zone **`Tools Backlogs\Squads\Prague`**. Titre conservé. Description et trois critères d'acceptation révisés présents, liens aux deux nouvelles sources présents, aucun bloc Mermaid dans Description, deux commentaires présents.
- Les décisions d'intégration restent ouvertes et les critères restent proposés à validation. Cette opération n'a pas validé d'architecture et n'a pas déclaré le ticket prêt.
- Les tickets sources et le wiki n'ont pas été modifiés. Aucune nouvelle règle générique n'a été ajoutée aux instructions de Maxime pour imposer ces sources à tous les projets : elles concernent ce cas concret.

### État local à préserver

Observation historique de la passation précédente : Maxime, le guide, le modèle, le cache et la passation étaient modifiés, UMLCreator non suivi. Cette observation a été remplacée par le contrôle du 26/10 à 11:49, qui ne retournait aucune entrée. Avant la présente implémentation, `passation.md` comportait déjà des modifications locales non commitées ; elles ont été préservées et mises à jour pour intégrer les décisions validées. Cette opération a également créé `.github/agents/joao.agent.md` et modifié `docs/guide-equipe.md`. Aucun commit n'est créé. Toujours revérifier l'état local avant toute nouvelle modification.

Le dernier `git diff --check` des changements de configuration était réussi. L'activation effective de la configuration mise à jour de Maxime dans une nouvelle conversation VS Code reste à vérifier ; un ancien contexte de conversation ne prouve pas que les nouveaux droits ont été chargés.

## Prochaines étapes (historique 26-27/10)

L'utilisateur confirme le 2026-10-26 que les trois premiers points de la passation précédente sont validés : le fonctionnement de Maxime/ADO, la reprise de l'affinage et le fonctionnement de la création et de la modification. Il confirme que Maxime alimente bien les commentaires avec les derniers inputs. Il s'agit d'une validation utilisateur, sans nouvelle vérification ADO dans cette session.

Mise à jour du 27/10 : Joao a été reconnu et testé une fois en documentation (dépôt IEBOX). Voir « Point de reprise » en tête de fichier pour la suite ; les points ci-dessous restent valables pour les modes conception et ticket.

1. Vérifier dans une nouvelle conversation VS Code que Joao est reconnu et peut être invoqué par l'utilisateur ; tester séparément l'analyse d'une architecture existante, la conception à partir d'un besoin/ticket et la lecture d'un ticket ADO explicitement identifié.
2. Vérifier que Joao produit ou met à jour uniquement `ARCHITECTURE.md` et les ADR concernés, respecte le nommage OMA/séquence, demande les informations absentes et ne présente pas une proposition comme une décision acceptée.
3. Vérifier les délégations ciblées à Antoine et UMLCreator ainsi que la relecture de leurs réponses. Ces vérifications de fonctionnement ne valent pas validation d'une architecture métier.
4. Garder les limites d'Antoine documentées sans rouvrir son premier test accepté. Ne pas créer les autres agents par anticipation.

Restent à clarifier : Definition of Ready officielle, validateurs de chaque besoin, disponibilité exacte du modèle de UMLCreator et confidentialité autorisée pour les résumés versionnés. Le dossier ADR reste à demander si un dépôt cible n'en définit pas déjà un. Aucune réponse ne doit être supposée.

## Précautions techniques utiles

Les opérations ADO passent par les outils MCP ; l'analyse locale d'une réponse déjà reçue n'autorise pas un accès distant par script. Sous Windows PowerShell 5.1, `ConvertFrom-Json` peut refuser les clés vides des métadonnées de type ADO. Un repli a fonctionné avec `System.Web.Script.Serialization.JavaScriptSerializer.DeserializeObject` ; ne pas sérialiser ensuite les dictionnaires imbriqués mêlés aux objets PowerShell sans précaution. Pour les contrôles de description du test, le HTML a été analysé avec un parseur XML et les champs Acceptance Criteria comparés directement.

Le serveur `ado` a demandé une authentification au début du 23/10 ; l'utilisateur s'est authentifié via `/mcp auth ado`, puis les lectures et écritures ont fonctionné. Des erreurs génériques temporaires d'invocation MCP ont ensuite disparu après une nouvelle tentative de lecture ; ne pas les interpréter comme une absence de contenu ni contourner MCP. Pour analyser une réponse JSON sauvegardée localement, préciser l'encodage UTF-8 sous PowerShell 5.1 afin d'éviter les caractères accentués mal décodés.
