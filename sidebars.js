
var fs = require('fs');
var contractNames = [];

fs.readdir('../../governanceapp/contracts', (err, files) => {
    files.forEach(file => {
        contractNames.push(file.split('.')[0]);
    });

    var data = {
        'docs': {
            'Geting Started': contractNames,
            'Docusaurus': [
                'doc1'
            ]
        }
    }
    fs.writeFileSync('./sidebars.json', JSON.stringify(data))

});