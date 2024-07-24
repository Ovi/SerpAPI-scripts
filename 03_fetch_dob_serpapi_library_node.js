require('dotenv').config();
const { getJson } = require('serpapi');

const api_key = process.env.SERPAPI_KEY;

const params = {
  engine: 'google',
  q: 'Imran Khan birthday',
  api_key,
};

getJson(params, (json) => {
  const birthday = json['knowledge_graph']?.['born'];

  if (birthday) console.log(`Imran Khan's birthday is ${birthday}`);
  else console.log('Birthday not found in the search result');
});
