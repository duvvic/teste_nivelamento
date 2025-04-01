const express = require("express");
const cors = require("cors");
const fs = require("fs");
const csvParser = require("csv-parser");

const app = express();
app.use(cors());

let operadoras = [];

fs.createReadStream("downloads/Relatorio_cadop.csv")
    .pipe(csvParser({ separator: ";" }))
    .on("data", (row) => operadoras.push(row))
    .on("end", () => console.log("CSV carregado com sucesso!"));

app.get("/api/search", (req, res) => {
    const query = req.query.query.toLowerCase();
    const results = operadoras.filter((op) =>
        op.nome_fantasia.toLowerCase().includes(query)
    );
    res.json(results);
});

app.listen(3000, () => console.log("Servidor rodando em http://localhost:3000"));