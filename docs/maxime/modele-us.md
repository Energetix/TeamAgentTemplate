# Modèle de PBI Support Request

Ce modèle définit les rubriques demandées par l'utilisateur. Les conventions complémentaires vérifiées sont résumées dans `references.md`. Les éléments entre crochets sont des emplacements à renseigner, jamais du contenu à publier tel quel.

## Le titre

`[Code OMA][NNN].[NN] - [Fonctionnalité apportée]`

Format confirmé par l'utilisateur : code OMA suivi de trois chiffres, d'un point et de deux chiffres, par exemple `LDC001.01 - [Titre de la User Story]`. LDC est un exemple, pas une application imposée. La signification et l'incrémentation des deux nombres restent non définies : utiliser un numéro fourni ou demander avant création. Vérifier les doublons en direct.

## Champs ADO

Utiliser uniquement le type `Support Request`, dans `Tools Backlogs\Squads\Prague`, après vérification de sa disponibilité et de ses champs. Ce libellé a été confirmé par l'utilisateur après le refus ADO de `Service Request`. Ne pas remplacer ce type par `User story`, `Service Request` ou `Issue` s'il est absent. Utiliser `System.Title` pour le titre, `System.Description` pour les seules rubriques décrites dans la section suivante et `Microsoft.VSTS.Common.AcceptanceCriteria` pour les scénarios d'acceptation. Vérifier ses formats avant publication ; les métadonnées de `User story` ne prouvent pas celles de `Support Request`.

## Contenu du champ Description

### Expression du besoin

En tant que [rôle utilisateur], je souhaite [besoin], afin de [valeur métier].

[Périmètre confirmé, contexte nécessaire, exclusions et dépendances connues.]

### Les règles métier

- RM-01 : [Condition, règle de décision et conséquence confirmées.]

Une règle métier régit ou influence le comportement, les décisions ou les processus du domaine. Ne pas transformer un exemple générique en exigence du projet.

### Accès aux données

| Donnée utilisée | Provenance vérifiée | Règle de calcul éventuelle | Source ou point à clarifier |
| --- | --- | --- | --- |
| [Donnée] | [Web service ; base/table/champ ; fichier JSON/XML ; autre source confirmée] | [Règle métier référencée si calcul] | [Référence vérifiée ou question ouverte] |

Toute information métier nécessaire mais manquante est marquée « À clarifier ». Une rubrique ne devient « Sans objet » qu'après confirmation et avec justification.

Ne pas publier dans la description la grille INVEST, une section « Critères d'acceptation » (même un simple renvoi), ni une section « État de l'affinage ».

### Éléments facultatifs

Ces consignes ne sont pas des rubriques à copier dans le ticket :

- Maquette d'écran : mentionner uniquement celle fournie dans le besoin initial. Sinon, ne pas créer la rubrique et ne pas demander de maquette par défaut.
- UML : les diagrammes Mermaid relèveront d'un sous-agent dédié. Ne pas publier une section vide ou un livrable supposé ; référencer seulement un diagramme réellement disponible et validé. Aucun sous-agent UML n'est encore configuré.

## Contenu du champ Acceptance Criteria

Ce contenu est publié uniquement dans le champ dédié, jamais dans Description. Lors d'une correction qui ne vise que la description ou la discussion, conserver les critères existants sans modification.

### CA-01 : [Résultat métier vérifiable]

- Étant donné [contexte et préconditions],
- Lorsque [action de l'utilisateur ou événement],
- Alors [résultat observable attendu].

[Ajouter les scénarios pertinents, notamment limites et erreurs, après clarification des résultats attendus.]

## Discussion du ticket

Utiliser un ton naturel et des paragraphes courts. Regrouper les questions en trois sujets au maximum : titre explicite, question principale, puis puces pour les précisions. Le premier commentaire peut commencer par « Affinage initial : 3 questions avant de continuer », un bref « Contexte confirmé » et les propositions « À confirmer ». Adapter le nombre réel de sujets et éviter les rappels de procédure répétitifs. Écrire `**Libellé** :` pour les libellés en gras dans ADO.
