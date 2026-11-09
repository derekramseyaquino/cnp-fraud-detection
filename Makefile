# Variables
COMPETITION := ieee-fraud-detection
RAW_DIR := data/raw
ZIP := $(RAW_DIR)/$(COMPETITION).zip
TRAIN_CSVS := $(RAW_DIR)/train_transaction.csv $(RAW_DIR)/train_identity.csv
TEST_CSVS := $(RAW_DIR)/test_transaction.csv $(RAW_DIR)/test_identity.csv
SAMPLE_CSV := $(RAW_DIR)/sample_submission.csv

# Build all raw data
.PHONY : data
data : $(TRAIN_CSVS)

# Download competition's zip file from Kaggle
$(ZIP) : 
	uv run kaggle competitions download -c $(COMPETITION) -p $(RAW_DIR)

# Extract the zip file
$(TRAIN_CSVS) &: $(ZIP)
	uv run python -m zipfile -e $< $(RAW_DIR)

# Remove raw CSV files
.PHONY : clean
clean :
	rm -f $(TRAIN_CSVS) $(TEST_CSVS) $(SAMPLE_CSV)

# Remove all files
.PHONY : clean-all
clean-all : clean
	rm -f $(ZIP)
