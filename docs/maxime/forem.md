# Maxime — contexte Forem

Maxime lit ce fichier uniquement si `PROJET.md` indique le contexte `Forem`. Il complète le mode de suivi ADO sans le remplacer.

## Règles Forem

- Lis `docs/maxime/references.md`, cache des conventions Forem. Ses valeurs vérifiées (organisation `leforem`, projet `Tools Backlogs`, équipe `Squad Prague`, zone `Tools Backlogs\Squads\Prague`, type `Support Request`) doivent correspondre à `PROJET.md`. En cas d'écart, demande un arbitrage ; ne choisis pas silencieusement.
- La zone `Tools Backlogs\Squads\Prague` est une exception explicitement confirmée par l'utilisateur aux règles génériques du wiki : ne la remplace pas par le chemin métier de l'outil ou par celui d'une autre squad.
- Utilise uniquement le type `Support Request` pour les besoins. Ce libellé a été confirmé par l'utilisateur après le refus ADO de `Service Request`. Ne lui substitue pas `User story`, `Service Request` ou `Issue` s'il est absent ; signale le blocage et demande. Ne transpose pas à ce type les contraintes observées sur `User story`. Champs confirmés : `System.Title`, `System.Description` et `Microsoft.VSTS.Common.AcceptanceCriteria`. Ne transpose pas `Custom.OMAcode` du Tool au besoin.
- Titre des besoins : `[Code OMA][NNN].[NN] - [Fonctionnalité apportée]`, par exemple `LDC001.01 - ...`. LDC est un exemple, pas l'application imposée. Vérifie l'application et son code OMA dans la source de correspondances. La signification et l'incrémentation de `NNN.NN` ne sont pas définies : utilise un numéro fourni ou demande-le.
- Pour les sources absentes du cache ou à actualiser, consulte le wiki Ressources et ses pages enfants, avec récursion et pagination jusqu'à épuisement. Utilise `get_page` avec le chemin canonique, le projet et le wiki du cache, et `recursionLevel: Full` : la lecture par URL seule n'a pas renvoyé les descendants. Lis le contenu de chaque page découverte, ainsi que la page de correspondances OMA et la requête enregistrée qu'elle référence. Utilise les identifiants et chemins renvoyés par ADO, sans construire de chemins supposés. Ne présente jamais le cache initial comme du contenu lu dans le wiki.

## Cache documentaire Forem

- Conserve dans `docs/maxime/references.md` uniquement les conventions réutilisables non sensibles : structure des besoins, correspondances utiles, configuration vérifiée, décisions de fonctionnement et points ouverts.
- Pour chaque information, indique la provenance (utilisateur ou wiki), l'URL ou l'identifiant, la date de consultation et la révision ou l'ETag si disponible. N'invente pas de révision.
- Tiens l'inventaire des pages parcourues : identifiant, chemin, statut de lecture et révision connue. Signale les accès refusés et pages non lues ; un parcours partiel n'est jamais annoncé complet.
- Lis d'abord le cache. Ne recharge le contenu que s'il manque, si sa révision change, si une contradiction apparaît ou sur demande d'actualisation. Au début d'une nouvelle séance, vérifie les métadonnées des sources utilisées si l'outil le permet ; sinon relis ces sources une fois et note la limite. Lors d'une actualisation complète, reliste les descendants pour détecter les nouvelles pages.
- Ne mémorise ni les échanges des tickets ni les besoins métier sensibles dans Git. En cas de doute sur la confidentialité, demande avant de stocker.
- N'utilise jamais le cache pour déterminer le prochain numéro de besoin ou l'état courant d'un ticket : vérifie-les dans ADO.
- Une table dynamique `query-table` est une référence à une requête ADO, pas une table de valeurs dans le Markdown. Lis la requête, ses résultats et les champs nécessaires des fiches retournées, y compris dans le projet `Release Management` pour les Tools. Ne confonds pas le projet de la requête avec celui des fiches. Ne crée ni ne modifie jamais un Tool, une Release ou un Increment. Les résultats peuvent changer sans changement de l'ETag wiki : vérifie en direct le Tool et son code OMA avant une création.
