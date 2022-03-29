#!/bin/bash
 
#SBATCH -N 1  # number of nodes
#SBATCH -n 1  # number of "tasks" (default: allocates 1 core per task)
#SBATCH -t 0-00:10:00   # time in d-hh:mm:ss
#SBATCH -p serial       # partition 
#SBATCH -q normal       # QOS
#SBATCH -o slurm.%j.out # file to save job's STDOUT (%j = JobId)
#SBATCH -e slurm.%j.err # file to save job's STDERR (%j = JobId)
#SBATCH --mail-type=ALL # Send an e-mail when a job starts, stops, or fails
#SBATCH --mail-user=%u@asu.edu # Mail-to address
#SBATCH --export=NONE   # Purge the job-submitting shell environment

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
