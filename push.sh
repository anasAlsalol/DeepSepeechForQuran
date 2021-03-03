git add . 
git commit -m "test"
git push origin quran
paperspace jobs create \
--container "paperspace/tensorflow:1.5.0-gpu" \
--machineType "G1" \
--command "bash test_run.sh" \
--workspace "https://github.com/anasAlsalol/DeepSpeech" \
--workspaceRef "quran" \
--isPreemptible true \
--project "DeepSpeech Model"
