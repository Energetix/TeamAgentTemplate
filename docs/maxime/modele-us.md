# Modèle de besoin

Ce modèle définit les rubriques d'un besoin, quel que soit le mode de suivi : ticket ADO ou section `FCT-NNN` de `ANALYSE.md` (voir `modele-analyse.md`). Les éléments entre crochets sont des emplacements à renseigner, jamais du contenu à publier tel quel.

## Le titre

Le titre suit la convention définie dans `PROJET.md`. En mode local, il est précédé de l'identifiant `FCT-NNN`.

En contexte Forem, le format confirmé par l'utilisateur est `[Code OMA][NNN].[NN] - [Fonctionnalité apportée]`, par exemple `LDC001.01 - [Titre]`. LDC est un exemple, pas une application imposée. La signification et l'incrémentation des deux nombres restent non définies : utiliser un numéro fourni ou demander avant création. Vérifier les doublons en direct. Les conventions Forem vérifiées sont résumées dans `references.md`.

## Champs ADO

En mode ADO, utiliser le type de work item défini dans `PROJET.md`, après vérification de sa disponibilité et de ses champs. Les rubriques ci-dessous vont dans le champ de description ; les scénarios d'acceptation vont dans le champ dédié aux critères d'acceptation, jamais dans la description. Vérifier les formats avant publication.

En contexte Forem : type `Support Request` uniquement, dans `Tools Backlogs\Squads\Prague`. Ce libellé a été confirmé par l'utilisateur après le refus ADO de `Service Request` ; ne pas le remplacer par `User story`, `Service Request` ou `Issue` s'il est absent. Champs : `System.Title`, `System.Description` et `Microsoft.VSTS.Common.AcceptanceCriteria`. Les métadonnées de `User story` ne prouvent pas celles de `Support Request`.

## Contenu de la description

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

Ces consignes ne sont pas des rubriques à copier dans le besoin :

- Maquette d'écran : mentionner uniquement celle fournie dans le besoin initial ou produite par Simone pour ce besoin, en donnant seulement son chemin ou son lien. Sinon, ne pas créer la rubrique et ne pas demander de maquette par défaut.
- Diagrammes : ne pas solliciter `UMLCreator` pour rédiger un besoin. En mode ADO, les tickets n'affichant pas le rendu Mermaid, ne pas y publier de blocs source Mermaid. Si un flux doit être expliqué dans le besoin, le décrire en texte clair, sans ajouter de rubrique « Diagrammes » vide. Les diagrammes Mermaid peuvent être produits séparément, hors du besoin, à la demande de l'utilisateur ou d'un agent autorisé.

## Contenu des critères d'acceptation

En mode ADO, ce contenu est publié uniquement dans le champ dédié, jamais dans la description. En mode local, il forme la rubrique « Critères d'acceptation » du besoin. Lors d'une correction qui ne vise que la description ou la discussion, conserver les critères existants sans modification.

### CA-01 : [Résultat métier vérifiable]

- Étant donné [contexte et préconditions],
- Lorsque [action de l'utilisateur ou événement],
- Alors [résultat observable attendu].

[Ajouter les scénarios pertinents, notamment limites et erreurs, après clarification des résultats attendus.]

## Discussion

En mode ADO, la discussion du ticket porte les questions. En mode local, la rubrique « Questions et réponses » de `ANALYSE.md` la remplace. Utiliser un ton naturel et des paragraphes courts. Regrouper les questions en trois sujets au maximum : titre explicite, question principale, puis puces pour les précisions. Le premier commentaire peut commencer par « Affinage initial : 3 questions avant de continuer », un bref « Contexte confirmé » et les propositions « À confirmer ». Adapter le nombre réel de sujets et éviter les rappels de procédure répétitifs. Écrire `**Libellé** :` pour les libellés en gras dans ADO.
