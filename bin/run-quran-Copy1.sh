#!/bin/sh

. venv/deepspeech-train-venv/bin/activate
export PYTHONPATH=./DeepSpeech/training

ALPHABET=${2:-data/alphabet.txt}
SCORER=${3:-german-text-corpus/kenlm.scorer}
PROCESSING_DIR=${4:-deepspeech_processing}
MODELS=${5:-models}

rm -rf deepspeech_processing/summaries
rm -rf deepspeech_processing/checkpoints

python DeepSpeech/DeepSpeech.py --train_files "${1}"/train.csv \
--dev_files "${1}"/dev.csv \
--test_files "${1}"/test.csv \
--alphabet_config_path "${ALPHABET}" \
--scorer "${SCORER}" \
--test_batch_size 36 --train_batch_size 24 --dev_batch_size 36 \
--export_language "de-Latn-DE" --export_license "Apache-2.0" --export_model_name "DeepSpeech German" \
--export_model_version "0.0.5" --export_author_id "deepspeech-german" \
--epochs 75 --learning_rate 0.0005 --dropout_rate 0.40 --export_dir "${MODELS}" -v 1 \
--checkpoint_dir "${PROCESSING_DIR}"/checkpoints --summary_dir "${PROCESSING_DIR}"/summaries




set -xe
if [ ! -f DeepSpeech.py ]; then
    echo "Please make sure you run this from DeepSpeech's top level directory."
    exit 1
fi;

if [ ! -d "${COMPUTE_DATA_DIR}" ]; then
    COMPUTE_DATA_DIR="data/quran"
fi;

# Warn if we can't find the train files
if [ ! -f "${COMPUTE_DATA_DIR}/quran_train.csv" ]; then
    echo "Warning: It looks like you don't have the Quran corpus downloaded"\
         "and preprocessed. Make sure \$COMPUTE_DATA_DIR points to the folder where"\
         "the Quran data is located, and that you ran the" \
         "importer script at bin/import_quran.py before running this script."
fi;

python3 -u DeepSpeech.py \
  --train_files "$COMPUTE_DATA_DIR/quran_train.csv" \
  --dev_files "$COMPUTE_DATA_DIR/quran_dev.csv" \
  --test_files "$COMPUTE_DATA_DIR/quran_test.csv" \
  --alphabet_config_path "$COMPUTE_DATA_DIR/quran-alphabets.txt" \
  --scorer "$COMPUTE_DATA_DIR/lm/quran.scorer" \
  --export_dir "$COMPUTE_DATA_DIR" \
  --train_batch_size 64 \
  --dev_batch_size 64 \
  --test_batch_size 64 \
  --use_allow_growth "true" \
  --noearly_stop \
  --epochs 30 \
  --export_language "ar" \
#  --export_tflite 'true' \
  --n_hidden 1024 \
  --dropout_rate 0.5 \
  --learning_rate 0.0001 \
  --checkpoint_dir "${COMPUTE_DATA_DIR}/checkpoints" \
  --max_to_keep 2 \ 
  "$@"

