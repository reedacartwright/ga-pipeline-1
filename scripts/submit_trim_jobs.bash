metadata=data/untrimmed_fastq/data_urls.txt
outdir=data/trimmed_fastq
infiles=$(cut -d' ' -f 1 $metadata | grep _1.fastq.gz)
indir=data/untrimmed_fastq

for filename in $infiles; do
  sbatch scripts/trimmomatic.bash $indir/$filename $outdir
done
