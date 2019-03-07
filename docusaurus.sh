DIRECTORY="$PWD/docusaurus"

if [ ! -d $DIRECTORY ]; then 

echo "--------------------docusaurus doesnot exist--------------------"

mkdir docusaurus &&
cd docusaurus &&
docusaurus-init &&
mv docs-examples-from-docusaurus docs &&
mv website/blog-examples-from-docusaurus website/blog &&
cd website &&
npm run build &&
cd ../..

else

echo "docusaurus exists"

fi

#build .md files
echo "--------------------Building .md files from--------------------"
echo $PWD
solidity-docgen $PWD/governanceapp $PWD/governanceapp/contracts $PWD/docusaurus

#edit sidebars.json in docusaurus
cd docusaurus/website

node <<EOF

//Read data
var fs = require('fs');

var data = {
  "docs": {
    "Geting Started": [
      "AdminValidatorSet",
      "Ownable",
      "SafeMath",
      "SimpleValidatorSet",
      "Voteable"
    ],
    "Docusaurus": [
      "doc1"
    ]
  }
}

//Output data
fs.writeFileSync('./sidebars.json',JSON.stringify(data))

EOF

# Start docusaurus
echo "Docusaurus built"
echo $PWD

