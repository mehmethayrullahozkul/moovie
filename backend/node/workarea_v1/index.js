const express = require('express');
const parse = require('body-parser');
const wordPair = require('./word_pair_generator.js');



const app = express();
const port = 3040;






app.use(parse.urlencoded({ extended: true }));
app.use(parse.json());



app.listen(port, async () => 
    {
        await wordPair.load();
        console.log(`Server is running on port ${port}`);
    }
);


app.use((err, req, res, next) => {
    if (err instanceof SyntaxError && err.status === 400 && 'body' in err) {
        console.error(err);
        return res.status(400).send({ status: 400, message: err.message }); // Bad request
    }
    next();
});


app.get('/getrandomwordpairs', async (req, res) => {

    const count = req.body['count'];

    if(count == undefined || count == null || count == '')
    {
        res.status(400).send({status: false, error: 'count is not defined'});
        return;
    }

    if(typeof count !== 'string' && typeof count !== 'number')
    {
        res.status(400).send({status: false, error: 'count is not a string or number'});
        return;
    }



    if(typeof count === 'string')
    {
        let parse = count.match(/^\d+$/g);
        if(parse == null)
        {
            res.status(400).send({status: false, error: 'count is not a number'});
            return;
        }
    }

    
   
    let wordCount = parseInt(count);

    if(isNaN(wordCount))
    {
        res.status(400).send({status: false, error: 'count is not a number'});
        return;
    }

    if(wordCount < 1)
    {
        res.status(400).send({status: false, error: 'count is less than 1'});
        return;
    }

    if(wordCount > 100)
    {
        wordCount = 100;
    }

    let wordPairs = wordPair.getRandomWordPairs(wordCount);



    res.status(200).send({status: true, wordPairs: wordPairs});
    
});


app.post('/getrandomwordpairs', async (req, res) => {

    const count = req.body['count'];

    if(count == undefined || count == null || count == '')
    {
        res.status(400).send({status: false, error: 'count is not defined'});
        return;
    }

    if(typeof count !== 'string' && typeof count !== 'number')
    {
        res.status(400).send({status: false, error: 'count is not a string or number'});
        return;
    }



    if(typeof count === 'string')
    {
        let parse = count.match(/^\d+$/g);
        if(parse == null)
        {
            res.status(400).send({status: false, error: 'count is not a number'});
            return;
        }
    }

    
   
    let wordCount = parseInt(count);

    if(isNaN(wordCount))
    {
        res.status(400).send({status: false, error: 'count is not a number'});
        return;
    }

    if(wordCount < 1)
    {
        res.status(400).send({status: false, error: 'count is less than 1'});
        return;
    }

    if(wordCount > 100)
    {
        wordCount = 100;
    }

    let wordPairs = wordPair.getRandomWordPairs(wordCount);



    res.status(200).send({status: true, wordPairs: wordPairs});
    
});

