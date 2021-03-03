#!/bin/sh
set -xe
if [ ! -f DeepSpeech.py ]; then
    echo "Please make sure you run this from DeepSpeech's top level directory."
    exit 1
fi;

if [ ! -d "${COMPUTE_DATA_DIR}" ]; then
    COMPUTE_DATA_DIR="../quran_data/quran"
    JOB_DATA_DIR="/artifacts/"
fi;

# Warn if we can't find the train files
if [ ! -f "${COMPUTE_DATA_DIR}/quran_train.csv" ]; then
    echo "Warning: It looks like you don't have the Quran corpus downloaded"\
         "and preprocessed. Make sure \$COMPUTE_DATA_DIR points to the folder where"\
         "the Quran data is located, and that you ran the" \
         "importer script at bin/import_quran.py before running this script."
fi;

for i in 0.0001 0.000001 0.00001 0.001 0.01
do
    python3 -u DeepSpeech.py \
    --train_files "$COMPUTE_DATA_DIR/quran_train_5sec.csv" \
    --dev_files "$COMPUTE_DATA_DIR/quran_dev_5sec.csv" \
    --test_files "$COMPUTE_DATA_DIR/quran_test_5sec.csv" \
    --alphabet_config_path "$COMPUTE_DATA_DIR/lm/quran-alphabets.txt" \
    --scorer "$COMPUTE_DATA_DIR/lm/quran.scorer" \
    --test_batch_size 36 --train_batch_size 24 --dev_batch_size 36 \
    --export_language "ar" --export_license "Apache-2.0" --export_model_name "DeepSpeech Quran" \
    --export_author_id "Anas Alsalool" \
    --epochs 75 --learning_rate $i --dropout_rate 0.25 --export_dir "${JOB_DATA_DIR}"/${i} -v 1 \
    --checkpoint_dir "${JOB_DATA_DIR}"/checkpoints/${i} --summary_dir "${JOB_DATA_DIR}"/summaries/${i} \
     --use_allow_growth "true"  --automatic_mixed_precision "true"
done
 "$@"

