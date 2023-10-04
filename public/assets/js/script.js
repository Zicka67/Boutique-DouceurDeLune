function updateCart(actionUrl) {
    // Envoie une requête HTTP GET à l'URL spécifiée (actionUrl)
    fetch(actionUrl)
        // Une fois que la requête est complète, convertit la réponse en objet JSON
        .then(response => response.json())
        // Utilise les données JSON pour update le contenu de l'élément HTML avec l'id 'totalItems'
        .then(data => {
            document.getElementById('totalItems').textContent = data.totalItems;
        })
        // Si une erreur se produit, elle est gardée dans la console
        .catch(error => console.error('Error:', error));

    }

//         Cette fonction JavaScript utilise AJAX pour obtenir le nombre total d'articles dans le
//         panier depuis le serveur et mettre à jour l'interface utilisateur en conséquence, sans avoir besoin de recharger toute la page. 
//         On peut appeler cette fonction chaque fois qu'un utilisateur ajoute un article au panier, en retire un, 
//         ou effectue toute autre action qui pourrait modifier le nombre total d'articles dans le panier, afin de garder 
//         l'interface utilisateur synchronisée avec l'état du serveur.

