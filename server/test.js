// import express from "express";
// import fs from "fs"
// import https from "https"
// import http from "http"
// import path from "path";
// import cors from "cors"
// import nodemailer from "nodemailer";
// import { MongoClient, ServerApiVersion } from "mongodb"
// import { WebSocketServer } from "ws"
// import WebSocket from "ws";
var express = require("express");
var fs = require("fs");
var https = require("https");
var http = require("http");
var path = require("path");
var cors = require("cors");
var nodemailer = require("nodemailer");
var { MongoClient, ServerApiVersion } = require("mongodb")

const WebSocket = require('ws');

// import serviceAccount from "path/to/key.json"
const app = express()


const port = process.env.PORT || 4000;
const port2 = process.env.PORT2 || 8081;


let users = [

]
let products = [];
let messages = [{ text: "Welcome to group chat", timestamp: new Date() }]

var dbURI = "mongodb+srv://bojan947:Bojan947@bogishop.jnzb5zx.mongodb.net/?retryWrites=true&w=majority&appName=bogiShop"
var client;
var db;
// Create a MongoClient with a MongoClientOptions object to set the Stable API version

app.use(express.json())
app.use(cors({
    origin: "*"
}))
app.use(cors({
    methods: ['GET', 'POST', 'DELETE', 'UPDATE', 'PATCH', 'PUT']
}))
// });
// const server = new WebSocketServer({ port: port });
const httpsServer = https.createServer({
    key: fs.readFileSync(path.join("cert", "key.pem")),
    cert: fs.readFileSync(path.join("cert", "cert.pem"))
}, app);
var client = new MongoClient(dbURI, {

    serverApi: {
        version: ServerApiVersion.v1,
        strict: true,
        deprecationErrors: true,
    }
});
const wsServer = https.createServer(app)
const wss = new WebSocket.Server({ server: wsServer });
client.connect().then((cli) => {
    cli.db("Products").command({ ping: 1 });
    console.log("Pinged your deployment. You successfully connected to MongoDB!");
    db = cli.db("Products");
    wsServer.listen(port, () => { console.log(`Server run on port ${port}`) })
    // httpsServer.listen(port, (s) => console.log('port is live', port))
}).catch((err) => console.log(err));




app.post('/register', async (req, res) => {

    let user = users.find(user => user.email == req.body.email)
    try {
        if (user) throw new Error('User  exists');
        var { email, password, fullName, city, address, phone } = req.body;
        await db.collection("users").insertOne({ email, password, fullName, city, address, phone })
        res.json(200)

    } catch (error) {
        console.log("catch triggereddd")
        console.log(error.message)
        res.status(404).json({ success: false, error: error.message });
    }
})
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


    }
    res.status(200).json({ msg: "Receipt has been created" });
    main().catch(console.error);
})


app.get('/', async (req, res) => {

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

app.get('/products', async (req, res) => {
    console.log('hi form api')

    var dbProducts = await db.collection('products').find().toArray();

    res.json(dbProducts);

})
app.post('/login', async (req, res) => {
    var dbUsers = await db.collection('users').find().toArray();
    let user = dbUsers.find(user => user.email == req.body.email && user.password == req.body.password)
    try {
        if (!user) throw new Error('Wrong password or email ');
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
wss.on('connection', (ws) => {
    console.log("connection established")
    ws.send(JSON.stringify({ type: 'initial', data: messages }));
    // Listen for messages from the client

    ws.on('message', (message) => {
        const buff = Buffer.from(message, "utf-8");
        console.log(buff.toString())
        const messageData = { text: buff.toString(), timestamp: new Date() };
        wss.clients.forEach((client) => {
            if (client.readyState === WebSocket.OPEN) {
                client.send(JSON.stringify({ type: 'new', data: messageData }));
            }
        });
    });

    // Handle disconnection
    ws.on('close', () => {
        console.log('Client disconnected');
    });
});


app.post('/messages', async (req, res) => {

    const messageData = { text: req.body.text, timestamp: new Date() };
    messages.push(messageData)
    try {

        console.log(wss.clients)
        // Broadcast the new message to all WebSocket clients
        wss.clients.forEach((client) => {

            if (client.readyState === WebSocket.OPEN) {
                console.log("message sent")
                client.send(JSON.stringify({ type: 'new', data: messageData }));
            }
        });

        res.status(201).json(result.ops[0]);
    } catch (err) {
        res.status(500).json({ error: 'Failed to create message' });
    }
});
app.get('/messages', async (req, res) => {
    try {

        res.json(messages);
    } catch (err) {
        res.status(500).json({ error: 'Failed to fetch messages' });
    }
});







