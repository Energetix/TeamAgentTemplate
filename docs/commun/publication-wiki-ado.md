# Publication dans un wiki Azure DevOps

Procédure commune à Maxime, Simone et Joao. Lis-la avant toute écriture avec `ado/wiki_upsert_page`. La cible dépend du mode de wiki de `PROJET.md` (voir les règles communes) et, pour Joao en contexte Forem, de `docs/joao/forem.md`.

- Publie uniquement dans le wiki autorisé pour ta demande. Ne supprime, ne déplace et ne renomme aucune page. L'outil n'est restreint à aucun projet : vérifie toi-même que la page cible appartient au wiki autorisé.
- **Avant l'écriture**, relis la page cible avec `ado/wiki`. L'outil crée la page si elle est absente, sinon il la remplace entièrement : une création sur un chemin existant devient une mise à jour.
- **Pour une mise à jour**, pars du contenu actuel complet, modifie seulement la partie demandée et transmets l'`etag` lu juste avant, afin que l'écriture échoue si la page a changé entre-temps. Après un conflit, relis la page et refais la mise à jour à partir de son nouveau contenu ; ne relance jamais sans `etag`.
- Utilise la syntaxe du Wiki Azure DevOps, notamment `::: mermaid` et `:::` à la place des blocs ` ```mermaid ` pour les diagrammes. Dans un diagramme fourni par UMLCreator, ne change que ces délimiteurs.
- Indique dans ta réponse le wiki, le chemin, l'action (création ou mise à jour) et le résumé des changements. Aucune confirmation humaine n'est requise pour chaque écriture.
- **Après l'écriture**, relis la page et indique le résultat réellement constaté. Si l'outil échoue ou si les droits ADO l'empêchent, signale-le sans annoncer de publication.
