#!/bin/bash
#SBATCH --partition=componc_cpu,componc_gpu
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --mem=8GB
#SBATCH --job-name=transcripts
#SBATCH --mail-user=preskaa@mskcc.org
#SBATCH --mail-type=END,FAIL
#SBATCH --output=slurm%j_snkmk.out


## activate nf-core conda environment
source /home/preskaa/miniconda3/bin/activate nf-core

## load modules
module load singularity/3.7.1
## example samplesheet
## technical replicates get merged ...
outdir=/data1/shahs3/users/preskaa/bulk_illumina-rnaseq_test
samplesheet=${HOME}/bulk-illumina-rnaseq/resources/bbsplit_samplesheet.csv
ref_genome=/data1/shahs3/reference/ref-sarcoma/GRCh38/v45/GRCh38.primary_assembly.genome.fa
ref_gtf=/data1/shahs3/reference/ref-sarcoma/GRCh38/v45/gencode.v45.primary_assembly.annotation.gtf
bbsplit_fasta_list=${HOME}/bulk-illumina-rnaseq/resources/bbsplit_fasta.csv
## specify path to out directory
wrkdir=${outdir}/work

nextflow run shahcompbio/bulk-illumina-rnaseq \
        -c /data1/shahs3/isabl_data_lake/analyses/22/75/42275/iris.config \
        -profile singularity \
        -work-dir /data1/shahs3/isabl_data_lake/analyses/22/75/42275/work \
        -params-file /data1/shahs3/isabl_data_lake/analyses/22/75/42275/nf-params.json \
        --input /data1/shahs3/isabl_data_lake/analyses/22/75/42275/samplesheet.csv \
        -c iris.config \
        -resume \
        --outdir /data1/shahs3/isabl_data_lake/analyses/22/75/42275/results \
        --skip_bbsplit false \
        --bbsplit_fasta_list /data1/shahs3/isabl_data_lake/analyses/22/75/42275/bbsplit_fasta.csv \
        --save_bbsplit_reads \
        -with-report


