name=$1
echo 'Hello, $name!'
echo "Hello, $name!"

#for n in {1..10}; do
#	touch file$n
#done

for f in *; do
	echo $f
done

# download a bunch of hansards
#for n in {154..164}; do
#	curl -O https://www.ourcommons.ca/Content/House/451/Debates/$n/HAN$n-E.XML
#done

echo "Total number of interjections in last 10 sittings:"
grep "Interjection" *.XML | wc -l
