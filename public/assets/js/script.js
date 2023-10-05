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




// document.querySelector('.add-to-cart-button').addEventListener('click', function() {
//     const productId = this.dataset.productId;
//     addToCart(productId);
// });

// function addToCart(productId) {
//     fetch(`https://localhost:8001/add/${productId}`, {
//         method: 'POST',
//         headers: {
//             'X-Requested-With': 'XMLHttpRequest',
//         },
//     })
//     .then(response => response.json())
//     .then(data => {
//         // Update the cart in the frontend
//         // For example, update the number of items in the cart
//         document.querySelector('.cart-items').textContent = data.totalItems;
//     })
//     .catch(error => {
//         console.error('Error:', error);
//     });
// }

