# Modèle de ANALYSE.md

En mode de suivi local, Maxime crée `ANALYSE.md` à la racine du dépôt cible à partir de ce modèle. Il en est le seul rédacteur ; les autres agents le lisent. Les éléments entre crochets sont à renseigner. Les rubriques d'un besoin suivent `modele-us.md`.

## Contenu à copier

```markdown
# Analyse — [Nom du projet]

Configuration : voir `PROJET.md`.

## Index des besoins

| ID | Titre | Statut | Dernière mise à jour |
| --- | --- | --- | --- |
| FCT-001 | [Titre] | En affinage | [AAAA-MM-JJ] |

Statuts : `En affinage`, `Validé par le PO`, `Terminé`, `Abandonné`.

## FCT-001 — [Titre]

**Statut** : En affinage

### Expression du besoin

En tant que [rôle utilisateur], je souhaite [besoin], afin de [valeur métier].

[Périmètre confirmé, contexte nécessaire, exclusions et dépendances connues.]

### Règles métier

- RM-01 : [Règle confirmée.]

### Accès aux données

| Donnée utilisée | Provenance vérifiée | Règle de calcul éventuelle | Source ou point à clarifier |
| --- | --- | --- | --- |
| [Donnée] | [Provenance] | [Règle] | [Référence ou question] |

### Maquette

[Chemin de la maquette de Simone, par exemple `docs/ux/FCT-001/`. Supprimer la rubrique s'il n'y en a pas.]

### Critères d'acceptation

#### CA-01 : [Résultat métier vérifiable]

- Étant donné [contexte et préconditions],
- Lorsque [action ou événement],
- Alors [résultat observable attendu].

### Questions et réponses

| # | Date | Question | Posée par | Réponse | Source |
| --- | --- | --- | --- | --- | --- |
| Q-01 | [AAAA-MM-JJ] | [Question] | [Agent ou PO] | [Réponse ou « En attente »] | [Maxime, PO ou référence] |

### Historique

| Date | Modification |
| --- | --- |
| [AAAA-MM-JJ] | Création |

## Suivi des bugs

| ID | Besoin | Titre | Statut | Dernière mise à jour |
| --- | --- | --- | --- | --- |
| BUG-001 | FCT-001 | [Titre] | Ouvert | [AAAA-MM-JJ] |

Statuts : `Ouvert`, `En correction`, `À retester`, `Fermé`.

### BUG-001 — [Titre]

- **Besoin** : FCT-001
- **Statut** : Ouvert
- **Comportement attendu** : [Selon le besoin et ses critères]
- **Comportement constaté** : [Selon le rapport de tests]
- **Étapes de reproduction** :
  1. [Étape]
- **Rapport de tests** : [Référence]
- **Composants concernés** : [Si connus]

| Date | Modification |
| --- | --- |
| [AAAA-MM-JJ] | Création à partir de l'anomalie qualifiée par Joao |
```
