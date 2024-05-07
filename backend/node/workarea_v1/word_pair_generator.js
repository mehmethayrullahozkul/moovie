const readline = require('readline');
var fs = require('fs');

class WordPair
{
    totalWordPairs = [];
    filename = '';


    constructor(filename)
    {
        this.filename = filename;
        this.totalWordPairs = [];
        this.load();
    }

    async load()
    {
        await new Promise((resolve, reject) => {
            var lineReader = readline.createInterface({
              input: fs.createReadStream(this.filename)
            });
        
            lineReader.on('line', (line) => {
              const words = line.split('-');
              /* this.totalWordPairs?.push({original: "words[0]", translation: "words[1]"});
              this.totalWordPairs?.push({original: "words[1]", translation: "words[0]"}); */
                this.totalWordPairs.push({original: words[0], translation: words[1]});
              /* console.log(words[0] + ' - ' + words[1]); */
            });
        
            lineReader.on('close',  () => {
                resolve();
            });
          });
    }

    getRandomWordPairs(count)
    {
        let wordPairs = [];
        for(let i = 0; i < count; i++)
        {
            wordPairs.push(this.totalWordPairs[Math.floor(Math.random() * this.totalWordPairs.length)]);
        }
        return wordPairs;
    }

    getRandomWordPair()
    {
        return this.totalWordPairs[Math.floor(Math.random() * this.totalWordPairs.length)];
    }
}

async function test()
{
    const wordPairGenerator = new WordPair('words.txt');
    console.log(wordPairGenerator.getRandomWordPairs(5));
}

const wordPairGenerator = new WordPair('words.txt');
module.exports = wordPairGenerator;