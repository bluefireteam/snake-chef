const fs = require('fs');
const readline = require('readline');

const stagesStream = fs.createReadStream('./files/stages.csv', 'utf8');
const statesReadLine = readline.createInterface({
    input: stagesStream,
    crlfDelay: Infinity
});

const STAGE = 0;
const HOLES = 1;
const RECIPE_1 = 2;
const RECIPE_2 = 3;
const RECIPE_3 = 4;
const RECIPE_4 = 5;
const TIME = 9;

statesReadLine.on('line', (line) => {
    const stageData = line.split(';');

    if (stageData[STAGE].toLowerCase() !== 'stage') {
        const stage = {
            stageNumber: parseInt(stageData[STAGE]),
            time: parseInt(stageData[TIME]),
            recipes: [
                stageData[RECIPE_1], stageData[RECIPE_2], stageData[RECIPE_3], stageData[RECIPE_4]
            ],
            holes: parseInt(stageData[HOLES])
        }

        fs.writeFileSync(`../snake_chef/assets/stages/${stage.stageNumber}.json`, JSON.stringify(stage, null, 2), 'utf8')
    }
})
