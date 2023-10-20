// Attendre que le document soit entièrement chargé
$(document).ready(function() {
    // Off('click') => supprime tous les événements 'click' précédemment attachés, puis ajouter un nouvel événement 'click'
    $('.add-to-cart-button').off('click').click(function() {
    console.log('Bouton cliqué');
    
    // Récupére l'ID du produit stocké dans l'attribut 'data-product-id' du bouton
    var productId = $(this).data('product-id');
    
    // Requête AJAX
    $.ajax({
        // URL à laquelle la requête est envoyée
        url: "{{ path('add_to_cart') }}",
        
        method: 'POST',
        
        // Données envoyées au serveur
        data: {
            productId: productId
        },
        
        // Fonction à exécuter si la requête réussit
        success: function(response) {
            // Update le texte de l'élément ayant l'ID 'totalItems' avec le nbr total d'articles dans le panier
            $('#totalItems').text(response.cartCount);
            
            // Affiche un message d'alerte avec le message renvoyé par le serveur
            alert(response.message);
        },
        
        // Fonction à exécuter si la requête échoue
        error: function() {
            // Affiche un message d'alerte indiquant que quelque chose s'est mal passé
            alert('Une erreur est survenue lors de l\'ajout au panier.');
        }
                });
            });
        });


        // ******* AJOUTER ******

        $(".btn-success").off('click').click(function(event) {
            event.preventDefault(); // Empêche le comportement par défaut (redirection)
            
            var url = $(this).attr("href"); // Récupère l'URL depuis l'attribut href du bouton
        
            // Envoie une requête AJAX pour ajouter l'article au panier
            $.ajax({
                url: url, // L'URL pour l'action "add" du contrôleur
                method: 'GET', // La méthode HTTP, dans ce cas GET car vous utilisez {id} dans l'URL
                success: function(response) {
                    console.log(response);
                    // Mettre à jour le nombre total d'articles dans le panier
                    $("#totalItems").text(response.totalItems);
                    $(".card-info span").first().text(response.totalItems);
                    $(".card-info span").last().text(response.total / 100 + ' €');
                
                    // Mettre à jour la quantité en stock
                    $("#stockForProduct" + response.productId).text(response.newStock);
                  
                    // Mettre à jour la quantité dans le panier
                    $("#quantityForProduct" + response.productId).text(response.newQuantity);
                },
                error: function() {
                    alert('Une erreur est survenue lors de l\'ajout au panier.');
                }
            });
        });
        