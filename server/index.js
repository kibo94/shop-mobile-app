import express, { json } from "express";
import fs from "fs"
import https from "https"
import path from "path";
import cors from "cors"
import nodemailer from "nodemailer";

// import serviceAccount from "path/to/key.json"
const app = express()


const port = process.env.PORT || 4000;
const users = [
    {
        fullName: "Bojan Bogdanovic",
        email: "bojanb106@gmail.com",
        password: "12345",
        address: "Vladike Nikolaja 100/5",
        city: "Čačak",
        phone: "0617238135"
    },
    {
        fullName: "Test Testovic",
        email: "test@gmail.com",
        password: "123",
        address: "Nemanjina 55",
        city: "Čačak",
        phone: "0612221113"
    },
    {
        fullName: "John Doe",
        email: "jondoe@gmailmail.com",
        city: "Čačak",
        password: "12345",
        address: "Nemanjina 33",
        phone: "0612221413"
    }
]
let products = [
    {
        "id": 1,
        "name": "ananas",
        "author": "typicode223",
        "type": "fruits",
        "price": 300,
        "onStack": true,
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
        "onStack": true,
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
        "onStack": true,
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
        "onStack": true,
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
        "onStack": true,
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
        "onStack": true,
        "rating": 4,
        "imgUrl": "https://m.media-amazon.com/images/I/61Qe0euJJZL.jpg",
        "comments": []
    },

    {
        "id": 8,
        "name": "Lenovo 123",
        "author": "typicode223",
        "type": "laptops",
        "details": "Dobra lubenica",
        "quantity": 0,
        "price": 35000,
        "onStack": true,
        "rating": 4,
        "imgUrl": "https://m.media-amazon.com/images/I/61Qe0euJJZL.jpg",
        "comments": []
    },
    {
        "id": 9,
        "name": "grasak",
        "author": "typicode223",
        "type": "vegetables",
        "details": "Dobra lubenica",
        "quantity": 0,
        "price": 35000,
        "onStack": true,
        "rating": 4,
        "imgUrl": "https://m.media-amazon.com/images/I/61Qe0euJJZL.jpg",
        "comments": []
    },
]

app.use(express.json())
app.use(cors({
    origin: "*"
}))
app.use(cors({
    methods: ['GET', 'POST', 'DELETE', 'UPDATE', 'PATCH', 'PUT']
}))
// });
app.post('/createReceipt', (req, res) => {
    var products = JSON.parse(req.body.products);
    var email = req.body.email
    var totalPrice = 0;
    products.forEach(prd => totalPrice += prd.price * prd.quantity)
    var table = ""
    table += `<table  style="          font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%> 
    <tr style=":nth-child(even) { background-color: #dddddd;}">
    <th style=" border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;">Proizvod</th>
    <th style=" border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;">Kolicina</th>
    <th style=" border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;">Cena</th>
    <th style=" border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;">Ukupno</th>
</tr>
    `
    products.forEach(product => {

        table += `
     <tr>
     <td style=" border: 1px solid #dddddd;
     text-align: left;
     padding: 8px;">${product.name}</td>
     <td style=" border: 1px solid #dddddd;
     text-align: left;
     padding: 8px;">${product.quantity}</td>
     <td style=" border: 1px solid #dddddd;
     text-align: left;
     padding: 8px;">${product.price} din</td>
     <td style=" border: 1px solid #dddddd;
     text-align: left;
     padding: 8px;">${product.price * product.quantity} din</td>
 </tr>`
    })
    table += `
    <tr>
    <td style=" border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;">Total</td>

  
    <td style=" border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;">${totalPrice} din</td>
</tr>`
    table += '</table>'
    var html = `<div style="width: 100%;">
    <div style="width:300px;  position: relative; left: 50%; transform: translateX(-50%); text-align: center;  box-shadow: rr ">
    <h1 style="margin-bottom: 40px;">BOGI SHOP</h1>
     ${table}
     <p style="text-align: left;    width: 300px;">Hvala na kupovini i ukazanom poverenju...</p>
    </div>
    
    </div>
    `
    const transporter = nodemailer.createTransport({
        service: "gmail",

        // Use `true` for port 465, `false` for all other ports
        auth: {
            user: "bojanb0794@gmail.com",
            pass: "hixrjsyerfvhwkif",
        },
    });
    // async..await is not allowed in global scope, must use a wrapper
    async function main() {
        // send mail with defined transport object
        const info = await transporter.sendMail({
            from: '"Bogi shop <bojanb0794@gmail.com>', // sender
            to: `bojanb0794@gmail.com, ${email}`, // list of receivers
            subject: "Porudzbenica Bogi Shop", // Subject line

            html: html, // html body
        });

        console.log("Message sent: %s", info.messageId);

        // Message sent: <d786aa62-4e0a-070a-47ed-0b0666549519@ethereal.email>
    }
    res.status(200).json({ msg: "Receipt has been created" });
    main().catch(console.error);
})


app.get('/', (req, res) => {
    console.log('hi form api')
    res.json({ 'name': "bojan" })

});

app.get('/search', (req, res) => {
    var text = req.query.text;
    var searchedPrds = products
        .filter(product => product.name.toLocaleLowerCase()
            .includes(text.toLowerCase()));
    console.log(searchedPrds)
    res.json(searchedPrds);

})
app.get('/filters', (req, res) => {
    var filters = products.map((product) => product.type)

    res.json(filters.filter((item, pos) => filters.indexOf(item) == pos));

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

app.post('/register', async (req, res) => {
    let user = users.find(user => user.email == req.body.email)
    try {
        if (user) throw new Error('User not exists');
        var { email, password, fullName, city, address, phone } = req.body;
        users.push({ email, password, fullName, city, address, phone });
        res.json(200)
    } catch (error) {
        console.log("catch triggereddd")
        console.log(error.message)
        res.status(404).json({ success: false, error: error.message });
    }
})
app.put('/filterProducts', (req, res) => {
    const prodType = req.body.type.toLowerCase();
    const filteredProducts = prodType == "all" ? products : products.filter(prod => prod.type == prodType);
    res.json(filteredProducts);
})
app.post('/comments', (req, res) => {
    let id = req.body.id;
    let comment = req.body.comment
    let user = req.body.user
    products = products.map(prodcut => {
        if (prodcut.id == id) {
            prodcut.comments.push({ id: prodcut.comments.length, comment, user, rating: req.body.rating, });
            return prodcut;
        }
        return prodcut;
    });
    res.json(products);

})

const httpsServer = https.createServer({
    key: fs.readFileSync(path.join("cert", "key.pem")),
    cert: fs.readFileSync(path.join("cert", "cert.pem"))
}, app);

// httpsServer.listen(port, (s) => console.log('port is live', port))



app.listen(port);