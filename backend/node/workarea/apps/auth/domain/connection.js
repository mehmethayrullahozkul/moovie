
const {MongoClient} = require('mongodb');
const uri = 'mongodb://hayrullahozkul_mongodb:mongodb_pass@0.0.0.0:27017/drinkup?authSource=admin';


let client = null;
let isConnected = false;

async function connectToMongoDB() {
  try {
    client = await MongoClient.connect(uri, { useNewUrlParser: true });
    isConnected = true;
  } catch (err) {
    client = null;
    isConnected = false;
  }
}

function closeConnection() {
  if (client) {
    client.close();
    client = null;
    isConnected = false;
  }
}

async function getDB(databaseName) {
  if (client && isConnected) {
    return await client.db(databaseName);
  } else {
    return null;
  }
}

module.exports = {
  connectToMongoDB,
  closeConnection,
  getDB,
};