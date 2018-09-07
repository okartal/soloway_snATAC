# soloway_snATAC

## Requirements to run the snakemake workflow

1. Ensure that git and conda are installed on your machine.
2. Clone the following git repository:

    ```sh
    git clone https://github.com/r3fang/snATAC.git
3. Clone this repository and checkout the snakemake branch

    ```sh
    git clone https://github.com/okartal/soloway_snATAC.git
    cd soloway_snATAC/
    git checkout --track feature/snakemake-workflow
4. Before running the workflow export the path for snATAC:

    ```sh
    export PATH=$PATH:<path-to-snATAC>/bin/
5. In .test/config.yaml, check correct paths, e.g. to the reference genome, and run the test from the command line:

    ```sh
    cd .test/
    snakemake -pj --use-conda --snakefile ../Snakefile

If the test has worked, you can copy .test/config.yaml and .test/data into your project's working directory and modify the files according to your needs (parameters, barcodes and sequencing units). Then you simply run

   ```sh
   snakemake -pj --use-conda --snakefile <path-to-soloway_snATAC/Snakefile>
