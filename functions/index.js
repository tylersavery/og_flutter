const functions = require("firebase-functions");

const fs = require("fs");
const axios = require('axios')
const BotDetector = require('device-detector-js/dist/parsers/bot');

const DEBUG_BOT = false;

exports.detail = functions.https.onRequest(async (request, response) => {

  let html = fs.readFileSync(`./index.html`, "utf8");

  const url = request.url;

  const urlParts = request.path.split("/");
  const id = urlParts[urlParts.length - 1];

    const botDetector = new BotDetector();
    const userAgent = request.headers["user-agent"].toString();
    const bot = botDetector.parse(userAgent)
    if(bot || DEBUG_BOT) {

        try {

            const response = await axios.get(`https://pokeapi.co/api/v2/pokemon/${id}`);
            const result = response.data;
            
            const image = result['sprites']['other']['official-artwork']['front_default'];
            const name = result['name'];
            const number = result['order'];
            
            html = `
            <!doctype html>
            <html lang="en">
            <head>
            <title>${name}</title>
            <meta property="og:locale" content="en_US" />
            <meta property="og:type" content="website" />
            <meta property="og:title" content='${name}' />
            <meta property="og:description" content="Pokemon #${number}" />
            <meta property="og:url" content="${url}" />
            <meta property="og:site_name" content="OG Flutter" />
            <meta property="og:image" content="${image}" />
            
            </head>
            <body>
            <h1>OG Flutter</h1>
            <h2>${name}</h2>
            <p>Pokemon #${number}</p>
            <img src="${image}" />
            </body>
            
            </html>
            `;

            return response.send(html);

        } catch(e) {
            console.log(e);
            return response.send(html);
        }
        
    }

    return response.send(html);
});
