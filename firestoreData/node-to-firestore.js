const firebase = require("firebase");
// Required for side-effects
require("firebase/firestore");
console.log("workifn");
console.log(firebase);
// Initialize Cloud Firestore through Firebase
firebase.initializeApp(
   {
  apiKey: "AIzaSyCZSgkc8vKuaiTgKG0SKi9RN2qjx0YrYPE",
  authDomain: "evento-abbc1.firebaseapp.com",
  projectId: "evento-abbc1",
  storageBucket: "evento-abbc1.appspot.com",
  messagingSenderId: "651335019731",
  appId: "1:651335019731:web:6ce07fe04ffe5c6ab43826",
  measurementId: "G-NJZPP2D0ZR"
}
);

  
var db = firebase.firestore();

var menu =[  
    {  
       "id":1,
       "name":"Focaccia al rosmarino",
       "description":"Wood fired rosemary and garlic focaccia",
       "price":8.50,
       "type":"Appetizers"
    },
    {  
       "id":2,
       "name":"Burratta con speck",
       "description":"Burratta cheese, imported smoked prok belly prosciutto, pached balsamic pear",
       "price":13.50,
       "type":"Appetizers"
    }
 ]

menu.forEach(function(obj) {
    db.collection("menu").add({
        id: obj.id,
        name: obj.name,
        description: obj.description,
        price: obj.price,
        type: obj.type
    }).then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
});