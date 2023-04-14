# DDR version checking tool
This tool uses the mbw command to check the version of DDR memory on your machine. Please note that the results may not be completely accurate.

## Usage
```bash
sudo chmod u+x ddr.sh
sudo ./ddr.sh
```

## Dependency
mbw - for memory benchmarking
bc - for numerical comparison

## Sample output
The tool will output one of the following messages:
- DDR3 memory detected
- DDR4 memory detected
- DDR5 memory detected
- Memory type could not be determined
