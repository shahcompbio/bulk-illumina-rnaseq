#!/bin/bash
#SBATCH --partition=componc_cpu,componc_gpu
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --mem=8GB
#SBATCH --job-name=transcripts
#SBATCH --mail-type=END,FAIL
#SBATCH --output=slurm%j_snkmk.out


## activate nf-core conda environment
source /home/preskaa/miniconda3/bin/activate nf-core

## load modules
module load singularity/3.7.1
module load java/11.0.12
## example samplesheet
## technical replicates get merged ...
samplesheet=/data1/shahs3/users/preskaa/APS022_Archive/APS022_samplesheet.csv
## specify path to out directory
outdir=/data1/shahs3/data_lake/...

nextflow run shahcompbio/bulk-illumina-rnaseq \
  -revision 3.14.0 \
  -profile singularity,iris \
  -input ${samplesheet} \
  -c ${PWD}/conf/iris.config \
  -outdir ${outdir} \
  -params-file nf-params.json

