cd data/untrimmed_fastq

# Read the meta-data file line by line and download the file if it doesn't exist.
# The while loop will loop over each line, and populate a `filename` and a `url`
# variable from each line.
while read filename url; do
  if [ ! -f "$filename" ]; then
    echo Downloading "$filename" ...
    curl -o "$filename" "$url"
  fi
done < data_urls.txt

echo Validating Files ...

md5sum -c < CHECKSUMS.MD5
