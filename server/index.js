import express from "express";
import { initializeApp, applicationDefault } from "firebase-admin/app";
import { getMessaging } from "firebase-admin/messaging"
import fs from "fs"
import https from "https"
import path from "path";
import admin from "firebase-admin"
import cors from "cors"

// import serviceAccount from "path/to/key.json"
const app = express()


const port = process.env.PORT || 4000;
console.log(1234);
const users = [
    {
        email: "bojanb106@gmail.com",
        password: "12345"
    },
    {
        email: "test@gmail.com",
        password: "12345"
    },
    {
        email: "jondoe@gmailmail.com.com",
        password: "12345"
    }
]
let products = [
    {
        "id": 1,
        "name": "ananas",
        "author": "typicode223",
        "type": "fruits",
        "price": 300,
        "quantity": 0,
        "details": "Jako lepo voce i zdravo",
        "rating": 4,
        "comments": [{
            id: 1,
            comment: "Ananas je kao dobra, sve preporuke ovde kupiti...",
            user: "bojanb106@gmail.com",
            rating: 5,
        },
        {
            id: 1,
            comment: "nije bas nest",
            user: "bojanb106@gmail.com",
            rating: 4,
        },
        {
            id: 1,
            comment: "nije bas nest",
            user: "bojanb106@gmail.com",
            rating: 2,
        }



        ],

    },
    {
        "id": 2,
        "name": "jabuka11",
        "author": "typicode223",
        "type": "fruits",
        "quantity": 0,
        "details": "Jako lepo voce i zdravo, i",
        "price": 200,
        "rating": 3,
        "comments": []
    },

    {
        "id": 3,
        "name": "pomorandza",
        "author": "typicode223",
        "type": "fruits",
        "details": "Jako lepo voce i zdravo, i",
        "quantity": 0,
        "price": 400,
        "rating": 5,
        "comments": []
    },
    {
        "id": 4,
        "name": "kruska",
        "author": "typicode223",
        "type": "fruits",
        "quantity": 0,
        "details": "Jako lepo voce i zdravo i dobo za kompot",
        "price": 500,
        "rating": 3,
        "comments": []
    },
    {
        "id": 5,
        "name": "Lenovo 300",
        "author": "typicode223",
        "type": "laptops",
        "quantity": 0,
        "details": "Jako dobar laptop, brz, pouzdan....",
        "price": 30000,
        "rating": 5,
        "comments": []
    },
    {
        "id": 6,
        "name": "lenovo 2000",
        "author": "typicode223",
        "type": "laptops",
        "details": "Jako dobar laptop, brz, pouzdan i od kvalitetne plastike izradjen....",
        "quantity": 0,
        "price": 35000,
        "rating": 4,
        "imgUrl": "https://m.media-amazon.com/images/I/61Qe0euJJZL.jpg",
        "comments": []
    },
    // {
    //     "id": 0.2710531612825646,
    //     "name": "mac book pro i6",
    //     "author": "typicode223",
    //     "type": "laptops",
    //     "quantity": 0,
    //     "price": 180000
    // },
    // {
    //     "id": 0.5753682641423663,
    //     "name": "Lenovo 123",
    //     "author": "typicode223",
    //     "type": "laptops",
    //     "quantity": 0,
    //     "price": 100000
    // },
    // {
    //     "id": 1,
    //     "name": "grasak",
    //     "author": "typicode223",
    //     "type": "vegetables",
    //     "quantity": 0,
    //     "price": 300
    // },
    // {
    //     "id": 0.7193151800102087,
    //     "name": "krompir",
    //     "author": "typicode223",
    //     "type": "vegetables",
    //     "quantity": 0,
    //     "price": 250
    // },
    // {
    //     "id": 0.06581150853731477,
    //     "name": "boranija",
    //     "author": "typicode223",
    //     "type": "vegetables",
    //     "quantity": 0,
    //     "price": 400
    // },
    // {
    //     "id": 0.28139527398395026,
    //     "name": "lubenicca",
    //     "author": "typicode223",
    //     "type": "vegetables",
    //     "quantity": 0,
    //     "price": 350
    // }
]




app.use(express.json())
app.use(cors({
    origin: "*"
}))
app.use(cors({
    methods: ['GET', 'POST', 'DELETE', 'UPDATE', 'PATCH', 'PUT']
}))
// });


app.get('/', (req, res) => {
    console.log('hi form api')
    res.json({ 'name': "bojan" })

})

app.get('/products', (req, res) => {
    console.log('hi form api')
    res.json(products);

})
app.post('/login', async (req, res) => {
    let user = users.find(user => user.email == req.body.email)
    console.log(users)

    try {
        if (!user) throw new Error('User not exists');
        console.log("user loged in")
        res.status(200).json({ user: user });
    } catch (error) {
        console.log("catch triggered")
        console.log(error.message)
        res.status(404).json({ success: false, error: error.message });
    }


})
app.put('/filterProducts', (req, res) => {
    const prodType = req.body.type.toLowerCase();
    const filteredProducts = prodType == "all" ? products : products.filter(prod => prod.type == prodType);
    console.log(filteredProducts);
    res.json(filteredProducts);

})
app.post('/comments', (req, res) => {
    let id = req.body.id;
    let comment = req.body.comment
    let user = req.body.user
    products = products.map(prodcut => {
        if (prodcut.id == id) {
            prodcut.comments.push({ id: prodcut.comments.length, comment, user });
            return prodcut;
        }
        return prodcut;
    });
    console.log(products);
    res.json(products);

})
app.post('/register', async (req, res) => {
    let user = users.find(user => user.email == req.body.email)


    try {
        if (user) throw new Error('User not exists');
        users.push({ email: req.body.email, password: req.body.password });
        res.json(200)
    } catch (error) {
        console.log("catch triggered")
        res.status(404).json({ success: false, error: error.message });
    }


})


// const httpsServer = https.createServer({
//     key: fs.readFileSync(path.join("cert", "key.pem")),
//     cert: fs.readFileSync(path.join("cert", "cert.pem"))
// }, app);

// httpsServer.listen(port, (s) => console.log('port is live', port))



app.listen(port);