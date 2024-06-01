#!/bin/bash
#SBATCH --partition=componc_cpu,componc_gpu
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00
#SBATCH --mem=40GB
#SBATCH --job-name=seqtk
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=preskaa@mskcc.org
#SBATCH --output=slurm%j_seqtk.out


## activate nf-core conda environment
source /home/preskaa/miniconda3/bin/activate base

## example samplesheet
## technical replicates get merged ...
samplesheet=${HOME}/nanoseq/resources/samplesheet.csv
## specify path to out directory
outdir=/data1/shahs3/users/preskaa/bulk_illumina-rnaseq_test/bbsplit_test
fastqdir=${outdir}/test_fastq

mkdir -p ${fastqdir}

input_fastq=/data1/shahs3/isabl_data_lake/experiments/12/79/21279/data/SHAH_H003460_T01_03_TR01_3ed60869d0ffdf1e_XPRO_0287_T_RNA_IGO_08822_GY_2_S75_R1_001.fastq.gz
output_fastq=${fastqdir}/TCDO-SAR-034-PDX_R1.downsampled.fastq.gz
seqtk sample -s100 ${input_fastq} 0.1 | gzip > ${output_fastq}
## second fastq file ....
input_fastq=/data1/shahs3/isabl_data_lake/experiments/12/79/21279/data/SHAH_H003460_T01_03_TR01_3ed60869d0ffdf1e_XPRO_0287_T_RNA_IGO_08822_GY_2_S75_R2_001.fastq.gz
output_fastq=${fastqdir}/TCDO-SAR-034-PDX_R2.downsampled.fastq.gz
seqtk sample -s100 ${input_fastq} 0.1 | gzip > ${output_fastq}
