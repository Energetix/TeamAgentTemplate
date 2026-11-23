# Modèle de PROJET.md

Maxime crée `PROJET.md` à la racine du dépôt cible avec l'utilisateur, à partir de ce modèle. Tous les agents le lisent ; seul Maxime le modifie. Les éléments entre crochets sont à renseigner ; supprimer les sections qui ne s'appliquent pas au mode choisi. Ne jamais y placer de secret, de jeton ni de donnée personnelle.

## Contenu à copier

```markdown
# Configuration du projet

| Paramètre | Valeur |
| --- | --- |
| Nom du projet | [Nom] |
| Contexte | [Forem ou Autre] |
| Code application | [Code court utilisé dans les titres et les ADR, par exemple LDC] |
| Mode de suivi | [ADO ou Local] |
| Mode de wiki | [ADO, Local ou Aucun] |

## Suivi ADO

À renseigner si le mode de suivi est ADO.

| Paramètre | Valeur |
| --- | --- |
| Organisation | [Nom de l'organisation] |
| Projet | [Nom du projet ADO] |
| Équipe | [Nom de l'équipe] |
| Zone (Area Path) | [Chemin] |
| Type de work item des besoins | [Type] |
| Convention de titre des besoins | [Convention] |
| Type de work item des bugs | [Type] |
| Zone des bugs | [Chemin] |
| Convention de titre des bugs | [Convention] |

## Suivi local

À renseigner si le mode de suivi est Local.

| Paramètre | Valeur |
| --- | --- |
| Fichier | `ANALYSE.md` |
| Identifiants | `FCT-NNN` pour les besoins, `BUG-NNN` pour les bugs |

## Wiki

| Paramètre | Valeur |
| --- | --- |
| Projet ADO du wiki | [Si mode ADO] |
| Wiki | [Nom ou identifiant, si mode ADO] |
| Chemin racine | [Chemin des pages du projet, si mode ADO] |
| Dossier local | [Par exemple `docs/wiki/`, si mode Local] |

## Historique

| Date | Modification | Demandée par |
| --- | --- | --- |
| [AAAA-MM-JJ] | Création | [PO] |
```

## Exemple : contexte Forem

Valeurs vérifiées et décisions enregistrées dans `docs/maxime/references.md` au 2026-11-23. Les vérifier avant usage.

| Paramètre | Valeur |
| --- | --- |
| Contexte | Forem |
| Mode de suivi | ADO |
| Organisation | `leforem` |
| Projet | `Tools Backlogs` |
| Équipe | `Squad Prague` |
| Zone (Area Path) | `Tools Backlogs\Squads\Prague` |
| Type de work item des besoins | `Support Request` |
| Convention de titre des besoins | `[Code OMA][NNN].[NN] - [Fonctionnalité]`, par exemple `LDC001.01 - ...` |
| Type, zone et convention des bugs | Non définis à ce jour : à demander au PO |
