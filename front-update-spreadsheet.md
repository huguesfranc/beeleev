# Mettre à jour du contenu Front

## Synchroniser le repository

Se placer dans le répertoire du projet:

```shell
cd path/to/beeleev
```

Pull le repository depuis Github:

```shell
git pull
```

Mise à jour des dépendances:

```shell
bundle
```

Mise à jour de la base de données:

```shell
bundle exec rake db:migrate
```

## Démarrer l'application

Lancer le serveur avec Rails:

```shell
bundle exec rails s
```

Accéder à l'application: http://localhost:3000

## Modifier une vue

Ouvrir le projet avec Sublime Text.

- **Rechercher du texte:** ⇧⌘F pour rechercher dans le projet puis double clic sur les résultats pour accéder aux fichiers.
  Penser à scoper la recherche (généralement `app/views` ou `app/assets/stylesheets`) pour réduire le nombre de résultats.
  
  ![capture d ecran 2018-06-06 a 11 52 17](https://user-images.githubusercontent.com/3743321/41031345-afff11b6-6980-11e8-8774-3ef51873dbec.png)
  ![capture d ecran 2018-06-06 a 11 41 42](https://user-images.githubusercontent.com/3743321/41031221-760926f4-6980-11e8-9327-914847a264dc.png)

- **Ne pas modifier l'ERB:** l'ERB ou *Embedded Ruby* est le code contenu entre `<%` et `%>`.
  C'est d'ici que provient le contenu dynamique (nom d'utilisateur, résultats de recherche, ...)
  dont on ne souhaite généralement pas changer le comportement.
  
  ```erb
    <table class="table">
      <thead class="table__header">
        <tr class="table__row table__row--header">
          <th class="table__cell table__cell--header">Name</th>
          <th class="table__cell table__cell--header">Company</th>
          <th class="table__cell"></th>
        </tr>
      </thead>
      <tbody class="table__body">
      
        <%# Cette ligne d'ERB itère sur une liste de clients %>
        <% @clients.each do |client| %>
          <tr class="table__row">
          
            <%# Cette balise td contient le nom du client %>
            <td class="table__cell"><%= client.full_name %></td>
            
            <%# Cette balise td contient le nom de l'entreprise %>
            <td class="table__cell"><%= client.company %></td>
            
            <td class="table__cell table__cell--actions">
              <div class="actions">
              
                <%# Ces lignes d'ERB ajoutent des boutons html %>
                <%= destroy_button client, minimal: true %>
                <%= edit_button client, minimal: true %>
              </div>
            </td>
          </tr>
        <% end %>
      </tbody>
    </table>
  ```
  
  On peut voir 3 façons d'initier du code ERB:
  - `<%`:  Exécute juste le code ruby
  - `<%=`: Exécute le code Ruby et affiche le résultat
  - `<%#`: Initie un commentaire dans le code; ne fait rien

## Créer une page

Créer un fichier de la forme `nouvelle_page.html.erb` dans le répertoire `app/views/pages`: Le nom ne peut contenir que des lettres minuscules sans accent, des chiffres et des underscores. Il ne peut pas commencer par un underscore.

L'url de la page prendra la forme `https://www.beeleev.com/pages/nouvelle-page`: Les underscores sont remplacés par des tirets.

## Déployer l'application

Commit des modifications:

```shell
git add .
git commit -m "Description de mes modifications"
git push
```

Push sur le staging:

```shell
git push heroku-staging
```

Vérification du rendu en staging: http://beeleev-staging.herokuapp.com

**Mise en production:**

*Promote* depuis l'interface de la pipeline Heroku ou:

```shell
heroku pipelines:promote -a beeleev-staging
```

**Annuler le dernier déploiement:**

```shell
heroku rollback
```
