# Load Module
module purge
module add trimmomatic/0.33

infile="$1"
outdir="$2"

mkdir -p "$outdir"

# Trim Jar
TRIM_BIN="java -jar /packages/7x/trimmomatic/0.33/trimmomatic.jar"
TRIM_ARGS="SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:scripts/NexteraPE-PE.fa:2:40:15"

# Create basename
base=$(basename "${infile}" _1.fastq.gz)
indir=$(dirname "${infile}")

# Run Trimmomatic
$TRIM_BIN PE "${indir}/${base}_1.fastq.gz" "${indir}/${base}_2.fastq.gz" \
  "${outdir}/${base}_1.trim.fastq.gz" "${outdir}/${base}_1un.trim.fastq.gz" \
  "${outdir}/${base}_2.trim.fastq.gz" "${outdir}/${base}_2un.trim.fastq.gz" \
  ${TRIM_ARGS}
