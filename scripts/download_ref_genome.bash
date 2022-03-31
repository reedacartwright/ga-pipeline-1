ref_dir=data/ref_genome
ref_file=$ref_dir/ecoli_rel606.fasta
url="ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/017/985/GCA_000017985.1_ASM1798v1/GCA_000017985.1_ASM1798v1_genomic.fna.gz"

mkdir -p $ref_dir
curl -L $url | gunzip > $ref_file

module purge
module add bwa/0.7.17

bwa index $ref_file

