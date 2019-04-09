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

# Start docusaurus
echo "Docusaurus built"